//
//  AxisGenerator.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 15.11.2024.
//

import SceneKit

/// A class responsible for generating 3D axes in a SceneKit scene.
///
/// The `AxisGenerator` class creates X, Y, and optionally Z axes with labeled endpoints.
/// Each axis consists of a line, an arrowhead, and a label. This is useful for visualizing
/// coordinate systems in 3D charts.
///
/// Example usage:
/// ```swift
/// let scene = SCNScene()
/// let chartNode = SCNNode()
/// let axisGenerator = AxisGenerator(scene: scene, chartNode: chartNode)
/// axisGenerator.addAxes(totalWidth: 10, totalHeight: 10, totalLength: 5)
/// ```
@MainActor
class AxisGenerator {
    
    // MARK: - Properties
    
    /// The thickness of the axes.
    private let thickness: CGFloat
    
    /// The size of the arrowheads on the axes.
    private let arrowSize: CGFloat
    
    /// The font size for the axis labels.
    private let fontSize: CGFloat
    
    /// A multiplier determining the offset for axis labels.
    private let axisOffsetMultiplier: Float = 0.2
    
    /// The SceneKit scene where the axes are rendered.
    private let scene: SCNScene
    
    /// The node where the axes are added.
    private let chartNode: SCNNode
    
    // MARK: - Initializer
    
    /// Initializes the `AxisGenerator` with specified parameters.
    ///
    /// - Parameters:
    ///   - scene: The `SCNScene` where the axes will be added.
    ///   - chartNode: The `SCNNode` that will contain the axes.
    ///   - thickness: The thickness of the axes. Defaults to `0.1`.
    ///   - arrowSize: The size of the arrowheads. Defaults to `0.5`.
    ///   - fontSize: The font size for axis labels. Defaults to `1`.
    init(scene: SCNScene, chartNode: SCNNode, thickness: CGFloat = 0.1, arrowSize: CGFloat = 0.5, fontSize: CGFloat = 1) {
        self.scene = scene
        self.chartNode = chartNode
        self.thickness = thickness
        self.arrowSize = arrowSize
        self.fontSize = fontSize
    }
    
    // MARK: - Public Methods
    
    /// Adds X, Y, and optionally Z axes to the chart with labeled endpoints.
    ///
    /// - Parameters:
    ///   - totalWidth: The total width of the chart, determining the X-axis length.
    ///   - totalHeight: The total height of the chart, determining the Y-axis length.
    ///   - totalLength: The total depth of the chart, determining the Z-axis length. Defaults to `0` for 2D charts.
    internal func addAxes(totalWidth: CGFloat, totalHeight: CGFloat, totalLength: CGFloat = 0) {
        let axisOffset = Float(totalWidth) * axisOffsetMultiplier
        let initPoint = SCNVector3(-totalWidth / 2, -totalHeight / 2, 0)
        
        // Add X-axis
        addAxis(
            in: scene,
            from: initPoint,
            to: SCNVector3(totalWidth / 2 + CGFloat(axisOffset), -totalHeight / 2, 0),
            color: .red,
            label: "X",
            labelOffset: SCNVector3(0, -1, 0)
        )
        // Add Y-axis
        addAxis(
            in: scene,
            from: initPoint,
            to: SCNVector3(-totalWidth / 2, totalHeight / 2 + CGFloat(axisOffset), 0),
            color: .green,
            label: "Y",
            labelOffset: SCNVector3(-1, 0, 0)
        )
        // Add Z-axis (if applicable)
        if totalLength > 0 {
            let zOffset = -(totalLength + totalLength * 0.3)
            addAxis(
                in: scene,
                from: initPoint,
                to: SCNVector3(-totalWidth / 2, -totalHeight / 2, zOffset),
                color: .orange,
                label: "Z",
                labelOffset: SCNVector3(-1, 0, 0)
            )
        }
    }
    
    // MARK: - Private Methods
    
    /// Adds a single axis to the chart.
    ///
    /// - Parameters:
    ///   - scene: The `SCNScene` where the axis will be added.
    ///   - pointA: The starting point of the axis.
    ///   - pointB: The ending point of the axis.
    ///   - color: The color of the axis.
    ///   - label: The label text for the axis.
    ///   - labelOffset: The offset to apply to the label's position.
    private func addAxis(in scene: SCNScene, from pointA: SCNVector3, to pointB: SCNVector3, color: UIColor, label: String, labelOffset: SCNVector3) {
        let axisNode = createAxisNode(from: pointA, to: pointB, color: color)
        let labelNode = createLabelNode(for: label, at: pointB, offset: labelOffset)
        
        chartNode.addChildNode(axisNode)
        chartNode.addChildNode(labelNode)
    }
    
