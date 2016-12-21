//
//  SummaryModel.swift
//  Forecast
//
//  Created by Perry Z Chen on 11/3/16.
//  Copyright © 2016 Perry Z Chen. All rights reserved.
//

import Foundation
import ObjectMapper

class SummaryListModel: Mappable {
    var msg: String
    var data: [SummaryDepartModel]
    
    required init?(map: Map) {
        self.msg = ""
        self.data = [SummaryDepartModel]()
    }
    
    func mapping(map: Map) {
        self.msg <- map["msg"]
        self.data <- map["data"]
    }
}

class SummaryDepartModel: Mappable {
    var department: String
    var reports: [SummaryTimeModel]
    
    required init?(map: Map) {
        self.department = ""
        self.reports = [SummaryTimeModel]()
    }
    
    func mapping(map: Map) {
        self.department <- map["department"]
        self.reports <- map["reports"]
    }
    
}

class SummaryTimeModel: Mappable {
    var date: String
    var values: [SummaryValueModel]
    
    required init?(map: Map) {
        self.date = ""
        self.values = [SummaryValueModel]()
    }
    
    func mapping(map: Map) {
        self.date <- map["date"]
        self.values <- map["values"]
    }
}

class SummaryValueModel: Mappable {
    var title: String
    var value: String
    
    required init?(map: Map) {
        self.title = ""
        self.value = ""
    }
    
    func mapping(map: Map) {
        self.title <- map["title"]
        self.value <- map["value"]
    }
    
}

