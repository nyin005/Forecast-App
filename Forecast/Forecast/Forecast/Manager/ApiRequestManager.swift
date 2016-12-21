////
////  ApiRequestManager.swift
////  Forecast
////
////  Created by appledev110 on 11/17/16.
////  Copyright © 2016 appledev110. All rights reserved.
////
//
//import UIKit
//import Alamofire
//
//let shard = ApiRequestManager()
//
//struct HttpResponseResult {
//    var success: Bool
//    var resultString: String
//    
//    init(status: Bool, result: String) {
//        self.success = status
//        self.resultString = result
//    }
//}
//
//class ApiRequestManager: NSObject {
//    private var dataRequest: DataRequest?
//
//    var losListModel: ReportLosModel?
//    var pieChartListModel: ReportPieChartModel?
//    var lineChartRootModel: ReportLineChartModel?
//    
//    class var sharedManager : ApiRequestManager {
//        return shard
//    }
//    
//    func requestData(url: String, parameters:[String: AnyObject], methods: HTTPMethod, responseBlock:@escaping (_ res: HttpResponseResult)->Void) -> Void {
//        // 记录请求结果
//        var requestResult: HttpResponseResult?
//        
//        self.dataRequest = request(url, method: methods, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseString(encoding: String.Encoding.utf8) { (response:DataResponse<String>) in
//            
//            if response.result.value != nil {   // 请求成功
//                requestResult = HttpResponseResult.init(status: true, result: response.result.value! )
//            } else {
//                
//                if let errorStr = response.result.error?.localizedDescription {
//                    requestResult = HttpResponseResult.init(status: false, result: errorStr)
//                } else {
//                    requestResult = HttpResponseResult.init(status: false, result: "")
//                }
//            }
//            responseBlock(requestResult!)
//        }
//    }
//    
//    func getLineChartReport(_ url: String, parameters: [String: AnyObject], success: @escaping ()->Void, failure:@escaping (_ str:String ) -> Void) -> Void {
//        self.requestData(url: url, parameters: [:], methods: .get) { (res: HttpResponseResult) in
//            if res.success {
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
//    
//    }
//    
//    func cancelRequest() -> Void {
//        if let request = self.dataRequest {
//            request.cancel()
//        }
//    }
//    
//}
