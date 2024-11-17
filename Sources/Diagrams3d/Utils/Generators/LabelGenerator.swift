//
//  LabelGenerator.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 15.11.2024.
//

import SceneKit

/// A utility class for generating label nodes in a SceneKit scene.
///
/// The `LabelGenerator` class provides methods for creating 3D text labels (`SCNNode`) with customizable styles.
/// These labels can be positioned within a 3D chart or diagram, using the provided text and position parameters.
@MainActor
class LabelGenerator {
    
    // MARK: - Public Methods
    
    /// Creates a 3D text label (`SCNNode`) at the specified position.
    ///
    /// The label is created with customizable styles and centered around its position.
    ///
    /// Example usage:
    /// ```swift
    /// let labelNode = LabelGenerator.createLabelNode(
    ///     text: "X",
    ///     at: SCNVector3(1, 2, 3),
    ///     labelFont: UIFont.systemFont(ofSize: 12),
    ///     labelColor: .white
    /// )
    /// ```
    ///
    /// - Parameters:
    ///   - text: The text to display in the label.
    ///   - position: The 3D position (`SCNVector3`) of the label in the scene.
    ///   - labelFont: The font to use for the label.
    ///   - labelColor: The color of the label text.
    /// - Returns: An `SCNNode` containing the 3D text label.
    @MainActor
    static func createLabelNode(text: String, at position: SCNVector3, labelFont: UIFont, labelColor: UIColor) -> SCNNode {
        let textGeometry = LabelGenerator.createSCNText(text: text, labelFont: labelFont, labelColor: labelColor)
        let textNode = SCNNode(geometry: textGeometry)
        
        let (minBound, maxBound) = textGeometry.boundingBox
        let textWidth = maxBound.x - minBound.x
        let textHeight = maxBound.y - minBound.y
        textNode.pivot = SCNMatrix4MakeTranslation((textWidth / 2) + minBound.x, (textHeight / 2) + minBound.y, 0)
        textNode.position = position

        return textNode
    }
    
    // MARK: - Private Methods
    
    /// Creates a `SCNText` geometry for the given text with the specified style.
    ///
    /// This method is used internally by `createLabelNode` to generate the geometry for the label.
    ///
    /// - Parameters:
    ///   - text: The string to display as 3D text.
    ///   - labelFont: The font to use for the label.
    ///   - labelColor: The color of the label text.
    /// - Returns: A `SCNText` geometry representing the 3D text.
    @MainActor
    private static func createSCNText(text: String, labelFont: UIFont, labelColor: UIColor) -> SCNText {
        let textGeometry = SCNText(string: text, extrusionDepth: 0.1)
        textGeometry.font = labelFont
        textGeometry.alignmentMode = CATextLayerAlignmentMode.center.rawValue
        textGeometry.firstMaterial?.diffuse.contents = labelColor
        return textGeometry
    }
}
