# 3D Chart Renderer

This project provides a flexible framework for rendering 3D charts in a SceneKit scene. It supports multiple chart types such as bar charts, pie charts, and line charts, with customizable styles, axes, and labels.

## Features

- **3D Bar Charts**: Render bar charts with customizable bar width, spacing, colors, and chamfer radius.
- **3D Line Charts**: Render line charts with configurable line thickness and colors.
- **3D Pie Charts**: Render pie charts with labels, customizable colors, and heights.
- **Customizable Axes**: Add labeled X, Y, and Z axes to your charts.
- **SwiftUI Integration**: Use `UIViewRepresentable` components to integrate charts into SwiftUI views.

## Installation

                                                
                                                
## Components

### Chart Views

- **`BarChartView`**: A SwiftUI-compatible view for rendering 3D bar charts.
- **`LineChartView`**: A SwiftUI-compatible view for rendering 3D line charts.
- **`PieChartView`**: A SwiftUI-compatible view for rendering 3D pie charts.

### Chart Data

- **`BarChartData`**: Represents data for 3D bar charts, including bar heights and optional labels.
- **`LineChartData`**: Represents data for 3D line charts, including points in 3D space.
- **`PieChartData`**: Represents data for 3D pie charts, including slice values, colors, and optional labels.

### Renderers

- **`BarChartRenderer`**: Responsible for rendering 3D bar charts in a SceneKit scene.
- **`LineChartRenderer`**: Responsible for rendering 3D line charts in a SceneKit scene.
- **`PieChartRenderer`**: Responsible for rendering 3D pie charts in a SceneKit scene.

### Utilities

- **`AxisGenerator`**: Generates labeled 3D axes for charts.
- **`LabelGenerator`**: Creates 3D labels for axes and chart elements.
- **`ChartStyle`**: A base class for defining chart appearance.


