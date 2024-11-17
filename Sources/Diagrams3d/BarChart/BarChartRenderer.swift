//
//  BarChartRenderer.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 12.11.2024.
//
import SwiftUI
import SceneKit

/// A class responsible for rendering a 3D bar chart in a SceneKit scene.
///
/// The `BarChartRenderer` class implements the `ChartRenderer` protocol, providing
/// the functionality for constructing and visualizing a 3D bar chart with bars, axis,
/// and optional labels.
///
/// Example usage:
/// ```swift
/// let data = BarChartData(values: [("A", 10), ("B", 15), ("C", 20)])
/// let renderer = BarChartRenderer(data: data!)
/// let scene = renderer.setUpScene()
/// ```
@MainActor
class BarChartRenderer: ChartRenderer {
    
    // MARK: - Properties
    
    /// The data used to render the bar chart.
    private let data: BarChartData
    
    /// The main node containing the chart elements.
    internal let chartNode = SCNNode()
    
    /// The node containing text labels for the chart.
    internal let textFieldNode = SCNNode()
    
    /// The SceneKit scene in which the bar chart is rendered.
    private let scene = SCNScene()
    
    /// The generator for creating 3D axes.
    private var axisGenerator: AxisGenerator
    
    /// The style applied to the bar chart.
    private var style: BarChartStyle

    // MARK: - Initializer
    
    /// Initializes the renderer with the given bar chart data.
    ///
    /// - Parameter data: The `BarChartData` used to render the chart.
    required init(data: BarChartData) {
        self.data = data
        style = data.barChartStyle
        axisGenerator = AxisGenerator(
            scene: scene,
            chartNode: chartNode,
            thickness: style.axisThickness,
            arrowSize: style.axisArrowSize,
            fontSize: style.labelFont.pointSize
        )
    }
    
    // MARK: - Methods
    
    /// Sets up the SceneKit scene for the bar chart.
    ///
    /// This method configures the chart's nodes, bars, and axes based on the provided data and style.
    ///
    /// - Returns: The `SCNScene` containing the fully constructed 3D bar chart.
    func setUpScene() -> SCNScene {
        style = data.barChartStyle
        axisGenerator = AxisGenerator(
            scene: scene,
            chartNode: chartNode,
            thickness: style.axisThickness,
            arrowSize: style.axisArrowSize,
            fontSize: style.labelFont.pointSize
        )
        createChart()
        axisGenerator.addAxes(
            totalWidth: data.totalWidth,
            totalHeight: data.totalHeight,
            totalLength: data.totalLength
        )
        return scene
    }
    
    // MARK: - Private Methods
    
    /// Creates the bar chart by adding bars and labels to the scene.
    private func createChart() {
        for (index, node) in data.nodes.enumerated() {
            let barNode = createBarNode(for: node, at: index)
            chartNode.addChildNode(barNode)
            
            if let title = node.title {
                let labelNode = createLabelNode(text: title, at: index)
                textFieldNode.addChildNode(labelNode)
            }
        }
        chartNode.addChildNode(textFieldNode)
        scene.rootNode.addChildNode(chartNode)
    }

    /// Creates a 3D bar node for the chart.
    ///
    /// - Parameters:
    ///   - node: The `BarNode` object representing the bar.
    ///   - index: The index of the bar in the chart.
    /// - Returns: An `SCNNode` representing the 3D bar.
    private func createBarNode(for node: BarNode, at index: Int) -> SCNNode {
        let style = data.barChartStyle
        let length = node.zValue ?? style.nodeWidth
        let barGeometry = SCNBox(
            width: style.nodeWidth,
            height: node.value,
            length: length,
            chamferRadius: style.chamferRadius
        )
        let barNode = SCNNode(geometry: barGeometry)
        
        let xPosition = data.xOffset + CGFloat(index) * (style.nodeWidth + style.nodeSpacing)
        barNode.position = SCNVector3(
            x: Float(xPosition),
            y: Float(data.yOffset + node.value / 2.0),
            z: Float(-length) / 2
        )
        barGeometry.firstMaterial?.diffuse.contents = style.nodeColor
        
        return barNode
    }

    /// Creates a label node for a bar in the chart.
    ///
    /// - Parameters:
    ///   - text: The text for the label.
    ///   - index: The index of the bar in the chart.
    /// - Returns: An `SCNNode` representing the label.
    private func createLabelNode(text: String, at index: Int) -> SCNNode {
        let style = data.barChartStyle

        let xPosition = data.xOffset + CGFloat(index) * (style.nodeWidth + style.nodeSpacing)
        return LabelGenerator.createLabelNode(
            text: text,
            at: SCNVector3(
                x: Float(xPosition),
                y: Float(-data.totalHeight),
                z: 0
            ),
            labelFont: style.labelFont,
            labelColor: style.labelColor
        )
    }
}
