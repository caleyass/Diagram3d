//
//  PieChartView.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 14.11.2024.
//

import UIKit
import SceneKit
import SwiftUI

/// A SwiftUI-compatible view that represents a 3D pie chart.
///
/// This struct uses `UIViewRepresentable` to bridge SceneKit for rendering a 3D pie chart in a SwiftUI environment.
/// The pie chart can be customized with data, styles, camera controls, and rotation functionality.
///
/// Example usage:
/// ```swift
/// let values: [(String, CGFloat, CGFloat)] = [
///     ("Category 1", 30, 5),
///     ("Category 2", 50, 8),
///     ("Category 3", 20, 3)
/// ]
/// if let chartView = PieChartView(values: values)
/// ```
@MainActor
public struct PieChartView: UIViewRepresentable {
    
    // MARK: - Properties
    
    /// The data to be visualized in the pie chart.
    private let data: PieChartData
    
    /// The renderer responsible for creating the SceneKit 3D pie chart scene.
    private var renderer: PieChartRenderer
    
    /// The camera position for the pie chart view.
    /// Defaults to `(x: 0, y: 0, z: 15)`.
    public var cameraPosition: SCNVector3 = .init(x: 0, y: 0, z: 15)
    
    /// A Boolean value that determines whether the user can control the camera.
    /// Defaults to `true`.
    public var allowCameraControl: Bool = true
    
    /// The style configuration for the pie chart.
    private var pieChartStyle: PieChartStyle = .init()
    
    // MARK: - Initializers
    
    /// Initializes a `PieChartView` with labeled data.
    ///
    /// - Parameter values: An array of tuples containing category labels and their corresponding values.
    public init?(values: [(String, CGFloat)]) {
        guard let data = PieChartData(values: values) else { return nil }
        self.data = data
        self.renderer = PieChartRenderer(data: data)
    }
    
    /// Initializes a `PieChartView` with unlabeled data.
    ///
    /// - Parameter values: An array of tuples containing data values.
    public init?(values: [(CGFloat, CGFloat)]) {
        guard let data = PieChartData(values: values) else { return nil }
        self.data = data
        self.renderer = PieChartRenderer(data: data)
    }
    
    /// Initializes a `PieChartView` with labeled data and additional metadata.
    ///
    /// - Parameter values: An array of tuples containing category labels, data values, and metadata values.
    public init?(values: [(String, CGFloat, CGFloat)]) {
        guard let data = PieChartData(values: values) else { return nil }
        self.data = data
        self.renderer = PieChartRenderer(data: data)
    }
    
    // MARK: - UIViewRepresentable
    
    /// Creates the SceneKit view for the 3D pie chart.
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
    
    /// Updates the SceneKit view when the SwiftUI state changes.
    ///
    /// - Parameters:
    ///   - uiView: The `SCNView` instance to update.
    ///   - context: The context for coordinating with the SwiftUI environment.
    public func updateUIView(_ uiView: SCNView, context: Context) {}
    
    // MARK: - Styling
    
    /// Sets the style for the pie chart.
    ///
    /// - Parameter style: A `PieChartStyle` instance to configure the chart's appearance.
    public mutating func setStyle(_ style: PieChartStyle) {
        pieChartStyle = style
        data.pieChartStyle = style
        renderer = PieChartRenderer(data: data)
    }
    
    // MARK: - Camera
    
    /// Configures the camera for the SceneKit scene.
    ///
    /// - Parameter scene: The `SCNScene` where the camera will be added.
    private func setUpCamera(in scene: SCNScene) {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = cameraPosition
        cameraNode.look(at: SCNVector3(0, 0, 0))
        scene.rootNode.addChildNode(cameraNode)
    }
    
    // MARK: - Rotation
    
    /// Rotates the pie chart by a specified angle in degrees.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle in degrees.
    ///   - axis: The axis of rotation.
    public func rotate(byDegrees angle: Float, axis: Axis) {
        renderer.rotate(byDegrees: angle, axis: axis)
    }
    
    /// Rotates the pie chart by a specified angle in radians.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle in radians.
    ///   - axis: The axis of rotation.
    public func rotate(byRadians angle: Float, axis: Axis) {
        renderer.rotate(byRadians: angle, axis: axis)
    }
    
    /// Rotates the text labels on the pie chart by a specified angle in degrees.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle in degrees.
    ///   - axis: The axis of rotation.
    public func rotateText(byDegrees angle: Float, axis: Axis) {
        renderer.rotateText(byDegrees: angle, axis: axis)
    }
    
    /// Rotates the text labels on the pie chart by a specified angle in radians.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle in radians.
    ///   - axis: The axis of rotation.
    public func rotateText(byRadians angle: Float, axis: Axis) {
        renderer.rotateText(byRadians: angle, axis: axis)
    }
}
