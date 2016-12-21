//
//  ObjectMapperTransform.swift
//  Forecast
//
//  Created by Perry Z Chen on 10/24/16.
//  Copyright © 2016 Perry Z Chen. All rights reserved.
//

import Foundation
import ObjectMapper
func formatter() -> DateFormatter{
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM yyyy"
    return formatter
}
//将"yyyy-MM-dd"格式的string转成date
func transformOfDateAndString() ->TransformOf<String , TimeInterval>{

    return TransformOf<String, TimeInterval>.init(fromJSON: { (JSONInt) -> String? in
        if let intValue = JSONInt {
            return formatter().string(from: Date(timeIntervalSince1970: intValue / 1000))
        }
        return nil
        }, toJSON: { (date) -> TimeInterval? in
            if let date = date{
                return formatter().date(from: date)?.timeIntervalSince1970
            }
            return nil

    })

}
