//
//  PieChartRenderer.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 14.11.2024.
//

import SceneKit
import SwiftUI

/// A class responsible for rendering a 3D pie chart in a SceneKit scene.
///
/// The `PieChartRenderer` class implements the `ChartRenderer` protocol, providing the necessary
/// functionality to create and manage a 3D pie chart. This includes generating pie slices, adding
/// labels, and applying styles.
///
/// Example usage:
/// ```swift
/// let data = PieChartData(values: [("Category 1", 40), ("Category 2", 60)])
/// let renderer = PieChartRenderer(data: data!)
/// let scene = renderer.setUpScene()
/// ```
@MainActor
class PieChartRenderer: ChartRenderer {
    
    // MARK: - Properties
    
    /// The chart data used to render the pie chart.
    private let data: PieChartData
    
    /// The main node containing all chart elements.
    let chartNode = SCNNode()
    
    /// The node containing text labels for the chart.
    let textFieldNode = SCNNode()
    
    /// The SceneKit scene in which the pie chart is rendered.
    private let scene = SCNScene()
    
    /// The radius of the pie chart.
    public var radius: Float = 4
    
    /// The style applied to the pie chart.
    private var style: PieChartStyle
    
    // MARK: - Initializer
    
    /// Initializes the `PieChartRenderer` with the provided pie chart data.
    ///
    /// - Parameter data: The `PieChartData` used to create the pie chart.
    required init(data: PieChartData) {
        self.data = data
        self.style = data.pieChartStyle
    }
    
    // MARK: - Methods
    
    /// Sets up the SceneKit scene for the pie chart.
    ///
    /// This method configures the chart's nodes and applies the provided chart data and styles.
    ///
    /// - Returns: The `SCNScene` containing the pie chart.
    func setUpScene() -> SCNScene {
        self.style = data.pieChartStyle
        createPieChart()
        return scene
    }
    
    // MARK: - Private Methods
    
    /// Creates the pie chart by generating slices and adding labels.
    private func createPieChart() {
        for (index, slice) in data.nodes.enumerated() {
            let startAngle = data.angles[index]
            let endAngle = data.angles[index + 1]
            let sliceNode = createPieSlice(
                from: startAngle,
                to: endAngle,
                height: slice.height ?? 1,
                color: slice.color
            )
            chartNode.addChildNode(sliceNode)
            
            if let title = slice.title, !title.isEmpty {
                let labelNode = createLabelNode(text: title, angle: (startAngle + endAngle) / 2, radius: radius)
                textFieldNode.addChildNode(labelNode)
            }
        }
        chartNode.addChildNode(textFieldNode)
        scene.rootNode.addChildNode(chartNode)
    }
    
    /// Creates a single pie slice with the specified parameters.
    ///
    /// - Parameters:
    ///   - startAngle: The starting angle of the slice in radians.
    ///   - endAngle: The ending angle of the slice in radians.
    ///   - height: The height (extrusion depth) of the slice.
    ///   - color: The color of the slice.
    /// - Returns: An `SCNNode` representing the slice.
    private func createPieSlice(from startAngle: CGFloat, to endAngle: CGFloat, height: CGFloat, color: UIColor) -> SCNNode {
        let wedgeGeometry = createHalfCircle(from: startAngle, to: endAngle, radius: CGFloat(self.radius), height: height, color: color)
        let sliceNode = SCNNode(geometry: wedgeGeometry)
        sliceNode.position = SCNVector3(0, 0, height / 2)
        return sliceNode
    }
    
    /// Creates a label node for a pie slice.
    ///
    /// - Parameters:
    ///   - text: The text to display on the label.
    ///   - angle: The angle (in radians) where the label is positioned.
    ///   - radius: The radius at which the label is placed.
    /// - Returns: An `SCNNode` containing the label.
    private func createLabelNode(text: String, angle: CGFloat, radius: Float) -> SCNNode {
        let radiusOffset = radius * 1.2
        let position = SCNVector3(
            radiusOffset * cos(Float(angle)),
            radiusOffset * sin(Float(angle)),
            0
        )
        return LabelGenerator.createLabelNode(text: text, at: position, labelFont: style.labelFont, labelColor: style.labelColor)
    }
    
    /// Creates the geometry for a pie slice using a half-circle path.
    ///
    /// - Parameters:
    ///   - startAngle: The starting angle of the slice in radians.
    ///   - endAngle: The ending angle of the slice in radians.
    ///   - radius: The radius of the pie slice.
    ///   - height: The height (extrusion depth) of the slice.
    ///   - color: The color of the slice.
    /// - Returns: An `SCNShape` representing the 3D pie slice.
    private func createHalfCircle(from startAngle: CGFloat, to endAngle: CGFloat, radius: CGFloat, height: CGFloat, color: UIColor) -> SCNShape {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addArc(withCenter: CGPoint(x: 0, y: 0), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        
        let halfCircle = SCNShape(path: path, extrusionDepth: height)
        halfCircle.firstMaterial?.diffuse.contents = color
        halfCircle.firstMaterial?.isDoubleSided = true
        return halfCircle
    }
}
