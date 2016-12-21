//
//  PieChartRootView.swift
//  Forecast
//
//  Created by appledev110 on 11/18/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit
import Charts

class PieChartRootView: UIView {

    @IBOutlet weak var radiusView: UIView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var headerCount: UILabel!
    @IBOutlet weak var hcCount: UILabel!
    
    var valuesCount = "0"
    
    func initChartUI(arr: [PieChartDataModel]) {
        radiusView.layer.cornerRadius = 5
        self.configureChartLegend()
        
        var entries = [PieChartDataEntry]()
        var colors = [UIColor]()
        
        var valueCount = 0.0
        for index in 0...(arr.count - 1){
            
            let model: PieChartDataModel = arr[index]
            let dataEntry = PieChartDataEntry(value: Double(model.y!)!, label: model.key, data: model)
            valueCount += Double(model.y!)!
            entries.append(dataEntry)
            colors.append(UIColor.init(hexString: arr[index].color!))
        }
        
        valuesCount = String(valueCount)
        
        let dataset = PieChartDataSet(values: entries, label: "")
        
        let data = PieChartData(dataSet: dataset)
        data.setValueFormatter(DefaultValueFormatter.with(block: { (value, entry, i, nil) -> String in
            if let model = entry.data as? PieChartDataModel {//\(model.key!)\n
                let doubleValue = (value / valueCount*100)
                return "\(model.key!):\(" ")\(Double(value)) (\(String(format:"%.2f",doubleValue))%)"
            } else {
                return "\(value)%"
            }
        }))
        // set colors
        dataset.colors = colors
//        dataset.sliceSpace = 1
        
        // set value line
        dataset.valueLinePart1OffsetPercentage = 0.8
        dataset.valueLinePart1Length = 0.4
        dataset.valueLinePart2Length = 0.6
        dataset.yValuePosition = .outsideSlice
        dataset.valueLineColor = StringUtil.getColorWithRGB(red: 145, green: 145, blue: 145)
        
        data.setValueTextColor(StringUtil.getColorWithRGB(red: 72, green: 72, blue: 72))
        data.setValueFont(UIFont.systemFont(ofSize: 9.0))
        pieChartView.drawEntryLabelsEnabled = false // hide the label value on pie chart
        pieChartView.data = data
        pieChartView.highlightPerTapEnabled = false
    }

    func configureChartLegend() {
        let chartLegend = pieChartView.legend
        chartLegend.form = .circle
        chartLegend.textColor = StringUtil.getColorWithRGB(red: 85, green: 85, blue: 85)
        chartLegend.verticalAlignment = .bottom
        chartLegend.horizontalAlignment = .center
        chartLegend.drawInside = false
        pieChartView.chartDescription?.enabled = false
//        pieChartView.drawHoleEnabled = false
    
    }
    
    func initHeaderCount(showCount: Bool) {
        if showCount {
            headerCount.isHidden = showCount
            hcCount.isHidden = showCount
        } else {
            headerCount.isHidden = showCount
            hcCount.text = valuesCount
        }
        
    }
}
