//
//  PieChartStyle.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 16.11.2024.
//

/// A class that defines the styling configuration for a pie chart.
///
/// `PieChartStyle` inherits from `ChartStyle` and provides customizable options
/// specific to the appearance of pie charts, such as colors, text styles, and other visual properties.
///
/// This class is designed to be used with `PieChartView` to style the 3D pie chart.
///
/// Example usage:
/// ```swift
/// let style = PieChartStyle()
/// style.labelFont = UIFont.systemFont(ofSize: 14, weight: .bold)
/// chartView.setStyle(style)
/// ```
public class PieChartStyle : ChartStyle {
    public init(){}
    
}
