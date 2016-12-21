//
//  TabBarView.swift
//  LarsonApp
//
//  Created by appledev110 on 10/27/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class TabBarView: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var tabHandler : ReturnBlock?

    var titleArr = [String]()
    let btnWidth = LCDW / 3
    let redLineHeight: CGFloat = 2
    
    var redLine : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        if appDelegate.tabVC?.selectedIndex == 0 {
//            titleArr = ["IMAT Monthly UT% Line Chart","YTD Attrition% By Team","On Bench Employee","Current Month HC by Team","YTD Hours By Project Type","Length Of Service year Overall"]
//        }
//        else if appDelegate.tabVC?.selectedIndex == 2 {
//            titleArr = ["Mobility","User Experience","SOA","Enterprise Data Management","Business Intelligence","Advance Analytic Technology","Salesforce","Overall"]
//        }
        
        titleArr = ["IMAT Monthly UT% Line Chart","On Bench Employee","Current Month HC by Team","YTD Hours By Project Type","Length Of Service year Overall","YTD Attrition% By Team"]
        
        self.contentSize.height = frame.height
        self.contentSize.width = btnWidth * CGFloat(titleArr.count)
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = StringUtil.getColorWithRGB(red: 231, green: 230, blue: 221)
        
        for i in 0...titleArr.count - 1 {
            
        let btn = MKButton.init(frame: CGRect(x: CGFloat(i) * btnWidth, y: 0, width: btnWidth, height: frame.height))
            btn.tag = 10 + i
            btn.setTitle(titleArr[i], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            btn.titleLabel?.numberOfLines = 0
            btn.setTitleColor(StringUtil.getColorWithRGB(red: 116, green: 107, blue: 100), for: .normal)
            btn.addTarget(self, action: #selector(TabBarView.btnTapped), for: .touchUpInside)
            self.addSubview(btn)
        }
        
        redLine = UIView.init(frame: CGRect(x: 0, y: frame.height - redLineHeight , width: btnWidth, height: redLineHeight))
        redLine?.backgroundColor = StringUtil.getColorWithRGB(red: 166, green: 156, blue: 145)
        self.addSubview(redLine!)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    func btnTapped (_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) { 
            self.redLine?.frame = CGRect(x: sender.frame.minX, y: self.frame.height - self.redLineHeight , width: self.btnWidth, height: self.redLineHeight)
            if sender.tag != 10 && sender.tag != 10 + self.titleArr.count - 1 {
                self.contentOffset.x = sender.frame.minX - self.btnWidth
            }
            
            let index = sender.tag - 10
            if self.tabHandler != nil {
                self.tabHandler!(index as AnyObject)
            }
        }
    }
    
    func scrollByView (index : Int){
        UIView.animate(withDuration: 0.3) {
            
            if index != 0 && index != self.titleArr.count - 1 {
            
        self.contentOffset.x = self.btnWidth * (CGFloat(index) - 1)
            }
         self.redLine?.frame = CGRect(x: CGFloat(index) * self.btnWidth, y: self.frame.height - self.redLineHeight , width: self.btnWidth, height: self.redLineHeight)
        }
    }
    
    

}
