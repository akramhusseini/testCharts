//
//  customChart.swift
//  testChart
//
//  Created by Akram Husseini on 18/01/2024.
//

import Foundation
import UIKit

class ZigzagChartView: UIView {
    var height: CGFloat = 100
    var extraHeight: CGFloat = 20
    var data: [CGFloat] = [/* Your data array here */]
    // This is required to conform to NSCoding
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         commonInit()
     }

     // This is your designated initializer
     override init(frame: CGRect) {
         super.init(frame: frame)
         commonInit()
     }

     private func commonInit() {}
    
    override func draw(_ rect: CGRect) {
        guard data.count > 1 else {
            return // Not enough data points
        }
        let path = createZigzagPath()
        path.lineWidth = 1.0
        let color: UIColor = UIColor(hex: "#6A7791")
        color.setStroke()
        path.stroke()
        let maxValue = data.reduce(CGFloat.leastNormalMagnitude) { max($0, $1) }
        let gradientLayer = createGradientLayer(for: path, max: maxValue)
        layer.addSublayer(gradientLayer)
    }

    private func createZigzagPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -1, y: height + extraHeight))
        let pointSpacing = bounds.width / CGFloat(data.count - 1)
        for (index, value) in data.enumerated() {
            let x = index == 0 ? -1 : index == data.count - 1 ? bounds.width + 1 : CGFloat(index) * pointSpacing
            let y = height + extraHeight - value
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: bounds.width + 1, y: height + extraHeight))
        return path
    }


    private func createGradientLayer(for path: UIBezierPath, max: CGFloat) -> CAGradientLayer {
        let endPointPercentage: CGFloat = max / height
        let endPointNSNumber = NSNumber(value: endPointPercentage)
        let startPointNSNumber = NSNumber(value: 0)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor(hex: "#45567B").withAlphaComponent(0.2).cgColor,
            UIColor(hex: "#ECEDF1").withAlphaComponent(0).cgColor]
        gradientLayer.locations = [startPointNSNumber, endPointNSNumber]
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        gradientLayer.mask = maskLayer
        return gradientLayer
    }
    
    func reset() {
            data = []
            layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            setNeedsDisplay()
        }
    
}
