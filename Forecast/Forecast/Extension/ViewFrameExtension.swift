//
//  ViewFrameExtension.swift
//  BusinessOS
//
//  Created by Jian Zhang on 11/9/15.
//  Copyright © 2015 PwC. All rights reserved.
//

import UIKit

extension UIView
{
    func width() -> CGFloat
    {
        return self.frame.size.width
    }
    
    func height() -> CGFloat
    {
        return self.frame.size.height
    }
    
    func x() -> CGFloat
    {
        return self.frame.origin.x
    }
    
    func y() -> CGFloat
    {
        return self.frame.origin.y
    }
    
    func right() -> CGFloat
    {
        return self.x() + self.width()
    }
    
    func bottom() -> CGFloat
    {
        return self.y() + self.height()
    }

    func setY(y : CGFloat)
    {
        self.frame.origin.y = y
    }
    func setX(x : CGFloat)
    {
        self.frame.origin.x = x
    }
    func setHeight(height : CGFloat)
    {
        self.frame.size.height = height
    }
    func setWidth(width : CGFloat)
    {
        self.frame.size.width = width
    }
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 9, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}
