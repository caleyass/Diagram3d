# Diagram3d

This framework provides a flexible framework for rendering 3D charts in a SceneKit scene and has a SwiftUI integration. It supports bar chart, pie chart, and line chart, with customizable styles, axes, labels, and rotation angles. You can adjust camera control and position.

## Features

- **Bar Chart**: Render bar charts with customizable bar width, spacing, colors, and chamfer radius.
- **Line Chart**: Render line charts with configurable line thickness and colors.
- **Pie Chart**: Render pie charts with labels, customizable colors, and heights.
- **Customizable Axes**: You are provided with X, Y, and Z axes to your charts, with style you can edit: adjust thickness of line, arrow size, font size.
- **SwiftUI Integration**: Use `UIViewRepresentable` components to integrate charts into SwiftUI views.

## Installation

Installation accesible via Cocapods and SPM using GitHub repository link.

### SPM using GitHub repository link

`https://github.com/caleyass/Diagram3d`

### Cocoapods

Add to Podfile
`pod 'Diagram3d', :git => 'https://github.com/caleyass/Diagram3d'`
                                                
## Examples

### Bar Chart

```swift
struct ExampleView : View {
    
    @State private var chartView : BarChartView?
    let data: [CGFloat] = [1, 3, 5, 8]

    var body: some View {
        ZStack{
            chartView?.frame(width: 200, height: 200)
        }.onAppear{
            chartView = BarChartView(values: data)
        }
    }
}
```

### Line Chart

```swift
struct ExampleView : View {
    
    @State private var chartView : LineChartView?
    let data: [CGFloat] = [1, 3, 5, 8]

    var body: some View {
        ZStack{
            chartView?.frame(width: 200, height: 200)
        }.onAppear{
            chartView = LineChartView(values: data)
            chartView?.setStyle(LineChartStyle(lineColor: .orange))
            chartView?.rotate(byDegrees: 90, axis: .z)
        }
    }
}
```

### Pie Chart

```swift
struct ExampleView : View {
    
    @State private var chartView : PieChartView?
    let data: [(CGFloat, CGFloat)] = [(1,1), (2,2), (3,3), (4,4)]

    var body: some View {
        ZStack{
            chartView?.frame(width: 200, height: 200)
        }.onAppear{
            chartView = PieChartView(values: data)
        }
    }
}
```

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


