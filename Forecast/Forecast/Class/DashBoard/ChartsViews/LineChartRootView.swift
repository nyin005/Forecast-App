//
//  LineChartRootView.swift
//  Forecast
//
//  Created by appledev110 on 11/18/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit
import Charts

class LineChartRootView: UIView {
    
    @IBOutlet weak var radiusView: UIView!
    @IBOutlet weak var lineContainerView: LineChartView!
    var arrListModel: [LineChartDataListModel]?
    
    func initChartUI(arr: [LineChartDataListModel]) {
        self.arrListModel = arr
        radiusView.layer.cornerRadius = 5
        
        let marker = BalloonMarker(color: UIColor(white: 180/255.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 10.0), textColor: .white, insets: UIEdgeInsetsMake(2.0, 2.0, 4.0, 2.0))
        marker.chartView = lineContainerView
        marker.minimumSize = CGSize(width: 80.0, height: 40.0)
        lineContainerView.marker = marker
//        self.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        
        self.configureTimeChartAxis()
        var dataSets: [IChartDataSet] = [IChartDataSet]()
        var lineChartDataSet: LineChartDataSet
        
        let yFormate = LineChartYAxisFormatter()
             
        var colors = [UIColor]()

        for i in 0...(arr.count) - 1 {
            colors.append(UIColor.init(hexString: arr[i].color!))
            // get the values data
            let utModel = arr[i]
            // set the balloon marker model
            let balloonModel = BalloonMarkerModel(value: 0.0, desc: (utModel.key!))
            if let values = utModel.values{
                var yValues = [ChartDataEntry]()
                for index in 0...values.count-1 {
                    let detailModel = values[index];
                    let value: ChartDataEntry = ChartDataEntry(x: detailModel.timeInteval!, y: detailModel.value!,data: balloonModel);
                    yValues.append(value)
                }
                lineChartDataSet = LineChartDataSet(values: yValues, label: utModel.key)
                
                // set the line setting
                lineChartDataSet.colors = [colors[i]]
                lineChartDataSet.drawCircleHoleEnabled = false
                lineChartDataSet.drawValuesEnabled = false
                lineChartDataSet.circleRadius = 4.0
                lineChartDataSet.circleColors = [colors[i]]
                
                if i == 7 {
                    lineChartDataSet.lineWidth = 4
                    lineChartDataSet.circleRadius = 5
                }
                else {
                    lineChartDataSet.lineWidth = 2
                }
                lineChartDataSet.highlightColor = StringUtil.getColorWithRGB(red: 200, green: 200, blue: 200)
                
                dataSets.append(lineChartDataSet)
            }
        }
        
        let lineChartData = LineChartData(dataSets: dataSets)
        // set the value format
        let formato: LineChartValueFormatter = LineChartValueFormatter()
        lineChartData.setValueFormatter(formato)
        
        lineContainerView.leftAxis.valueFormatter = yFormate
        
        //        self.lineChartView.rightAxis.valueFormatter = yFormate
        
        lineContainerView.data = lineChartData
        
    }
    
    func configureTimeChartAxis() {
        lineContainerView.legend.form = .circle
        lineContainerView.legend.textColor = StringUtil.getColorWithRGB(red: 85, green: 85, blue: 85)
        lineContainerView.chartDescription?.enabled = false
        lineContainerView.xAxis.labelFont = UIFont.systemFont(ofSize: 8.0)
        lineContainerView.xAxis.drawGridLinesEnabled = false
        
        if let arrList = self.arrListModel, arrList.count > 0 {
            let model: LineChartDataListModel = arrList.first!
            lineContainerView.xAxis.axisMinimum = Double(((model.values?.first)! as LineChartDataModel).timeInteval!) - Double(20 * 24 * 60 * 60 * 1000)
            
            lineContainerView.xAxis.axisMaximum = Double(((model.values?.last)! as LineChartDataModel).timeInteval!) + Double(15 * 24 * 60 * 60 * 1000)
        }
        
        lineContainerView.xAxis.drawAxisLineEnabled = false
        lineContainerView.xAxis.labelPosition = .bottom
        lineContainerView.xAxis.labelTextColor = StringUtil.getColorWithRGB(red: 102, green: 102, blue: 102)
        lineContainerView.rightAxis.enabled = false
        lineContainerView.leftAxis.drawGridLinesEnabled = false
        lineContainerView.leftAxis.axisLineColor = StringUtil.getColorWithRGB(red: 200, green: 200, blue: 200)
        lineContainerView.leftAxis.labelTextColor = StringUtil.getColorWithRGB(red: 102, green: 102, blue: 102)
        
//        lineContainerView.leftAxis.drawZeroLineEnabled = true
        lineContainerView.leftAxis.drawLimitLinesBehindDataEnabled = true
        
        
        let limtLine = ChartLimitLine.init(limit: 80)
        limtLine.lineWidth = 0.7
        limtLine.lineColor = StringUtil.getColorWithRGB(red: 232, green: 232, blue: 232)
        
        lineContainerView.leftAxis.addLimitLine(limtLine)
        lineContainerView.xAxis.granularity = 86400000.0  // it's a monthly granularity
        lineContainerView.xAxis.valueFormatter = DefaultAxisValueFormatter.with(block: { (value, axis) -> String in
            // format the x axis
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM yyyy"
            let strDate = formatter.string(from: Date(timeIntervalSince1970: value / 1000))
            return strDate
        })
    
    }
}
