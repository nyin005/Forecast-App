//
//  ReportLosModel.swift
//  Forecast
//
//  Created by Perry Z Chen on 10/26/16.
//  Copyright © 2016 Perry Z Chen. All rights reserved.
//

import Foundation
import ObjectMapper

class ReportLosModel: Mappable {
    var responseMsg: String?
    var responseData: [LosListModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.responseMsg <- map["msg"]
        self.responseData <- map["data"]
    }
}

class LosListModel: Mappable {
    
    var LosKey: String?
    var LosColor: String?
    var LosValues: [LosModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.LosKey <- map["key"]
        self.LosColor <- map["color"]
        self.LosValues <- map["values"]
    }
    
    var description: String {
        get {
            return Mapper().toJSONString(self, prettyPrint: false)!
        }
    }
    
}

class LosModel: Mappable {
    var label: String?
    var value: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.label <- map["label"]
        self.value <- map["value"]
    }
}

class BarChartGroupModel {
    var labelDesc: String?
    var value: String?
    
}

