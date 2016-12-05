//
//  DataManager.swift
//  Forecast
//
//  Created by appledev110 on 11/17/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit
import Alamofire

let single = DataManager()

class DataManager: NSObject {
    
    var items: NSMutableDictionary = ["0":"DashBoard", "1":"Available", "didSelect": 0]
    
//    var results: String?
//    
//    var losListModel: ReportLosModel?
//    var pieChartListModel: PieChartDataListModel?
//    var lineChartRootModel: LineChartDataRootModel?
    
    class var shareManager : DataManager {
        return single
    }
//    
//    func getLineChartReport(_ url: String, parameters: [String: AnyObject], success: @escaping ()->Void, failure:@escaping (_ str:String ) -> Void) -> Void {
//   
//        ApiRequestManager.sharedManager.requestData(url: url, parameters: [:], methods: .get) { (res: HttpResponseResult) in
//            if res.success {
//                
//                self.results = res.resultString
//                
//                let utListModel = ReportLineChartModel(JSONString: res.resultString)
//                if utListModel?.responseData != nil {
//                    self.lineChartRootModel = utListModel
//                    success()
//                    
//                } else {
//                    failure((utListModel?.responseMsg)!)
//                }
//            } else {
//                failure(res.resultString)
//            }
//        }
//    }
    
}
