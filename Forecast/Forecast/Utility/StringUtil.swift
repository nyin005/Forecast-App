
//
//  StringUtil.swift
//  BusinessOS
//
//  Created by Jian Zhang on 10/27/15.
//  Copyright © 2015 PwC. All rights reserved.
//

import UIKit

class StringUtil: NSObject {

    class func getStringFromDate(date : Date, format : String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        // Date 转 String
        let nowString = dateFormatter.string(from: date)
        return nowString
    }
    
    class func getDateFromString(date : String, format : String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        let nowString = dateFormatter.date(from: date)
        return nowString!
    }
    
    class func getColorWithRGB(red:CGFloat, green:CGFloat, blue:CGFloat)->UIColor
    {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    class func getColorWithRGB(red:CGFloat, green:CGFloat, blue:CGFloat, alpha : CGFloat)->UIColor
    {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    
    class func getAttributeString(str : NSMutableAttributedString, width : CGFloat) -> CGFloat
    {
        let options : NSStringDrawingOptions = unsafeBitCast(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue |
            NSStringDrawingOptions.usesFontLeading.rawValue,
            to: NSStringDrawingOptions.self)
        let rect = str.boundingRect(with:CGSize(width: width, height: 10000), options: options, context: nil)
        return rect.height
    }
    
    class func getAttributeStringWidth(str : NSMutableAttributedString, height : CGFloat) -> CGFloat
    {
        let options : NSStringDrawingOptions = unsafeBitCast(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue |
            NSStringDrawingOptions.usesFontLeading.rawValue, to: NSStringDrawingOptions.self)
        
        let rect = str.boundingRect(with: CGSize(width: 10000, height: height), options: options, context: nil)
        return rect.width
    }
    
    class func getSpecWordToEnd(oldStr : String, middleStr : String) -> String
    {
        let oldStr2 = oldStr
        let range = oldStr.range(of: middleStr + "/")
        return oldStr2.replacingCharacters(in: range!, with: "")
    }
}
