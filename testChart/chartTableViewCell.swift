//
//  chartTableViewCell.swift
//  testChart
//
//  Created by Akram Husseini on 18/01/2024.
//

import UIKit

class chartTableViewCell: UITableViewCell {

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
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var stroakLine4: UIView!
    @IBOutlet weak var zigChart: ZigzagChartView!
    var data: [CGFloat] = []
    let strokeLineWidth: CGFloat = UIScreen.main.bounds.width - 72
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addStroakLines()
    }
    
    func initView(newData: [CGFloat]) {
        let maxValue = newData.reduce(CGFloat.leastNormalMagnitude) { max($0, $1) }
        self.data = newData.map{$0 / maxValue * 100}
        populateLabels(maxValue)
        zigChart.data = self.data
    }
    
    private func populateLabels(_ maxValue: CGFloat) {
        guard !data.isEmpty else { return }
        label1.text = "\(maxValue)"
        label2.text = "\(round(maxValue * 0.75))"
        label3.text = "\(round(maxValue * 0.25))"
        label4.text = "0"
    }
    
    private func addStroakLines() {
        stroakLine1.addStroakLine(lineYPosition: 0, lineWidth: 1, color: UIColor(hex: "#ECEDF1"), dashPattern: [4,4], viewWidth: strokeLineWidth)
        stroakLine2.addStroakLine(lineYPosition: 0, lineWidth: 1, color: UIColor(hex: "#ECEDF1"), dashPattern: [4,4], viewWidth: strokeLineWidth)
        stroakLine3.addStroakLine(lineYPosition: 0, lineWidth: 1, color: UIColor(hex: "#ECEDF1"), dashPattern: [4,4], viewWidth: strokeLineWidth)
        stroakLine4.addStroakLine(lineYPosition: 0, lineWidth: 1, color: UIColor(hex: "#ECEDF1"), dashPattern: [4,4], viewWidth: strokeLineWidth)
    }
    
}
