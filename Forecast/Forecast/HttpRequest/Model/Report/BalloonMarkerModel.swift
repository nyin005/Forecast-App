//
//  BalloonMarkerModel.swift
//  Forecast
//
//  Created by Perry Z Chen on 10/27/16.
//  Copyright © 2016 Perry Z Chen. All rights reserved.
//

import Foundation
class BalloonMarkerModel: NSObject {
    var value: Double?
    var keyDesc: String?
    
    init(value: Double, desc: String) {
        self.value = value
        self.keyDesc = desc
    }
}