    /// Creates an axis node with a line and arrowhead.
    ///
    /// - Parameters:
    ///   - pointA: The starting point of the axis.
    ///   - pointB: The ending point of the axis.
    ///   - color: The color of the axis.
    /// - Returns: An `SCNNode` containing the axis line and arrowhead.
    private func createAxisNode(from pointA: SCNVector3, to pointB: SCNVector3, color: UIColor) -> SCNNode {
        let axisNode = SCNNode()
        axisNode.addChildNode(createAxisLine(from: pointA, to: pointB, color: color))
        axisNode.addChildNode(createArrowHead(at: pointB, color: color))
        return axisNode
    }
    
    /// Creates a 3D line for an axis.
    ///
    /// - Parameters:
    ///   - pointA: The starting point of the line.
    ///   - pointB: The ending point of the line.
    ///   - color: The color of the line.
    /// - Returns: An `SCNNode` containing the 3D line geometry.
    private func createAxisLine(from pointA: SCNVector3, to pointB: SCNVector3, color: UIColor) -> SCNNode {
        let vector = SCNVector3(pointB.x - pointA.x, pointB.y - pointA.y, pointB.z - pointA.z)
        let distance = sqrt(vector.x * vector.x + vector.y * vector.y + vector.z * vector.z)
        
        let cylinder = SCNCylinder(radius: thickness / 2, height: CGFloat(distance))
        cylinder.firstMaterial?.diffuse.contents = color
        
        let lineNode = SCNNode(geometry: cylinder)
        lineNode.position = SCNVector3((pointA.x + pointB.x) / 2, (pointA.y + pointB.y) / 2, (pointA.z + pointB.z) / 2)
        lineNode.look(at: pointB, up: scene.rootNode.worldUp, localFront: lineNode.worldUp)
        
        return lineNode
    }
    
    /// Creates an arrowhead for an axis.
    ///
    /// - Parameters:
    ///   - point: The position of the arrowhead.
    ///   - color: The color of the arrowhead.
    /// - Returns: An `SCNNode` containing the arrowhead geometry.
    private func createArrowHead(at point: SCNVector3, color: UIColor) -> SCNNode {
        let arrowHead = SCNCone(topRadius: 0, bottomRadius: thickness * 2, height: arrowSize)
        arrowHead.firstMaterial?.diffuse.contents = color
        
        let arrowNode = SCNNode(geometry: arrowHead)
        arrowNode.position = point
        arrowNode.look(at: adjustedTarget(for: point), up: scene.rootNode.worldUp, localFront: arrowNode.worldUp)
        
        return arrowNode
    }
    
    /// Creates a label node for an axis with an offset.
    ///
    /// - Parameters:
    ///   - text: The text for the label.
    ///   - position: The position of the label.
    ///   - offset: The offset to apply to the label's position.
    /// - Returns: An `SCNNode` containing the label.
    private func createLabelNode(for text: String, at position: SCNVector3, offset: SCNVector3) -> SCNNode {
        let adjustedPosition = SCNVector3(position.x + offset.x, position.y + offset.y, position.z + offset.z)
        return LabelGenerator.createLabelNode(text: text, at: adjustedPosition, labelFont: UIFont.systemFont(ofSize: fontSize), labelColor: .black)
    }
    
    /// Determines the largest coordinate value in a point.
    ///
    /// - Parameter point: The `SCNVector3` point to evaluate.
    /// - Returns: The largest coordinate value.
    private func largestCoordinate(of point: SCNVector3) -> Float {
        return max(point.x, point.y, abs(point.z))
    }
    
    /// Adjusts the target position for the arrowhead's orientation.
    ///
    /// - Parameters:
    ///   - point: The current position of the arrowhead.
    ///   - offset: The adjustment offset. Defaults to `1`.
    /// - Returns: The adjusted target position.
    private func adjustedTarget(for point: SCNVector3, offset: Float = 1) -> SCNVector3 {
        let largest = largestCoordinate(of: point)
        switch largest {
        case point.x:
            return SCNVector3(point.x + offset, point.y, point.z)
        case point.y:
            return SCNVector3(point.x, point.y + offset, point.z)
        default:
            return SCNVector3(point.x, point.y, point.z - offset)
        }
    }
}

