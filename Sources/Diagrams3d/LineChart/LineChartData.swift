//
//  LineChartData.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 15.11.2024.
//

import SceneKit
import UIKit

/// A data model representing the structure and values for a 3D line chart.
///
/// The `LineChartData` class conforms to the `ChartDataAxis` protocol and provides functionality
/// for managing and processing data used to render a 3D line chart. It includes properties for
/// determining the chart's dimensions, offsets, and points.
///
/// Example usage:
/// ```swift
/// let data = LineChartData(values: [(0, 1), (2, 3), (4, 5)])
/// ```
@MainActor
class LineChartData: ChartDataAxis {
    
    // MARK: - Properties
    
    /// The individual points that make up the chart.
    var nodes: [LinePoint]
    
    /// The total width of the chart, calculated from the x-coordinates.
    var totalWidth: CGFloat
    
    /// The total height of the chart, calculated from the y-coordinates.
    var totalHeight: CGFloat
    
    /// The total length (depth) of the chart, calculated from the z-coordinates.
    var totalLength: CGFloat

    /// The offset for the x-coordinates to center the chart.
    var xOffset: CGFloat
    
    /// The offset for the y-coordinates to center the chart.
    var yOffset: CGFloat
    
    /// The offset for the z-coordinates to center the chart.
    var zOffset: CGFloat

    /// The style applied to the line chart.
    var lineChartStyle: LineChartStyle = .init()
    
    // MARK: - Initializers
    
    /// Initializes the line chart data with an array of `LinePoint` objects.
    ///
    /// - Parameter points: An array of `LinePoint` objects representing the chart's data.
    init?(points: [LinePoint]) {
        self.nodes = points
        
        let minX = LineChartData.calculateMinValue(for: points, in: .x)
        let minY = LineChartData.calculateMinValue(for: points, in: .y)
        let minZ = LineChartData.calculateMinValue(for: points, in: .z)
        
        self.totalWidth = LineChartData.calculateMaxValue(for: points, in: .x) - minX
        self.totalHeight = LineChartData.calculateMaxValue(for: points, in: .y) - minY
        self.totalLength = LineChartData.calculateMaxValue(for: points, in: .z) - minZ
        
        self.xOffset = totalWidth / 2 + minX
        self.yOffset = totalHeight / 2 + minY
        self.zOffset = minZ
    }
    
    /// Initializes the line chart data with an array of y-values.
    ///
    /// - Parameter values: An array of `CGFloat` values representing the y-coordinates.
    required convenience init?(values: [CGFloat]) {
        let points = values.enumerated().map { index, yValue in
            LinePoint(x: CGFloat(index), y: yValue)
        }
        self.init(points: points)
    }
    
    /// Initializes the line chart data with an array of (x, y) coordinate pairs.
    ///
    /// - Parameter values: An array of tuples containing x and y values.
    required convenience init?(values: [(CGFloat, CGFloat)]) {
        let points = values.map { value in
            LinePoint(x: value.0, y: value.1)
        }
        self.init(points: points)
    }
    
    /// Initializes the line chart data with an array of (x, y, z) coordinate triples.
    ///
    /// - Parameter values: An array of tuples containing x, y, and z values.
    required convenience init?(values: [(CGFloat, CGFloat, CGFloat)]) {
        let points = values.map { value in
            LinePoint(x: value.0, y: value.1, z: value.2)
        }
        self.init(points: points)
    }
    
    /// Initializes the line chart data with an array of labeled y-values.
    ///
    /// - Parameter values: An array of tuples containing a label and a y-value.
    required convenience init?(values: [(String, CGFloat)]) {
        let points = values.enumerated().map { (index, value) in
            LinePoint(x: CGFloat(index), y: value.1, title: value.0)
        }
        self.init(points: points)
    }

    /// Initializes the line chart data with an array of labeled (x, y) coordinate pairs.
    ///
    /// - Parameter values: An array of tuples containing a label, x, and y values.
    required convenience init?(values: [(String, CGFloat, CGFloat)]) {
        let points = values.map { value in
            LinePoint(x: value.1, y: value.2, z: 0, title: value.0)
        }
        self.init(points: points)
    }
    
    /// Initializes the line chart data with an array of labeled (x, y, z) coordinate triples.
    ///
    /// - Parameter values: An array of tuples containing a label, x, y, and z values.
    required convenience init?(values: [(String, CGFloat, CGFloat, CGFloat)]) {
        let points = values.map { value in
            LinePoint(x: value.1, y: value.2, z: value.3, title: value.0)
        }
        self.init(points: points)
    }
    
    // MARK: - Helper Methods
    
    /// Calculates the maximum value for a specified axis among the given points.
    ///
    /// - Parameters:
    ///   - points: An array of `LinePoint` objects.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) for which to calculate the maximum value.
    /// - Returns: The maximum value along the specified axis.
    private static func calculateMaxValue(for points: [LinePoint], in axis: Axis) -> CGFloat {
        return switch axis {
        case .x: points.max(by: { $0.x < $1.x })?.x ?? 0
        case .y: points.max(by: { $0.y < $1.y })?.y ?? 0
        case .z: points.max(by: { $0.z < $1.z })?.z ?? 0
        }
    }
    
    /// Calculates the minimum value for a specified axis among the given points.
    ///
    /// - Parameters:
    ///   - points: An array of `LinePoint` objects.
    ///   - axis: The axis (`.x`, `.y`, or `.z`) for which to calculate the minimum value.
    /// - Returns: The minimum value along the specified axis.
    private static func calculateMinValue(for points: [LinePoint], in axis: Axis) -> CGFloat {
        return switch axis {
        case .x: points.min(by: { $0.x < $1.x })?.x ?? 0
        case .y: points.min(by: { $0.y < $1.y })?.y ?? 0
        case .z: points.min(by: { $0.z < $1.z })?.z ?? 0
        }
    }
}

/// A data structure representing a single point in a 3D line chart.
///
/// Each `LinePoint` includes x, y, and optional z coordinates, as well as an optional title for labeling.
///
/// Example usage:
/// ```swift
/// let point = LinePoint(x: 1.0, y: 2.0, z: 3.0, title: "Point A")
/// ```
@MainActor
public struct LinePoint {
    
    // MARK: - Properties
    
    /// The x-coordinate of the point.
    var x: CGFloat
    
    /// The y-coordinate of the point.
    var y: CGFloat
    
    /// The z-coordinate of the point. Defaults to `0`.
    var z: CGFloat = 0

    /// The title of the point (optional).
    var title: String?
}
