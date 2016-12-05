//
//  ReportLineChartModel.swift
//  Forecast
//
//  Created by Perry Z Chen on 11/1/16.
//  Copyright © 2016 Perry Z Chen. All rights reserved.
//

import Foundation
import ObjectMapper

class LineChartDataRootModel: Mappable {
    var responseMsg: String?
    var responseData: [LineChartDataListModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.responseMsg <- map["msg"]
        self.responseData <- map["data"]
    }

}

class LineChartDataListModel: Mappable {
    
    var key: String?
    var values: [LineChartDataModel]?
    var color: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.key <- map["key"]
        self.values <- map["values"]
        self.color <- map["color"]
    }
    
    var description: String {
        get {
            return Mapper().toJSONString(self, prettyPrint: false)!
        }
    }
    
}

class LineChartDataModel: Mappable{
    
    var label: String?
    var value: Double?
    var timeInteval: TimeInterval?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.label <- (map["label"], transformOfDateAndString())
        self.value <- map["value"]
        self.timeInteval <- map["label"]
    }
    
    var description: String {
        get {
            return Mapper().toJSONString(self, prettyPrint: false)!
        }
    }
}
