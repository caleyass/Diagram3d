# Diagram3d

This is a flexible framework for rendering 3D charts with SceneKit scene with SwiftUI integration. It supports bar chart, pie chart, and line chart, with customizable styles, axes, labels, and rotation angles. You can adjust camera control and position.

## Features

- **Bar Chart**: Render bar charts with customizable bar width, spacing, colors, and chamfer radius.
- **Line Chart**: Render line charts with configurable line thickness and colors.
- **Pie Chart**: Render pie charts with labels, customizable colors, and heights.
- **Customizable Axes**: You are provided with X, Y, and Z axes to your charts, with style you can edit: adjust thickness of line, arrow size, font size.
- **SwiftUI Integration**: Use `UIViewRepresentable` components to integrate charts into SwiftUI views.

Each chart has initializers for 2 or 3 dimensional values.

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
![GitHub Logo](https://github.com/caleyass/Diagram3d/tree/main/images/barChart.png)

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
![GitHub Logo](https://github.com/caleyass/Diagram3d/tree/main/images/lineChart.png)

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
![GitHub Logo](https://github.com/caleyass/Diagram3d/tree/main/images/pieChart.png)

## Realization description

Each View is initialized via View class with specific parameters. After initialization you can set style , rotation, camera position or disable camera. Initializers contains array of CGFloat - it would initialize 3d chart with 1-dimensional value, or turples with CGFloat and Strings - it would initialize 3d chart with (2-3)-dimensional values and title for each chart node.



