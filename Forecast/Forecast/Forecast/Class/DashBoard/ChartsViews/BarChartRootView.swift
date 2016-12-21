//
//  BarChartRootView.swift
//  Forecast
//
//  Created by appledev110 on 11/18/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit
import Charts

class BarChartRootView: UIView {
    
    @IBOutlet weak var radiusView: UIView!
    @IBOutlet weak var barChartView: BarChartView!
    private var losValueDic = NSMutableDictionary()
    private var keys = [String]()
    private var responseData = [LosListModel]()
    
    func initChartUI(arr: [LosListModel]) {
        responseData = arr
        radiusView.layer.cornerRadius = 5
        self.convertListToSuitChart(arr: arr)
        
//        self.barChartView.drawValueAboveBarEnabled = false
        self.barChartView.xAxis.drawGridLinesEnabled = false
//        self.barChartView.leftAxis.drawGridLinesEnabled = false
        self.barChartView.leftAxis.axisLineColor = StringUtil.getColorWithRGB(red: 200, green: 200, blue: 200)
        self.barChartView.xAxis.axisLineColor = StringUtil.getColorWithRGB(red: 200, green: 200, blue: 200)
        self.barChartView.xAxis.labelTextColor = StringUtil.getColorWithRGB(red: 102, green: 102, blue: 102)
        self.barChartView.leftAxis.labelTextColor = StringUtil.getColorWithRGB(red: 102, green: 102, blue: 102)
        self.barChartView.leftAxis.gridColor = StringUtil.getColorWithRGB(red: 232, green: 232, blue: 232)
        self.barChartView.xAxis.centerAxisLabelsEnabled = false
        self.barChartView.xAxis.wordWrapEnabled = true
        
        self.barChartView.legend.form = .circle
        self.barChartView.legend.textColor = StringUtil.getColorWithRGB(red: 85, green: 85, blue: 85)
        self.barChartView.rightAxis.enabled = false
        self.barChartView.chartDescription?.enabled = false
        self.barChartView.xAxis.labelCount = self.keys.count as Int
        self.barChartView.xAxis.labelPosition = .bottom
        self.barChartView.leftAxis.axisMinimum = 0.0
        self.barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 8)
//        self.barChartView.xAxis.labelFont = UIFont.boldSystemFont(ofSize: 5)
        
        self.configureStackBarChartData()

        let xAxis = self.barChartView.xAxis
        
        // set x axis value formatter
        unowned let wself = self
        xAxis.valueFormatter = DefaultAxisValueFormatter.with(block: { (value, xAis) -> String in
            //            [unowned self] in
            if (value >= 0) && (value < Double(wself.keys.count)) {
                var labelString = wself.keys[Int(value)]
                labelString = labelString.replacingOccurrences(of: " ", with: "\n")
                return labelString
            }
            return ""
        })
        
        let marker: XYMarkerView = XYMarkerView(color: UIColor(white: 180/255.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 10.0), textColor: .white, insets: UIEdgeInsetsMake(2.0, 2.0, 4.0, 2.0), xAxisValueFormatter: self.barChartView.xAxis.valueFormatter!)
        marker.chartView = self.barChartView
        marker.minimumSize = CGSize(width: 80.0, height: 40.0)
        self.barChartView.marker = marker
        
    }
    
    func configureStackBarChartData() {
        self.barChartView.xAxis.resetCustomAxisMin()
        self.barChartView.xAxis.resetCustomAxisMax()
        
        var dataSets: [BarChartDataSet] = [BarChartDataSet]()
        let start = 0.0
        let groupCount = self.keys.count as Int
        let end = Int(start) + groupCount
        var barChartDataSet: BarChartDataSet = BarChartDataSet()
        var enties = [BarChartDataEntry]()
        
        for index in Int(start)...end-1 {
            // 获取总共多少个x轴的单元格
            let strKey = self.keys[index]
            var yValues = [Double]()
            var entry: BarChartDataEntry?
            
            for losModel in responseData {
                // 每个格子合起来的数据
                for detailModel in losModel.LosValues! {
                    if detailModel.label! == strKey {
                        yValues.append(Double(detailModel.value!)!)
                    }
                }
            }
            entry = BarChartDataEntry(x: Double(index), yValues: yValues, label: strKey)
            enties.append(entry!)
        }
        barChartDataSet = BarChartDataSet(values: enties, label: "")
//                barChartDataSet.drawValuesEnabled = false
        let valueTuple = self.getAllKeys()
        barChartDataSet.stackLabels = valueTuple.keys
        barChartDataSet.colors = valueTuple.colors
        
        dataSets.append(barChartDataSet)
        
        let barChartData = BarChartData(dataSets: dataSets)
        
        // set the value format
        let formato: BarChartValueFormatter = BarChartValueFormatter()
        barChartData.setValueFormatter(formato)
        
        barChartData.barWidth = 0.5
        self.barChartView.fitBars = true
        self.barChartView.data = barChartData
    }
    
    // 过滤出Stack类型中每个柱子需要的label和颜色
    func getAllKeys() -> (keys:[String], colors:[UIColor]) {
        var keys = [String]()
        var colors = [UIColor]()
        for listModel in responseData {
            keys.append(listModel.LosKey!)
            colors.append(UIColor.init(hexString: listModel.LosColor!))
        }
        return (keys,colors)
    }
    
    // 获取barchart里所有的x轴的数据
    func convertListToSuitChart(arr: [LosListModel]) {
        var indexCount = 0
        for losModel in arr {
            if let values = losModel.LosValues {
                for index in 0...values.count-1 {
                    
                    let detailModel = values[index]
                    
                    if self.losValueDic.allKeys.contains(obj: detailModel.label! as String) {
                        
                    } else {
                        self.losValueDic.setObject(indexCount, forKey: String(detailModel.label!) as String as NSCopying)
                        indexCount += 1
                    }
                }
            }
        }
        self.keys = self.losValueDic.allKeys as! [String]
        self.keys = self.keys.sorted(by: { (str1, str2) -> Bool in
            return str1.lowercased() < str2.lowercased() ? true : false
        })
    }

}
