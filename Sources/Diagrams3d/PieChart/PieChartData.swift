//
//  PieChartData.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 14.11.2024.
//

import SceneKit
import SwiftUI

/// A data model representing the structure and values of a pie chart.
///
/// The `PieChartData` class conforms to the `ChartData` protocol and provides functionality
/// for managing and processing data used to render a 3D pie chart, including calculating
/// slice angles and handling multiple initializer formats.
///
/// Example usage:
/// ```swift
/// let data = PieChartData(values: [("Category 1", 40, 2), ("Category 2", 60, 3)])
/// let chartRenderer = PieChartRenderer(data: data!)
/// let scene = chartRenderer.setUpScene()
/// ```
@MainActor
class PieChartData: ChartData {
    
    // MARK: - Properties
    
    /// The individual pie slices that make up the chart.
    var nodes: [PieSlice]
    
    /// The total value of all pie slices combined.
    var totalValue: CGFloat
    
    /// The angles for each slice, calculated from the data.
    var angles: [CGFloat]
    
    /// The maximum height among all slices.
    var totalHeight: CGFloat
    
    /// The style configuration for the pie chart.
    var pieChartStyle: PieChartStyle = .init()
    
    // MARK: - Initializers
    
    /// Initializes the pie chart data with an array of `PieSlice` values.
    ///
    /// - Parameter values: An array of `PieSlice` objects.
    init?(values: [PieSlice]) {
        let totalValue = values.reduce(0) { $0 + $1.value }
        
        self.totalHeight = values.map { $0.value }.max() ?? 0
        self.nodes = values
        self.totalValue = totalValue
        self.angles = PieChartData.calculateAngles(for: nodes, total: totalValue)
    }
    
    /// Initializes the pie chart data with an array of slice values.
    ///
    /// - Parameter values: An array of slice values (`CGFloat`).
    required convenience init?(values: [CGFloat]) {
        let slices = values.map { value in
            PieSlice(value: value)
        }
        self.init(values: slices)
    }
    
    /// Initializes the pie chart data with an array of slice values and heights.
    ///
    /// - Parameter values: An array of tuples containing slice values and heights.
    convenience init?(values: [(CGFloat, CGFloat)]) {
        let slices = values.map { value in
            PieSlice(value: value.0, height: value.1)
        }
        self.init(values: slices)
    }

    /// Initializes the pie chart data with an array of slice titles and values.
    ///
    /// - Parameter values: An array of tuples containing slice titles and values.
    convenience init?(values: [(String, CGFloat)]) {
        let slices = values.map { value in
            PieSlice(title: value.0, value: value.1)
        }
        self.init(values: slices)
    }
    
    /// Initializes the pie chart data with an array of slice titles, values, and heights.
    ///
    /// - Parameter values: An array of tuples containing slice titles, values, and heights.
    convenience init?(values: [(String, CGFloat, CGFloat)]) {
        let slices = values.map { value in
            PieSlice(title: value.0, value: value.1, height: value.2)
        }
        self.init(values: slices)
    }
    
    // MARK: - Static Methods
    
    /// Calculates the angles for each slice based on its value and the total value.
    ///
    /// - Parameters:
    ///   - slices: The array of pie slices.
    ///   - total: The total value of all slices.
    /// - Returns: An array of angles for the slices.
    private static func calculateAngles(for slices: [PieSlice], total: CGFloat) -> [CGFloat] {
        var angles = [CGFloat(0)]
        for slice in slices {
            let endAngle = angles.last! + 2 * .pi * (slice.value / total)
            angles.append(endAngle)
        }
        return angles
    }
}


/// A data structure representing an individual slice of a pie chart.
///
/// Each `PieSlice` includes optional title information, a value, a height (optional),
/// and a randomly generated color.
///
/// Example usage:
/// ```swift
/// let slice = PieSlice(title: "Category A", value: 40, height: 2)
/// ```
@MainActor
public struct PieSlice {
    
    // MARK: - Properties
    
    /// The title of the slice (optional).
    var title: String?
    
    /// The value of the slice.
    var value: CGFloat
    
    /// The height of the slice (optional).
    var height: CGFloat?
    
    /// The color of the slice.
    var color: UIColor = UIColor.random()
}
