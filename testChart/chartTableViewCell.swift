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
        zigChart.reset()
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        addStroakLines()
    }
    
    func initView(newData: [CGFloat]) {
        let biggestNumber = newData.reduce(CGFloat.leastNormalMagnitude) { max($0, $1) }
        let maxValue = round( biggestNumber / 100 ) * 100
        maxValueLabel.text = String(format: "%.0F", biggestNumber)
        self.data = newData.map{$0 / biggestNumber * 100}
        populateLabels(maxValue: maxValue, newData: newData)
        zigChart.data = self.data
    }
    
    private func populateLabels(maxValue: CGFloat, newData: [CGFloat]) {
        let targetValue: CGFloat = 9
        let divisor1: CGFloat = 10
        let divisor2: CGFloat = 2
        guard !data.isEmpty else { return }
        var unitValue = maxValue / 3
        
        var multiplyer: CGFloat = 1
        while unitValue > targetValue {
            guard (unitValue / divisor1) > targetValue else {
                let fractures: [[CGFloat]] = [
                        [divisor1, round(unitValue / divisor1) / (unitValue / divisor1)],
                        [divisor2, round(unitValue / divisor2) / (unitValue / divisor2)]
                    ]
                let minFractionIndex = fractures.enumerated().min(by: { $0.element[1] < $1.element[1] })?.offset ?? 0
                let fraction = fractures[minFractionIndex][0]
                    unitValue /= fraction
                    multiplyer *= fraction
                continue
            }
            unitValue /= 10
            multiplyer *= 10
        }
        guard unitValue == round(unitValue) else {
            let adjustedData = newData.map{$0/round(unitValue) * unitValue }
            let biggestAdjustedNumber = newData.reduce(CGFloat.leastNormalMagnitude) { max($0, $1) }
            let maxAdjustedValue = round( biggestAdjustedNumber / multiplyer ) * multiplyer
            self.data = adjustedData.map{$0 / maxAdjustedValue * 100}
            let baselineNumber = round(unitValue) * 3
            label1.text = String(format: "%.0F", round(baselineNumber * multiplyer))
            label2.text = String(format: "%.0F", round(baselineNumber / 3 * 2 * multiplyer))
            label3.text = String(format: "%.0F", round(baselineNumber / 3  * multiplyer))
            return
        }
        label1.text = String(format: "%.0F", round(unitValue * 3 * multiplyer))
        label2.text = String(format: "%.0F", round(unitValue * 2 * multiplyer))
        label3.text = String(format: "%.0F", round(unitValue * multiplyer))
    }

    private func addStroakLines() {
        stroakLine1.addStroakLine(lineYPosition: 0, lineWidth: 1, color: UIColor(hex: "#ECEDF1"), dashPattern: [4,4], viewWidth: strokeLineWidth)
        stroakLine2.addStroakLine(lineYPosition: 0, lineWidth: 1, color: UIColor(hex: "#ECEDF1"), dashPattern: [4,4], viewWidth: strokeLineWidth)
        stroakLine3.addStroakLine(lineYPosition: 0, lineWidth: 1, color: UIColor(hex: "#ECEDF1"), dashPattern: [4,4], viewWidth: strokeLineWidth)
        stroakLine4.addStroakLine(lineYPosition: 0, lineWidth: 1, color: UIColor(hex: "#ECEDF1"), dashPattern: [4,4], viewWidth: strokeLineWidth)
    }
    
}
