//
//  chartTableViewCell.swift
//  testChart
//
//  Created by Akram Husseini on 18/01/2024.
//

import UIKit
import Charts

class chartTableViewCell: UITableViewCell {

    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var frameView: UIView! { didSet{
        frameView.layer.cornerRadius = 16
        frameView.layer.borderWidth = 1
        frameView.layer.borderColor = UIColor(hex: "#ECEDF1").cgColor
    }}
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var stroakLine1: UIView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var stroakLine2: UIView!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var stroakLine3: UIView!
    @IBOutlet weak var stroakLine4: UIView!
    @IBOutlet weak var zigChart: ZigzagChartView!
    var data: [CGFloat] = []
    let strokeLineWidth: CGFloat = UIScreen.main.bounds.width - 72
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // Reset the state of ZigzagChartView
        self.data.removeAll()
        zigChart.reset()
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        addStroakLines()
    }
    
    func initView(newData: [CGFloat]) {
        let biggestNumber = newData.reduce(CGFloat.leastNormalMagnitude) { max($0, $1) }
        maxValueLabel.text = String(format: "%.0F", biggestNumber)
        setupLabels(newData)
        zigChart.data = self.data
    }
    
    
    private func setupLabels(_ newData: [CGFloat]) {
        guard let (value1, value2, value3, newData) = populateLabels(newData) else { return }
        if let newData {
            self.data = newData
        }
        label1.text = String(format: "%.0F", value1)
        label2.text = String(format: "%.0F", value2)
        label3.text = String(format: "%.0F", value3)
        self.data = self.data.map{$0 / value1 * 100}
    }
    
     func populateLabels(_ newData: [CGFloat]) -> (CGFloat, CGFloat, CGFloat, [CGFloat]?)? {
        let targetValue: CGFloat = 9
         let divisor2: CGFloat = 2
         let divisor10: CGFloat = 10
         guard !newData.isEmpty else { return nil }
         let maxValue = newData.reduce(CGFloat.leastNormalMagnitude) { max($0, $1) }
         var unitValue = maxValue / 3
        var multiplyer: CGFloat = 1
        while unitValue > targetValue {
            guard (unitValue / divisor10) > targetValue else {
                let fractures: [[CGFloat]] = [
                        [divisor2, round(unitValue / divisor2) / (unitValue / divisor2)],
                        [divisor10, round(unitValue / divisor10) / (unitValue / divisor10)],
                    ]
                var minDifference = CGFloat.greatestFiniteMagnitude
                var minFractionIndex: Int?
                for (index, row) in fractures.enumerated() {
                    guard row.count > 1 else { continue }
                    let difference = abs(row[1] - 1)
                    if difference < minDifference {
                        minDifference = difference
                        minFractionIndex = index
                    }
                }
                if let minFractionIndex = minFractionIndex,
                   let fraction = fractures[minFractionIndex].first {
                    unitValue /= fraction
                    multiplyer *= fraction
                   
                }
                continue
            }
            unitValue /= 10
            multiplyer *= 10
        }
        guard unitValue == round(unitValue) else {
            let adjustedData = newData.map{$0/round(unitValue) * unitValue }
            let baselineNumber = round(unitValue) * 3
            let value1 = round(baselineNumber * multiplyer)
            let value2 = round(baselineNumber * multiplyer) / 3 * 2
            let value3 = round(baselineNumber * multiplyer) / 3
            return (value1, value2, value3, adjustedData)
        }
        let value1 = round(unitValue * 3 * multiplyer)
        let value2 = round(unitValue * 2 * multiplyer)
        let value3 =  round(unitValue * multiplyer)
         return (value1, value2, value3, nil)
    }

    private func addStroakLines() {
        stroakLine1.addStroakLine(lineYPosition: 0, lineWidth: 1, color: UIColor(hex: "#ECEDF1"), dashPattern: [4,4], viewWidth: strokeLineWidth)
        stroakLine2.addStroakLine(lineYPosition: 0, lineWidth: 1, color: UIColor(hex: "#ECEDF1"), dashPattern: [4,4], viewWidth: strokeLineWidth)
        stroakLine3.addStroakLine(lineYPosition: 0, lineWidth: 1, color: UIColor(hex: "#ECEDF1"), dashPattern: [4,4], viewWidth: strokeLineWidth)
        stroakLine4.addStroakLine(lineYPosition: 0, lineWidth: 1, color: UIColor(hex: "#ECEDF1"), dashPattern: [4,4], viewWidth: strokeLineWidth)
    }
    
}
