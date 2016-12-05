//
//  AvailableModel.swift
//  Forecast
//
//  Created by appledev110 on 11/30/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit
import ObjectMapper

class AvailableModel: Mappable {
    var msg: String?
    var data: [PersonListModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.msg <- map["msg"]
        self.data <- map["data"]
    }
}

class PersonListModel: Mappable {
    
    var skill: String?
    var person: [PersonModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.skill <- map["skill"]
        self.person <- map["person"]
    }
}

class PersonModel: Mappable {
    var name: String?
    var title: String?
    var rl: String?
    var coach: String?
    var market: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.title <- map["title"]
        self.rl <- map["relationship leader"]
        self.coach <- map["coach"]
        self.market <- map["market"]
    }
}

//class AvailableModel: Mappable {
//    var msg: String?
//    var data: [PersonListModel]?
//    
//    required init?(map: Map) {
//        
//    }
//    
//    func mapping(map: Map) {
//        self.msg <- map["msg"]
//        self.data <- map["data"]
//    }
//}
//
//class PersonListModel: Mappable {
//    var skill: String?
//    var person: [PersonModel]?
//    
//    required init?(map: Map) {
//        
//    }
//    
//    func mapping(map: Map) {
//        self.skill <- map["skill"]
//        self.person <- map["person"]
//    }
//}
//
//
//class PersonModel: Mappable {
//    var name: String?
//    var title: String?
//    var rl: String?
//    var coach: String?
//    var market: String?
//    required init?(map: Map) {
//        
//    }
//    
//    func mapping(map: Map) {
//        self.name <- map["name"]
//        self.title <- map["title"]
//        self.rl <- map["relationship leader"]
//        self.coach <- map["coach"]
//        self.market <- map["market"]
//    }
//}
