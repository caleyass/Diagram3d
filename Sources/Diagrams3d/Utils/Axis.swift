//
//  Axis.swift
//  Diagrams3d
//
//  Created by Olesia Petrova on 11.11.2024.
//
/// An enumeration representing the three primary axes in a 3D coordinate system.
///
/// The `Axis` enum is used to define the X, Y, and Z axes, typically for operations
/// involving rotations, transformations, or axis-specific computations in 3D scenes.
///
/// Example usage:
/// ```swift
/// let selectedAxis: Axis = .x
/// switch selectedAxis {
/// case .x:
///     print("X-axis selected")
/// case .y:
///     print("Y-axis selected")
/// case .z:
///     print("Z-axis selected")
/// }
/// ```
public enum Axis {
    /// Represents the X-axis in the 3D coordinate system.
    case x

    /// Represents the Y-axis in the 3D coordinate system.
    case y
    
    /// Represents the Z-axis in the 3D coordinate system.
    case z
}


