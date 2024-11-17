//
//  BarChart.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 09.11.2024.
//

import SwiftUI
import SceneKit

/// A SwiftUI-compatible view that represents a 3D bar chart.
///
/// `BarChartView` bridges SceneKit with SwiftUI using `UIViewRepresentable`,
/// allowing for the rendering of 3D bar charts with customizable styles, camera controls,
/// and rotation capabilities.
///
/// Example usage:
/// ```swift
/// let values: [CGFloat] = [10, 20, 30]
/// if let barChart = BarChartView(values: values) {
///     barChart.setStyle(BarChartStyle.defaultStyle)
/// }
/// ```
public struct BarChartView: UIViewRepresentable {
    
    // MARK: - Properties
    
    /// The data model for the bar chart.
    private let data: BarChartData
    
    /// The renderer responsible for generating the 3D bar chart.
    private var renderer: BarChartRenderer
    
    /// The camera's position within the 3D scene.
    /// Defaults to `(x: 0, y: 0, z: 15)`.
    public var cameraPosition: SCNVector3 = .init(x: 0, y: 0, z: 15)
    
    /// Determines if the user can control the camera with gestures.
    /// Defaults to `true`.
    public var allowCameraControl: Bool = true
    
    /// The style applied to the bar chart.
    private var barChartStyle: BarChartStyle = .init()
    
    /// The rotation angle for the chart in degrees.
    private var rotationAngle: Float = 0
    
    /// The rotation angle for the text in degrees.
    private var rotationAngleText: Float = 0
    
    /// Tracks whether the SceneKit scene has been initialized.
    @State private var isSceneInitialized: Bool = false
    
    // MARK: - Initializers
    
    /// Initializes a `BarChartView` with an array of bar values.
    ///
    /// - Parameter values: An array of `CGFloat` values representing the heights of the bars.
    public init?(values: [CGFloat]) {
        guard let data = BarChartData(values: values) else { return nil }
        self.data = data
        self.renderer = BarChartRenderer(data: data)
    }
    
    /// Initializes a `BarChartView` with an array of labeled bar values.
    ///
    /// - Parameter values: An array of tuples containing a label and a bar value.
    public init?(values: [(String, CGFloat)]) {
        guard let data = BarChartData(values: values) else { return nil }
        self.data = data
        self.renderer = BarChartRenderer(data: data)
    }
    
    /// Initializes a `BarChartView` with an array of labeled bar values and bar heights.
    ///
    /// - Parameter values: An array of tuples containing a label, a bar value, and a bar height.
    public init?(values: [(String, CGFloat, CGFloat)]) {
        guard let data = BarChartData(values: values) else { return nil }
        self.data = data
        self.renderer = BarChartRenderer(data: data)
    }
    
    /// Initializes a `BarChartView` with an array of `BarNode` values.
    ///
    /// - Parameter barNodes: An array of `BarNode` objects.
    public init?(barNodes: [BarNode]) {
        guard let data = BarChartData(values: barNodes.map { $0.value }) else { return nil }
        self.data = data
        self.renderer = BarChartRenderer(data: data)
    }
    
    // MARK: - Methods
    
    /// Applies a new style to the bar chart.
    ///
    /// - Parameter style: A `BarChartStyle` instance to configure the chart's appearance.
    public mutating func setStyle(_ style: BarChartStyle) {
        barChartStyle = style
        data.barChartStyle = style
        renderer = BarChartRenderer(data: data)
    }
    
    /// Creates the SceneKit view for the 3D bar chart.
    ///
    /// - Parameter context: The context for coordinating with the SwiftUI environment.
    /// - Returns: A configured `SCNView` instance.
    public func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.allowsCameraControl = allowCameraControl
        sceneView.autoenablesDefaultLighting = true

        let scene = renderer.setUpScene()
        sceneView.scene = scene
        setUpCamera(in: scene)
        
        DispatchQueue.main.async {
            self.isSceneInitialized = true
        }

        return sceneView
    }
    
    /// Configures the camera for the 3D bar chart.
    ///
    /// - Parameter scene: The `SCNScene` where the camera will be added.
    private func setUpCamera(in scene: SCNScene) {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = cameraPosition
        cameraNode.look(at: SCNVector3(x: 0, y: 0, z: 0))
        scene.rootNode.addChildNode(cameraNode)
    }
    
    /// Updates the SceneKit view when the SwiftUI state changes.
    ///
    /// - Parameters:
    ///   - uiView: The `SCNView` instance to update.
    ///   - context: The context for coordinating with the SwiftUI environment.
    public func updateUIView(_ uiView: SCNView, context: Context) {
        uiView.scene = renderer.setUpScene()
        if let scene = uiView.scene {
            setUpCamera(in: scene)
        }
        uiView.allowsCameraControl = allowCameraControl
        
        if isSceneInitialized {
            renderer.rotateText(byDegrees: -90, axis: .z)
            isSceneInitialized = false // Prevent repeated updates
        }
    }
    
    /// Rotates the bar chart by a specified angle in degrees around a given axis.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle in degrees.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) to rotate around.
    public mutating func rotate(byDegrees angle: Float, axis: Axis) {
        rotationAngle = angle
        renderer.rotate(byDegrees: angle, axis: axis)
    }
    
    /// Rotates the bar chart by a specified angle in radians around a given axis.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle in radians.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) to rotate around.
    public func rotate(byRadians angle: Float, axis: Axis) {
        renderer.rotate(byRadians: angle, axis: axis)
    }
    
    /// Rotates the text labels by a specified angle in degrees around a given axis.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle in degrees.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) to rotate around.
    public mutating func rotateText(byDegrees angle: Float, axis: Axis) {
        rotationAngle = angle
        renderer.rotateText(byDegrees: angle, axis: axis)
    }
    
    /// Rotates the text labels by a specified angle in radians around a given axis.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle in radians.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) to rotate around.
    public func rotateText(byRadians angle: Float, axis: Axis) {
        renderer.rotateText(byRadians: angle, axis: axis)
    }
}
