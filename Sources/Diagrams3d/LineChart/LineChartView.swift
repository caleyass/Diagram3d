//
//  LineChartView.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 15.11.2024.
//

import SwiftUI
import SceneKit

/// A SwiftUI-compatible view that represents a 3D line chart.
///
/// `LineChartView` bridges SceneKit with SwiftUI using `UIViewRepresentable`,
/// allowing for the rendering of 3D line charts with customizable styles, camera controls,
/// and rotation capabilities.
///
/// Example usage:
/// ```swift
/// let points = [LinePoint(x: 1, y: 2), LinePoint(x: 3, y: 5)]
/// if let lineChart = LineChartView(points: points) {
///     lineChart.setStyle(LineChartStyle.defaultStyle)
/// }
/// ```
public struct LineChartView: UIViewRepresentable {
    
    // MARK: - Properties
    
    /// The data model for the line chart.
    private let data: LineChartData
    
    /// The renderer responsible for generating the 3D chart.
    private var renderer: LineChartRenderer
    
    /// The camera's position within the 3D scene.
    /// Defaults to `(x: 0, y: 0, z: 10)`.
    public var cameraPosition: SCNVector3 = .init(x: 0, y: 0, z: 10)
    
    /// Determines if the user can control the camera with gestures.
    /// Defaults to `true`.
    public var allowCameraControl: Bool = true
    
    /// The style applied to the line chart.
    private var lineChartStyle: LineChartStyle = .init()
    
    // MARK: - Initializers
    
    /// Initializes a `LineChartView` with an array of `LinePoint` values.
    ///
    /// - Parameter points: An array of `LinePoint` values representing the chart's data.
    public init?(points: [LinePoint]) {
        guard let data = LineChartData(points: points) else { return nil }
        self.data = data
        self.renderer = LineChartRenderer(data: data)
    }
    
    /// Initializes a `LineChartView` with an array of y-values.
    ///
    /// - Parameter values: An array of `CGFloat` values representing the y-values of the chart.
    public init?(values: [CGFloat]) {
        guard let data = LineChartData(values: values) else { return nil }
        self.data = data
        self.renderer = LineChartRenderer(data: data)
    }
    
    /// Initializes a `LineChartView` with an array of (x, y) coordinate pairs.
    ///
    /// - Parameter values: An array of tuples containing x and y values.
    public init?(values: [(CGFloat, CGFloat)]) {
        guard let data = LineChartData(values: values) else { return nil }
        self.data = data
        self.renderer = LineChartRenderer(data: data)
    }
    
    /// Initializes a `LineChartView` with an array of (x, y, z) coordinate triples.
    ///
    /// - Parameter values: An array of tuples containing x, y, and z values.
    public init?(values: [(CGFloat, CGFloat, CGFloat)]) {
        guard let data = LineChartData(values: values) else { return nil }
        self.data = data
        self.renderer = LineChartRenderer(data: data)
    }
    
    /// Initializes a `LineChartView` with an array of labeled y-values.
    ///
    /// - Parameter values: An array of tuples containing a label and a y-value.
    public init?(values: [(String, CGFloat)]) {
        let points = values.enumerated().map { (index, value) in
            LinePoint(x: CGFloat(index), y: value.1, title: value.0)
        }
        guard let data = LineChartData(points: points) else { return nil }
        self.data = data
        self.renderer = LineChartRenderer(data: data)
    }
    
    /// Initializes a `LineChartView` with an array of labeled (x, y) coordinate pairs.
    ///
    /// - Parameter values: An array of tuples containing a label, x, and y values.
    public init?(values: [(String, CGFloat, CGFloat)]) {
        let points = values.map { value in
            LinePoint(x: value.1, y: value.2, z: 0, title: value.0)
        }
        guard let data = LineChartData(points: points) else { return nil }
        self.data = data
        self.renderer = LineChartRenderer(data: data)
    }
    
    /// Initializes a `LineChartView` with an array of labeled (x, y, z) coordinate triples.
    ///
    /// - Parameter values: An array of tuples containing a label, x, y, and z values.
    public init?(values: [(String, CGFloat, CGFloat, CGFloat)]) {
        let points = values.map { value in
            LinePoint(x: value.1, y: value.2, z: value.3, title: value.0)
        }
        guard let data = LineChartData(points: points) else { return nil }
        self.data = data
        self.renderer = LineChartRenderer(data: data)
    }
    
    // MARK: - Methods
    
    /// Applies a new style to the line chart.
    ///
    /// - Parameter style: A `LineChartStyle` instance to configure the chart's appearance.
    public mutating func setStyle(_ style: LineChartStyle) {
        lineChartStyle = style
        data.lineChartStyle = style
        renderer = LineChartRenderer(data: data)
    }
    
    /// Creates the SceneKit view for the 3D line chart.
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

        return sceneView
    }
    
    /// Configures the camera for the 3D line chart.
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
    public func updateUIView(_ uiView: SCNView, context: Context) {}
    
    // MARK: - Rotation Methods
    
    /// Rotates the chart by a specified angle in degrees around a given axis.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle in degrees.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) to rotate around.
    public func rotate(byDegrees angle: Float, axis: Axis) {
        renderer.rotate(byDegrees: angle, axis: axis)
    }
    
    /// Rotates the chart by a specified angle in radians around a given axis.
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
    public func rotateText(byDegrees angle: Float, axis: Axis) {
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
