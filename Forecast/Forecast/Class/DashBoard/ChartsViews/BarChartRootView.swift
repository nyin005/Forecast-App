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
    @IBOutlet weak var segControl: UISegmentedControl!
    private var losValueDic = NSMutableDictionary()
    private var keys = [String]()
    private var responseData = [LosListModel]()
    
    func initChartUI(arr: [LosListModel]) {
        responseData = arr
        radiusView.layer.cornerRadius = 5
        self.convertListToSuitChart(arr: arr)
        
        self.barChartView.xAxis.drawGridLinesEnabled = false
        self.barChartView.leftAxis.drawGridLinesEnabled = false
        self.barChartView.xAxis.centerAxisLabelsEnabled = false
        self.barChartView.xAxis.wordWrapEnabled = true
        self.configureStackBarChartData()
//        self.segControl.selectedSegmentIndex = 1
//        self.segValueChanged(self.segControl)
        
        self.barChartView.legend.form = .circle
        self.barChartView.legend.textColor = StringUtil.getColorWithRGB(red: 85, green: 85, blue: 85)
        self.barChartView.rightAxis.enabled = false
        self.barChartView.chartDescription?.enabled = false
        self.barChartView.xAxis.labelCount = self.keys.count as Int
        self.barChartView.xAxis.labelPosition = .bottom
        self.barChartView.leftAxis.axisMinimum = 0.0
        self.barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 8)
//        self.barChartView.xAxis.labelFont = UIFont.boldSystemFont(ofSize: 5)
        
        let xAxis = self.barChartView.xAxis
        
        // set x axis value formatter
        unowned let wself = self
        xAxis.valueFormatter = DefaultAxisValueFormatter.with(block: { (value, xAis) -> String in
            //            [unowned self] in
            if (value >= 0) && (value < Double(wself.losValueDic.allKeys.count)) {
                var labelString = wself.losValueDic.allKeys[Int(value)] as! String
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
    
    
//    @IBAction func segValueChanged(_ sender: UISegmentedControl) {
//        let intSelect = sender.selectedSegmentIndex
//        if intSelect == 0 {
//            // group
//            let xAxis = self.barChartView.xAxis
//            xAxis.centerAxisLabelsEnabled = true
//            xAxis.granularity = 1.0
//            xAxis.wordWrapEnabled = true
//            self.configureGroupBarChartData()
//        } else {
//            // stack
//            let xAxis = self.barChartView.xAxis
//            xAxis.centerAxisLabelsEnabled = false
//            xAxis.wordWrapEnabled = true
//            self.configureStackBarChartData()
//        }
//    }

    func configureGroupBarChartData() {
        
        var dataSets: [BarChartDataSet] = [BarChartDataSet]()
        let start = 0.0
        let groupCount = self.keys.count as Int
        let end = Int(start) + groupCount
        
        for losModel in responseData {
            // 获取每个单元格所需要的数据
            var barChartDataSet: BarChartDataSet = BarChartDataSet()
            if losModel.LosValues != nil {
                var yValues = [BarChartDataEntry]()
                for index in Int(start)...end-1 {
                    // 获取总共需要多少个单元格
                    let strKey = self.keys[index]
                    var entry: BarChartDataEntry?
                    var findIT: Bool = false
                    for detailModel in losModel.LosValues! {
                        // 根据x轴的标识获取真实数据, y值
                        if detailModel.label! == strKey {
                            let strValue = self.losValueDic.object(forKey: strKey) as! Int
                            entry = BarChartDataEntry(x: Double(strValue), y: Double(detailModel.value!)!, data: detailModel)
                            findIT = true
                            break
                        }
                    }
                    if findIT {
                        yValues.append(entry!)
                    }
                    else {
                        entry = BarChartDataEntry(x: Double(self.losValueDic.object(forKey: strKey) as! Int), y: 0.0, data: nil)
                        yValues.append(entry!)
                    }
                    
                }
                barChartDataSet = BarChartDataSet(values: yValues, label: losModel.LosKey)
                barChartDataSet.setColor(UIColor(hexString: losModel.LosColor!))
            }
            dataSets.append(barChartDataSet)
        }
        let barChartData = BarChartData(dataSets: dataSets)
        
        barChartData.barWidth = 0.2
        
        self.barChartView.xAxis.axisMinimum = Double(start)
        self.barChartView.xAxis.axisMaximum = Double(start + barChartData.groupWidth(groupSpace: 0.08, barSpace: 0.03) * Double(groupCount))
        barChartData.groupBars(fromX: start, groupSpace: 0.08, barSpace: 0.03)
        self.barChartView.data = barChartData
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
            // 可优化，根据index来获取Model
            
            for losModel in responseData {
                // 每个格子合起来的数据

                for detailModel in losModel.LosValues! {
                    if detailModel.label! == strKey {
                        yValues.append(Double(detailModel.value!)!)
//                        break
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
    }
}
