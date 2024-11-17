//
//  LineChartRenderer.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 15.11.2024.
//
import SceneKit


/// A class responsible for rendering a 3D line chart in a SceneKit scene.
///
/// The `LineChartRenderer` class implements the `ChartRenderer` protocol, providing
/// the functionality for constructing and visualizing a 3D line chart with axis, labels,
/// and connecting lines between points.
///
/// Example usage:
/// ```swift
/// let data = LineChartData(values: [(0, 1), (2, 3), (4, 5)])
/// let renderer = LineChartRenderer(data: data!)
/// let scene = renderer.setUpScene()
/// ```
@MainActor
class LineChartRenderer: ChartRenderer {
    
    // MARK: - Properties
    
    /// The data used to render the line chart.
    private let data: LineChartData
    
    /// The root node containing all chart elements.
    let chartNode = SCNNode()
    
    /// The node containing text labels for the chart.
    let textFieldNode = SCNNode()
    
    /// The SceneKit scene in which the line chart is rendered.
    private let scene = SCNScene()
    
    /// The generator for creating 3D axes.
    private var axisGenerator: AxisGenerator
    
    /// The style applied to the line chart.
    private var style: LineChartStyle
    
    // MARK: - Initializer
    
    /// Initializes the renderer with the given line chart data.
    ///
    /// - Parameter data: The `LineChartData` used to render the chart.
    required init(data: LineChartData) {
        self.data = data
        self.style = data.lineChartStyle
        axisGenerator = AxisGenerator(
            scene: scene,
            chartNode: chartNode,
            thickness: style.axisThickness,
            arrowSize: style.axisArrowSize,
            fontSize: style.labelFont.pointSize
        )
    }
    
    // MARK: - Methods
    
    /// Sets up the SceneKit scene for the line chart.
    ///
    /// This method configures the chart's nodes, axes, and labels based on the provided data and style.
    ///
    /// - Returns: The `SCNScene` containing the fully constructed 3D line chart.
    func setUpScene() -> SCNScene {
        self.style = data.lineChartStyle
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
    
    /// Creates the line chart by connecting data points with lines and adding labels.
    private func createChart() {
        // Connect consecutive points with lines
        for i in 0..<(data.nodes.count - 1) {
            let start = data.nodes[i]
            let end = data.nodes[i + 1]
            let lineNode = createLine(from: start, to: end)
            chartNode.addChildNode(lineNode)
        }
        
        // Add labels for each point
        for point in data.nodes {
            if let label = point.title {
                let labelNode = LabelGenerator.createLabelNode(
                    text: label,
                    at: SCNVector3(
                        point.x - data.xOffset,
                        point.y + 1 - data.yOffset,
                        -point.z + data.zOffset
                    ),
                    labelFont: style.labelFont,
                    labelColor: style.labelColor
                )
                textFieldNode.addChildNode(labelNode)
            }
        }
        
        chartNode.addChildNode(textFieldNode)
        scene.rootNode.addChildNode(chartNode)
    }
    
    /// Creates a line segment between two points.
    ///
    /// - Parameters:
    ///   - start: The starting `LinePoint` of the segment.
    ///   - end: The ending `LinePoint` of the segment.
    /// - Returns: An `SCNNode` representing the line segment.
    private func createLine(from start: LinePoint, to end: LinePoint) -> SCNNode {
        let startPoint = SCNVector3(
            Float(start.x - data.xOffset),
            Float(start.y - data.yOffset),
            Float(-start.z + data.zOffset)
        )
        let endPoint = SCNVector3(
            Float(end.x - data.xOffset),
            Float(end.y - data.yOffset),
            Float(-end.z + data.zOffset)
        )
        return createLineGeometry(
            from: startPoint,
            to: endPoint,
            thickness: style.lineThickness,
            color: style.lineColor
        )
    }
    
    /// Creates the geometry for a 3D line segment.
    ///
    /// - Parameters:
    ///   - start: The starting point of the line segment.
    ///   - end: The ending point of the line segment.
    ///   - thickness: The thickness of the line.
    ///   - color: The color of the line.
    /// - Returns: An `SCNNode` containing the 3D line geometry.
    private func createLineGeometry(from start: SCNVector3, to end: SCNVector3, thickness: CGFloat, color: UIColor) -> SCNNode {
        let vector = SCNVector3(
            end.x - start.x,
            end.y - start.y,
            end.z - start.z
        )
        let distance = sqrt(
            vector.x * vector.x +
            vector.y * vector.y +
            vector.z * vector.z
        )
        
        let cylinder = SCNCylinder(radius: thickness, height: CGFloat(distance))
        cylinder.firstMaterial?.diffuse.contents = color
        
        let lineNode = SCNNode(geometry: cylinder)
        lineNode.position = SCNVector3(
            (start.x + end.x) / 2,
            (start.y + end.y) / 2,
            (start.z + end.z) / 2
        )
        
        lineNode.look(at: end, up: scene.rootNode.worldUp, localFront: lineNode.worldUp)
        return lineNode
    }
}
