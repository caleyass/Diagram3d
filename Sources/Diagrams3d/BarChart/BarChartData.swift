//
//  BarChartData.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 12.11.2024.
//

import CoreFoundation

/// A data model representing the structure and values for a 3D bar chart.
///
/// The `BarChartData` class conforms to the `ChartDataAxis` protocol and provides functionality
/// for managing and processing data used to render a 3D bar chart, including bar dimensions,
/// offsets, and labeled bars.
///
/// Example usage:
/// ```swift
/// let data = BarChartData(values: [(10, 20), (30, 40)])
/// ```
@MainActor
class BarChartData: ChartDataAxis {
    
    // MARK: - Properties
    
    /// The individual nodes (bars) in the chart.
    var nodes: [BarNode]
    
    /// The total width of the chart, calculated based on the number of bars and spacing.
    var totalWidth: CGFloat
    
    /// The total height of the chart, determined by the tallest bar.
    var totalHeight: CGFloat
    
    /// The total depth (length) of the chart, based on the `zValue` of the bars.
    var totalLength: CGFloat

    /// The offset for the x-coordinates to center the chart.
    var xOffset: CGFloat
    
    /// The offset for the y-coordinates to center the chart vertically.
    var yOffset: CGFloat
    
    /// The style applied to the bar chart.
    var barChartStyle: BarChartStyle = .init()
    
    // MARK: - Initializers
    
    /// Initializes the bar chart data with an array of `CGFloat` values.
    ///
    /// - Parameter values: An array of `CGFloat` values representing the heights of the bars.
    required convenience init?(values: [CGFloat]) {
        let barNodes = values.map { BarNode(value: $0) }
        self.init(_barNodes: barNodes)
    }
    
    /// Initializes the bar chart data with an array of labeled values.
    ///
    /// - Parameter values: An array of tuples containing a label and a bar value.
    convenience init?(values: [(String, CGFloat)]) {
        let barNodes = values.map { BarNode(title: $0.0, value: $0.1) }
        self.init(_barNodes: barNodes)
    }
    
    /// Initializes the bar chart data with an array of labeled values and `zValue`.
    ///
    /// - Parameter values: An array of tuples containing a label, a bar value, and a `zValue`.
    convenience init?(values: [(String, CGFloat, CGFloat)]) {
        let barNodes = values.map { BarNode(title: $0.0, value: $0.1, zValue: $0.2) }
        self.init(_barNodes: barNodes)
    }
    
    /// Initializes the bar chart data with a direct array of `BarNode` objects.
    ///
    /// - Parameter barNodes: An array of `BarNode` objects representing the bars.
    convenience init?(barNodes: [BarNode]) {
        self.init(_barNodes: barNodes)
    }
    
    // MARK: - Private Initializer
    
    /// A private initializer to handle repetitive setup logic for the bar chart.
    ///
    /// - Parameter _barNodes: An array of `BarNode` objects representing the bars.
    private init?(_barNodes: [BarNode]) {
        guard let maxNode = _barNodes.max(by: { $0.value < $1.value }) else { return nil }

        self.nodes = _barNodes
        self.totalHeight = maxNode.value
        self.totalWidth = CGFloat(nodes.count) * barChartStyle.nodeWidth + CGFloat(nodes.count - 1) * barChartStyle.nodeSpacing
        self.xOffset = -totalWidth / 2.0 + barChartStyle.nodeWidth / 2.0
        self.yOffset = -maxNode.value / 2.0
        
        self.totalLength = (_barNodes.compactMap { $0.zValue }.max() ?? 0) * barChartStyle.nodeWidth
    }
}

/// A data structure representing an individual bar in a 3D bar chart.
///
/// Each `BarNode` includes optional title information, a value representing the bar height,
/// and an optional `zValue` for depth positioning.
///
/// Example usage:
/// ```swift
/// let node = BarNode(title: "Bar A", value: 10, zValue: 5)
/// ```
@MainActor
public struct BarNode {
    
    // MARK: - Properties
    
    /// The title of the bar (optional).
    var title: String?
    
    /// The height of the bar.
    var value: CGFloat
    
    /// The depth position of the bar (optional).
    var zValue: CGFloat?
}
