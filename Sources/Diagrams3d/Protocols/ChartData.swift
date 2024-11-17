//
//  ChartData.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 14.11.2024.
//

import UIKit

/// A protocol representing the underlying data structure for a chart.
///
/// The `ChartData` protocol defines the requirements for chart data models,
/// including a collection of data nodes and an initializer for populating the data.
///
/// Example usage:
/// ```swift
/// struct MyChartData: ChartData {
///     typealias DataNode = Float
///     var nodes: [DataNode]
///
///     init?(values: [CGFloat]) {
///         self.nodes = values.map { Float($0) }
///     }
/// }
/// ```
@MainActor
protocol ChartData {
    
    // MARK: - Associated Types
    
    /// The type of data node used in the chart data structure.
    associatedtype DataNode
    
    // MARK: - Properties
    
    /// A collection of data nodes used in the chart.
    var nodes: [DataNode] { get }
    
    // MARK: - Initializer
    
    /// Initializes a new chart data instance with the given values.
    ///
    /// - Parameter values: An array of `CGFloat` values representing the chart's data.
    /// - Returns: A new chart data instance, or `nil` if initialization fails.
    init?(values: [CGFloat])
}

/// A protocol that extends `ChartData` to include axis-related properties.
///
/// The `ChartDataAxis` protocol is designed for chart data models that
/// require information about the dimensions of the chart and offsets for positioning.
///
/// Example usage:
/// ```swift
/// struct MyChartDataAxis: ChartDataAxis {
///     typealias DataNode = Float
///     var nodes: [DataNode]
///
///     var totalWidth: CGFloat
///     var totalHeight: CGFloat
///     var totalLength: CGFloat
///
///     var xOffset: CGFloat
///     var yOffset: CGFloat
///
///     init?(values: [CGFloat]) {
///         guard !values.isEmpty else { return nil }
///         self.nodes = values.map { Float($0) }
///         self.totalWidth = 100
///         self.totalHeight = 50
///         self.totalLength = 20
///         self.xOffset = 10
///         self.yOffset = 5
///     }
/// }
/// ```
@MainActor
protocol ChartDataAxis: ChartData {

    // MARK: - Axis Properties
    
    /// The total width of the chart.
    var totalWidth: CGFloat { get }
    
    /// The total height of the chart.
    var totalHeight: CGFloat { get }
    
    /// The total length (depth) of the chart.
    var totalLength: CGFloat { get }
    
    /// The offset for the X-axis.
    var xOffset: CGFloat { get }
    
    /// The offset for the Y-axis.
    var yOffset: CGFloat { get }
}

