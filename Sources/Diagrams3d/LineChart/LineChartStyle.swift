//
//  LineChartStyle.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 16.11.2024.
//

import UIKit

/// A class representing the customizable style for a 3D line chart.
///
/// The `LineChartStyle` class allows configuration of the appearance of the line chart,
/// including the line color and thickness. It extends the `ChartStyle` class to include
/// specific properties for line charts.
///
/// Example usage:
/// ```swift
/// let customStyle = LineChartStyle(lineColor: .red, lineThickness: 0.1)
/// lineChartView.setStyle(customStyle)
/// ```
public class LineChartStyle: ChartStyle {
    
    // MARK: - Properties
    
    /// The color of the line in the chart.
    public var lineColor: UIColor
    
    /// The thickness of the line in the chart.
    public var lineThickness: CGFloat
    
    // MARK: - Initializer
    
    /// Initializes a new `LineChartStyle` instance with customizable options.
    ///
    /// - Parameters:
    ///   - lineColor: The color of the line. Defaults to `LineChartStyleDefault.lineColor`.
    ///   - lineThickness: The thickness of the line. Defaults to `LineChartStyleDefault.lineThickness`.
    public init(lineColor: UIColor = LineChartStyleDefault.lineColor, lineThickness: CGFloat = LineChartStyleDefault.lineThickness) {
        self.lineColor = lineColor
        self.lineThickness = lineThickness
    }
}


/// A class containing the default values for `LineChartStyle`.
///
/// The `LineChartStyleDefault` class provides static constants for the default
/// appearance of the line chart, such as the line color and thickness.
///
/// Example usage:
/// ```swift
/// let defaultColor = LineChartStyleDefault.lineColor
/// let defaultThickness = LineChartStyleDefault.lineThickness
/// ```
public class LineChartStyleDefault {
    
    // MARK: - Default Properties
    
    /// The default color of the line in the chart.
    public static let lineColor: UIColor = .blue
    
    /// The default thickness of the line in the chart.
    public static let lineThickness: CGFloat = 0.05
}
