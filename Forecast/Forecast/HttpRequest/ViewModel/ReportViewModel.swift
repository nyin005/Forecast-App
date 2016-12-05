//
//  ReportViewModel.swift
//  Forecast
//
//  Created by Perry Z Chen on 10/21/16.
//  Copyright © 2016 Perry Z Chen. All rights reserved.
//

/**
 TODO:
 1. create a common request can receive a string value and returns the pie chart data or line chart data
 */

import Foundation


class ReportViewModel: BaseViewModel {
    var results: String?
    
    var losListModel: ReportLosModel?
    var pieChartListModel: PieChartDataListModel?               // 饼图数据
    var lineChartRootModel: LineChartDataRootModel?             // 线形图数据
}

extension ReportViewModel {

    // get los report chart
    func getLosReport(_ url: String,parameters: [String: AnyObject], success: @escaping ()->Void, failure:@escaping (_ str: String) -> Void) {
//        let URL = HttpMacro.getRequestURL(.ReportLOS)
        
        self.requestData(url: url, parameters: parameters, methods: .get) { (res: HttpResponseResult) in
            if res.success {
                
                self.results = res.resultString
                let listModel = ReportLosModel(JSONString: res.resultString)! as ReportLosModel
                if listModel.responseData != nil {
                    for model in listModel.responseData! {
                        model.LosValues?.sort(by: { (pre, after) -> Bool in
                            pre.label!.compare(after.label!) == .orderedAscending
                        })
                    }
                    self.losListModel = listModel
                    success()
                } else {
                    failure((listModel.responseMsg)!)
                }
            } else {
                failure(res.resultString)
            }
        }
    }
    
    // 获取饼图数据
    func getPieChartReport(_ url: String, parameters: [String: AnyObject], success: @escaping ()->Void, failure:@escaping (_ str:String ) -> Void) -> Void {
        
//        let URL = HttpMacro.Original.combineString(str: url)
        
        self.requestData(url: url, parameters: parameters, methods: .get) { (res: HttpResponseResult) in
            if res.success {
                self.results = res.resultString
                
                let listModel = PieChartDataListModel(JSONString: res.resultString)
                if listModel?.responseData != nil {
                    self.pieChartListModel = listModel
                    success()
                } else {
                    failure((listModel?.responseMsg)!)
                }
            } else {
                failure(res.resultString)
            }
        }
    }
    
    // 获取线图数据
    func getLineChartReport(_ url: String, parameters: [String: AnyObject], success: @escaping ()->Void, failure:@escaping (_ str:String ) -> Void) -> Void {
//        let URL = HttpMacro.Original.combineString(str: url)
        
        self.requestData(url: url, parameters: parameters, methods: .get) { (res: HttpResponseResult) in
            if res.success {
                
                self.results = res.resultString
                
                let utListModel = LineChartDataRootModel(JSONString: res.resultString)
                if utListModel?.responseData != nil {
                    self.lineChartRootModel = utListModel
                    success()
                    
                } else {
                    failure((utListModel?.responseMsg)!)
                }
            } else {
                failure(res.resultString)
            }
        }

    }
    
    func cancel() {
        self.cancelRequest()
    }
}
