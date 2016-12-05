//
//  ChartFormatter.swift
//  Forecast
//
//  Created by Perry Z Chen on 10/24/16.
//  Copyright © 2016 Perry Z Chen. All rights reserved.
//

import UIKit
import Foundation
import Charts

@objc(LineChartValueFormatter)
public class LineChartValueFormatter: NSObject, IValueFormatter {
    
    public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String("\(value)%")
    }
}

@objc(LineChartYAxisFormatter)
public class LineChartYAxisFormatter: NSObject, IAxisValueFormatter {
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String("\(value)%")
    }
}

@objc(BarChartValueFormatter)
public class BarChartValueFormatter: NSObject, IValueFormatter {
    
    public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        if value == 0 {
            return ""
        } else {
            return String(Int(value))
        }
    }
}


