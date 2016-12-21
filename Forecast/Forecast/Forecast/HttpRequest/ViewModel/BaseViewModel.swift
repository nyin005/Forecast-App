//
//  BaseViewModel.swift
//  Forecast
//
//  Created by Perry Z Chen on 10/21/16.
//  Copyright © 2016 Perry Z Chen. All rights reserved.
//

import Foundation
import Alamofire

struct HttpResponseResult {
    var success: Bool
    var resultString: String
    
    init(status: Bool, result: String) {
        self.success = status
        self.resultString = result
    }
}

class BaseViewModel {
    private var dataRequest: DataRequest?
    
    func requestData(url: String, parameters:[String: AnyObject], methods: HTTPMethod, responseBlock:@escaping (_ res: HttpResponseResult)->Void) -> Void {
        // 记录请求结果
        var requestResult: HttpResponseResult?

        self.dataRequest = request(url, method: methods, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseString(encoding: String.Encoding.utf8) { (response:DataResponse<String>) in
            
            if response.result.value != nil {   // 请求成功
                requestResult = HttpResponseResult.init(status: true, result: response.result.value! )
            } else {
                
                if let errorStr = response.result.error?.localizedDescription {
                    requestResult = HttpResponseResult.init(status: false, result: errorStr)
                } else {
                    requestResult = HttpResponseResult.init(status: false, result: "")
                }
            }
            responseBlock(requestResult!)
        }
    }
    
    func cancelRequest() -> Void {
        if let request = self.dataRequest {
            request.cancel()
        }
    }
}

