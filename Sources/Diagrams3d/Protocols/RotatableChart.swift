//
//  RotatableChart.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 12.11.2024.
//
import SceneKit

/// A protocol that defines rotation capabilities for 3D charts.
///
/// The `RotatableChart` protocol provides methods for rotating the entire chart and
/// its text labels around specified axes. Implementing this protocol allows charts to
/// support rotations by degrees or radians.
///
/// Example usage:
/// ```swift
/// let chart: RotatableChart = SomeChartImplementation()
/// chart.rotate(byDegrees: 45, axis: .x) // Rotates the chart 45 degrees around the X-axis.
/// chart.rotateText(byRadians: .pi / 2, axis: .y) // Rotates the text labels 90 degrees around the Y-axis.
/// ```
@MainActor
protocol RotatableChart {
    
    /// Rotates the chart by a specified angle in degrees around a given axis.
    ///
    /// - Parameters:
    ///   - angle: The angle in degrees to rotate.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) around which the rotation occurs.
    func rotate(byDegrees angle: Float, axis: Axis)
    
    /// Rotates the chart by a specified angle in radians around a given axis.
    ///
    /// - Parameters:
    ///   - angle: The angle in radians to rotate.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) around which the rotation occurs.
    func rotate(byRadians angle: Float, axis: Axis)
    
    /// Rotates the chart's text labels by a specified angle in degrees around a given axis.
    ///
    /// - Parameters:
    ///   - angle: The angle in degrees to rotate the text labels.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) around which the rotation occurs.
    func rotateText(byDegrees angle: Float, axis: Axis)
    
    /// Rotates the chart's text labels by a specified angle in radians around a given axis.
    ///
    /// - Parameters:
    ///   - angle: The angle in radians to rotate the text labels.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) around which the rotation occurs.
    func rotateText(byRadians angle: Float, axis: Axis)
}

/// Default implementations of the `RotatableChart` protocol.
///
/// This extension provides default functionality for rotating charts and text labels,
/// including the conversion between degrees and radians.
@MainActor
extension RotatableChart {
    
    /// Rotates the chart by a specified angle in degrees around a given axis.
    ///
    /// The implementation converts degrees to radians and calls the `rotate(byRadians:axis:)` method.
    ///
    /// - Parameters:
    ///   - angle: The angle in degrees to rotate.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) around which the rotation occurs.
    func rotate(byDegrees angle: Float, axis: Axis) {
        let radians = angle * .pi / 180.0
        rotate(byRadians: radians, axis: axis)
    }
    
    /// Rotates the chart by a specified angle in radians around a given axis.
    ///
    /// Updates the `eulerAngles` of the chart node based on the specified axis and angle.
    ///
    /// - Parameters:
    ///   - angle: The angle in radians to rotate.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) around which the rotation occurs.
    func rotate(byRadians angle: Float, axis: Axis) {
        let vectorAxis = SCNVector3(axis == .x ? 1 : 0, axis == .y ? 1 : 0, axis == .z ? 1 : 0)
        
        if let chartNode = self as? (any ChartRenderer) {
            chartNode.chartNode.eulerAngles = SCNVector3(
                chartNode.chartNode.eulerAngles.x + Float(vectorAxis.x * angle),
                chartNode.chartNode.eulerAngles.y + Float(vectorAxis.y * angle),
                chartNode.chartNode.eulerAngles.z + Float(vectorAxis.z * angle)
            )
        }
    }
    
    /// Rotates the chart's text labels by a specified angle in degrees around a given axis.
    ///
    /// The implementation converts degrees to radians and calls the `rotateText(byRadians:axis:)` method.
    ///
    /// - Parameters:
    ///   - angle: The angle in degrees to rotate the text labels.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) around which the rotation occurs.
    func rotateText(byDegrees angle: Float, axis: Axis) {
        let radians = angle * .pi / 180.0
        rotateText(byRadians: radians, axis: axis)
    }
    
    /// Rotates the chart's text labels by a specified angle in radians around a given axis.
    ///
    /// Updates the `eulerAngles` of each text label node based on the specified axis and angle.
    ///
    /// - Parameters:
    ///   - angle: The angle in radians to rotate the text labels.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) around which the rotation occurs.
    func rotateText(byRadians angle: Float, axis: Axis) {
        let vectorAxis = SCNVector3(axis == .x ? 1 : 0, axis == .y ? 1 : 0, axis == .z ? 1 : 0)
        
        if let chartNode = self as? (any ChartRenderer) {
            for node in chartNode.textFieldNode.childNodes {
                node.eulerAngles = SCNVector3(
                    node.eulerAngles.x + Float(vectorAxis.x * angle),
                    node.eulerAngles.y + Float(vectorAxis.y * angle),
                    node.eulerAngles.z + Float(vectorAxis.z * angle)
                )
            }
        }
    }
}
