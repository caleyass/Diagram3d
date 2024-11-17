//
//  Extensions.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 15.11.2024.
//

import UIKit

/// An extension of `UIColor` that provides a utility method for generating random colors.
extension UIColor {
    
    /// Generates a random `UIColor`.
    ///
    /// The method creates a color with random red, green, and blue values, and an alpha value of 1.0.
    ///
    /// Example usage:
    /// ```swift
    /// let randomColor = UIColor.random()
    /// view.backgroundColor = randomColor
    /// ```
    ///
    /// - Returns: A randomly generated `UIColor` instance.
    static func random() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0
        )
    }
}
