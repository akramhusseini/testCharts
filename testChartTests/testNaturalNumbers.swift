//
//  testNaturalNumbers.swift
//  testChartTests
//
//  Created by Akram Husseini on 23/01/2024.
//

import XCTest

class NaturalNumberCases: XCTestCase {

    func testPopulateLabels() {
        // Given
        //let newData: [CGFloat] = [0.00, 5.04, 30.76, 162.46, 125.54, 14.61, 11.21, 9.99, 5.85, 15.14, 93.63, 48.70, 1.13, 12.18, 18.28]
//        let newData: [CGFloat] = [0.00, 276.00, 4818.00, 4835.45, 1038.80, 1313.60, 1436.40, 1022.00, 15.81, 1434.00, 1330.62, 520.85, 99.45, 3704.40, 296.45, 185.25, 549.00, 66.40, 508.53, 3588.34, 3481.50, 497.80, 1597.74, 30.25, 874.35, 541.80, 1542.40, 2117.52, 715.20]
        
        
         let origionalData: [CGFloat] = [0.0, 127.2, 2920.5, 940.9, 308.0, 1360.0, 1481.4, 986.0, 36.38, 5796.0, 590.9399999999999, 221.09999999999997, 105.4, 1478.4, 80.5, 145.35, 423.59999999999997, 773.6, 751.74, 1247.4699999999998, 1061.5, 562.4, 844.44, 227.15, 1559.76, 966.0, 1542.4, 1425.96, 175.2]
        // Find the index of the biggest number before calling populateLabels
               guard let index = origionalData.firstIndex(of: origionalData.reduce(CGFloat.leastNormalMagnitude) { max($0, $1) }) else {
                   XCTFail("Couldn't find the index of the biggest number.")
                   return
               }

        let oldBiggestNumber = origionalData[index]
        
        let newData = origionalData.map{$0 / oldBiggestNumber * 100}
        
        let cell = chartTableViewCell() // Replace with the actual class where populateLabels is called
        cell.data = newData
        
        let biggestNumber = newData[index]
        let maxValue = round( biggestNumber / 100 ) * 100
        
        // Find the index of the biggest number before calling populateLabels
               guard let index = newData.firstIndex(of: newData.max() ?? 0) else {
                   XCTFail("Couldn't find the index of the biggest number.")
                   return
               }
        
        if let (value1, _, _, _) = cell.populateLabels(newData) {
         
            
            XCTAssertTrue(biggestNumber < value1 * 1.08, "maxValue should be lower than value1")
        }
    }
}

