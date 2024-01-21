//
//  extensions.swift
//  testChart
//
//  Created by Akram Husseini on 18/01/2024.
//

import Foundation
import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
    convenience init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt64()
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
            }
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        }
}

extension UIView {
    
    func addStroakLine(lineYPosition: CGFloat, lineWidth: CGFloat = 2.0, color: UIColor, dashPattern: [NSNumber] = [5, 2], viewWidth: CGFloat? = nil) {
        let layerName = "DashedLineLayer_" + #function
        
        // Check if a layer with the specified name already exists
        if let existingLayer = layer.sublayers?.first(where: { $0.name == layerName }) as? CAShapeLayer {
            // Update properties of the existing layer
            existingLayer.strokeColor = color.cgColor
            existingLayer.lineWidth = lineWidth
            existingLayer.lineDashPattern = dashPattern
            
            let startPoint = CGPoint(x: bounds.minX, y: lineYPosition)
            let endPoint = CGPoint(x: bounds.maxX, y: lineYPosition)
            
            let path = CGMutablePath()
            path.addLines(between: [startPoint, endPoint])
            existingLayer.path = path
        } else {
            // Create and add a new dashed layer
            let dashedLayer = CAShapeLayer()
            dashedLayer.strokeColor = color.cgColor
            dashedLayer.lineWidth = lineWidth
            dashedLayer.lineDashPattern = dashPattern
            dashedLayer.name = layerName
            
            let startX = bounds.minX
            let endX = viewWidth == nil ? bounds.maxX : bounds.minX + (viewWidth ?? 0.0)
            
            let startPoint = CGPoint(x: startX, y: lineYPosition)
            let endPoint = CGPoint(x: endX, y: lineYPosition)
            
            let path = CGMutablePath()
            path.addLines(between: [startPoint, endPoint])
            dashedLayer.path = path
            
            // Insert the dashed layer at the bottom of the layer 
                self.layer.insertSublayer(dashedLayer, at: 0)
           
        }
    }
}
