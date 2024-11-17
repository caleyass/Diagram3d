//
//  BarChartStyle.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 15.11.2024.
//

import SceneKit

/// A class representing the customizable style for a 3D bar chart.
///
/// The `BarChartStyle` class allows configuration of various visual aspects of the bar chart,
/// including bar width, spacing, color, and chamfer radius. It extends `ChartStyle` for additional customization options.
///
/// Example usage:
/// ```swift
/// let customStyle = BarChartStyle(
///     nodeWidth: 1.5,
///     nodeSpacing: 0.5,
///     nodeColor: .red,
///     chamferRadius: 0.1
/// )
/// barChartView.setStyle(customStyle)
/// ```
public class BarChartStyle: ChartStyle {
    
    // MARK: - Properties
    
    /// The width of each bar in the chart.
    public var nodeWidth: CGFloat
    
    /// The spacing between consecutive bars.
    public var nodeSpacing: CGFloat
    
    /// The color of the bars in the chart.
    public var nodeColor: UIColor
    
    /// The chamfer radius of the bars, creating rounded edges.
    public var chamferRadius: CGFloat
    
    // MARK: - Initializer
    
    /// Initializes a new `BarChartStyle` instance with customizable options.
    ///
    /// - Parameters:
    ///   - nodeWidth: The width of each bar. Defaults to `BarChartStyleDefault.nodeWidth`.
    ///   - nodeSpacing: The spacing between consecutive bars. Defaults to `BarChartStyleDefault.nodeSpacing`.
    ///   - nodeColor: The color of the bars. Defaults to `BarChartStyleDefault.nodeColor`.
    ///   - chamferRadius: The chamfer radius for rounding bar edges. Defaults to `BarChartStyleDefault.chamferRadius`.
    public init(
        nodeWidth: CGFloat = BarChartStyleDefault.nodeWidth,
        nodeSpacing: CGFloat = BarChartStyleDefault.nodeSpacing,
        nodeColor: UIColor = BarChartStyleDefault.nodeColor,
        chamferRadius: CGFloat = BarChartStyleDefault.chamferRadius
    ) {
        self.nodeWidth = nodeWidth
        self.nodeSpacing = nodeSpacing
        self.nodeColor = nodeColor
        self.chamferRadius = chamferRadius
    }
}

/// A struct containing the default style values for `BarChartStyle`.
///
/// The `BarChartStyleDefault` struct provides static constants for default values
/// such as bar width, spacing, color, and chamfer radius.
///
/// Example usage:
/// ```swift
/// let defaultWidth = BarChartStyleDefault.nodeWidth
/// let defaultColor = BarChartStyleDefault.nodeColor
/// ```
public struct BarChartStyleDefault {
    
    // MARK: - Default Properties
    
    /// The default width of each bar.
    public static let nodeWidth: CGFloat = 1
    
    /// The default spacing between consecutive bars.
    public static let nodeSpacing: CGFloat = 1
    
    /// The default chamfer radius for the bars.
    public static let chamferRadius: CGFloat = 0
    
    /// The default color of the bars.
    public static let nodeColor: UIColor = UIColor.blue
}


