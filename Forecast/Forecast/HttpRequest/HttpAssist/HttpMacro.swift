//
//  HttpMacro.swift
//  Forecast
//
//  Created by Perry Z Chen on 10/21/16.
//  Copyright © 2016 Perry Z Chen. All rights reserved.
//

import Foundation
private enum HTTPDomain: String {
    case BaseURL = "https://infinite-ridge-31284.herokuapp.com/api/report/"
    case TestURL = "http://localhost:8888/respon.json"
}

enum HttpMacro: String {
    case ReportUT,ReportHC,ReportYTDH,ReportMA,ReportYTDA,ReportLOSPIE,ReportLOS, Original, Test
    
    func combineString(str: String) -> String {
        return HTTPDomain.BaseURL.rawValue + str
    }
    
    func getRequestURL() -> String {
        switch self {
        case .ReportUT:
            return combineString(str: "ut")
        case .ReportHC:
            return combineString(str: "hc")
        case .ReportYTDH:
            return combineString(str: "ytdh")
        case .ReportMA:
            return combineString(str: "ma")
        case .ReportYTDA:
            return combineString(str: "ytda")
        case .ReportLOSPIE:
            return combineString(str: "lospie")
        case .ReportLOS:
            return combineString(str: "los")
        case .Original:
            return combineString(str: "")
        case .Test:
            return HTTPDomain.TestURL.rawValue
        }
    }
}
