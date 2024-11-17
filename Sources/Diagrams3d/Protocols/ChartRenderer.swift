//
//  ChartRenderer.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 14.11.2024.
//

import SceneKit

/// A protocol that defines the responsibilities of a 3D chart renderer.
///
/// The `ChartRenderer` protocol inherits from `RotatableChart` to enable rotation capabilities
/// and specifies the required properties and methods for rendering 3D charts. It uses
/// associated types to work with different chart data types.
///
/// Example usage:
/// ```swift
/// struct MyChartData: ChartData {
///     // Implementation of chart data structure
/// }
///
/// class MyChartRenderer: ChartRenderer {
///     typealias ChartDataType = MyChartData
///
///     var chartNode: SCNNode = SCNNode()
///     var textFieldNode: SCNNode = SCNNode()
///
///     required init(data: MyChartData) {
///         // Initialize with chart data
///     }
///
///     func setUpScene() -> SCNScene {
///         let scene = SCNScene()
///         // Configure the scene with chartNode and other components
///         return scene
///     }
/// }
/// ```
@MainActor
protocol ChartRenderer: RotatableChart {
    
    // MARK: - Associated Types
    
    /// The type of data used to render the chart.
    associatedtype ChartDataType: ChartData
    
    // MARK: - Properties
    
    /// The main node representing the 3D chart.
    var chartNode: SCNNode { get }
    
    /// The node containing text labels for the chart.
    var textFieldNode: SCNNode { get }
    
    // MARK: - Initializer
    
    /// Initializes the chart renderer with the provided data.
    ///
    /// - Parameter data: The data used to render the chart.
    init(data: ChartDataType)
    
    // MARK: - Methods
    
    /// Sets up and returns the 3D scene for the chart.
    ///
    /// This method configures the `SCNScene` with the necessary chart components,
    /// such as the chart node and any additional elements.
    ///
    /// - Returns: An `SCNScene` instance representing the 3D chart scene.
    func setUpScene() -> SCNScene
}


