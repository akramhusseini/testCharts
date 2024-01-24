# ZigzagChart!

<img src="https://github.com/akramhusseini/testCharts/assets/46135977/666ffda2-46ed-4b18-80a0-7ee0d0cd4fa4" width="50%" height="50%">



[ZigzagChart] is a proof-of-concept (POC) project demonstrating the creation of a custom chart with a zigzag line and a gradient fill using Swift and UIKit.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Usage](#usage)
- [Customization](#customization)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This project showcases the implementation of a custom chart view, `ZigzagChartView`, that renders a zigzag line chart with a gradient fill. It is created using Swift and UIKit. The chart is designed to visualize data points in a unique way, providing a visually appealing representation of the dataset.

## Features

- Custom `ZigzagChartView` for displaying zigzag line charts.
- Gradient fill for a visually appealing representation of data.
- Easily customizable to adapt to various design requirements.

## Requirements

- iOS 12.0+
- Xcode 12.0+
- Swift 5.0+

## Getting Started

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/akramhusseini/ZigzagChart.git
    ```

2. Open the project in Xcode.

### Usage

1. Integrate `ZigzagChartView` into your project by copying the relevant files.

2. Create an instance of `ZigzagChartView` and customize it as needed.

3. Set the `data` property to the dataset you want to visualize.

4. Add the `ZigzagChartView` to your view hierarchy.

```swift
let zigzagChartView = ZigzagChartView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
zigzagChartView.data = [/* Your dataset here */]
self.view.addSubview(zigzagChartView)
