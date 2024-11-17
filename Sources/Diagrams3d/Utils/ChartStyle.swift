//
//  ChartStyle.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 15.11.2024.
//

import UIKit

/// A class representing the customizable style for 3D charts.
///
/// The `ChartStyle` class allows configuration of various visual aspects of a chart,
/// including label fonts and colors, axis colors and thickness, and arrow sizes.
///
/// Example usage:
/// ```swift
/// let customStyle = ChartStyle(
///     labelFont: UIFont.systemFont(ofSize: 14, weight: .bold),
///     labelColor: .white,
///     axisColors: (.blue, .yellow, .purple),
///     axisThickness: 0.2,
///     axisArrowSize: 1.0
/// )
/// ```
public class ChartStyle {
    
    // MARK: - Properties
    
    /// The font used for axis labels.
    public var labelFont: UIFont
    
    /// The color of the axis labels.
    public var labelColor: UIColor
    
    /// The colors of the X, Y, and Z axes.
    /// The default values are red (X), green (Y), and orange (Z).
    public var axisColors: (UIColor, UIColor, UIColor)
    
    /// The thickness of the axes.
    /// The default value is `0.1`.
    public var axisThickness: CGFloat
    
    /// The size of the arrowheads at the end of the axes.
    /// The default value is `0.5`.
    public var axisArrowSize: CGFloat
    
    // MARK: - Initializer
    
    /// Initializes a new `ChartStyle` instance with customizable options.
    ///
    /// - Parameters:
    ///   - labelFont: The font to use for axis labels. Defaults to `ChartStyleDefault.labelFont`.
    ///   - labelColor: The color of the axis labels. Defaults to `ChartStyleDefault.labelColor`.
    ///   - axisColors: A tuple specifying the colors for the X, Y, and Z axes.
    ///                 Defaults to `ChartStyleDefault.axisColors`.
    ///   - axisThickness: The thickness of the axes. Defaults to `ChartStyleDefault.axisThickness`.
    ///   - axisArrowSize: The size of the arrowheads at the end of the axes. Defaults to `ChartStyleDefault.axisArrowSize`.
    nonisolated init(
        labelFont: UIFont = ChartStyleDefault.labelFont,
        labelColor: UIColor = ChartStyleDefault.labelColor,
        axisColors: (UIColor, UIColor, UIColor) = ChartStyleDefault.axisColors,
        axisThickness: CGFloat = ChartStyleDefault.axisThickness,
        axisArrowSize: CGFloat = ChartStyleDefault.axisArrowSize
    ) {
        self.labelFont = labelFont
        self.labelColor = labelColor
        self.axisColors = axisColors
        self.axisThickness = axisThickness
        self.axisArrowSize = axisArrowSize
    }
}

/// A class containing the default values for `ChartStyle`.
///
/// The `ChartStyleDefault` class defines static constants for default style options,
/// such as label font, label color, axis colors, axis thickness, and arrow size.
class ChartStyleDefault {
    
    // MARK: - Default Properties
    
    /// The default font used for axis labels.
    static let labelFont: UIFont = UIFont.systemFont(ofSize: 1)
    
    /// The default color for axis labels.
    static let labelColor: UIColor = .black
    
    /// The default colors for the X, Y, and Z axes.
    /// Defaults to red (X), green (Y), and orange (Z).
    static let axisColors: (UIColor, UIColor, UIColor) = (.red, .green, .orange)
    
    /// The default thickness of the axes.
    static let axisThickness: CGFloat = 0.1
    
    /// The default size of the arrowheads at the end of the axes.
    static let axisArrowSize: CGFloat = 0.5
}
