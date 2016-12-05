//
//  ReportPieChartModel.swift
//  Forecast
//
//  Created by Perry Z Chen on 11/1/16.
//  Copyright © 2016 Perry Z Chen. All rights reserved.
//

import Foundation
import ObjectMapper

class PieChartDataListModel: Mappable {
    var responseMsg: String?
    var responseData: [PieChartDataModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.responseMsg <- map["msg"]
        self.responseData <- map["data"]
    }
}

class PieChartDataModel: Mappable {
    var key: String?
    var y: String?
    var color: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.key <- map["key"]
        self.y <- map["y"]
        self.color <- map["color"]
    }
}
