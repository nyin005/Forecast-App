//
//  HorizontalNavView.swift
//  Forecast
//
//  Created by appledev110 on 11/24/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class HorizontalNavView: UIView {

    var opertionBtnHandler : ButtonTouchUpBlock?
    var testBtnHandler : ButtonTouchUpBlock?
    
    var refreshBtn: UIButton!
    var navTitleLbl: UILabel!
    
    var optionBtn: MKButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = StringUtil.getColorWithRGB(red: 233, green: 140, blue: 36)
        
        optionBtn = MKButton(frame: CGRect(x: 16, y: 1, width: 30, height: 30))
        self.addSubview(optionBtn!)
        
        navTitleLbl = UILabel(frame: CGRect(x: 56, y: 1, width: 100, height: 30))
        navTitleLbl.textColor = UIColor.white
        self.addSubview(navTitleLbl!)
        
        refreshBtn = MKButton(frame: CGRect(x: LCDW - 46, y: 1, width: 30, height: 30))
        refreshBtn.setImage(UIImage(named:"refresh"), for: .normal)
        self.addSubview(refreshBtn!)
        
        optionBtn.addTarget(self, action: #selector(optionAction), for: .touchUpInside)
        refreshBtn.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(str : String, bolBack : Bool, bolRefresh: Bool){
        navTitleLbl.text = str
        if bolBack == true {
            optionBtn.setImage(UIImage(named: "CloseWhite"), for: UIControlState.normal)
        } else {
            optionBtn.setImage(UIImage(named:"Menu"), for: .normal)
        }
        if bolRefresh == false {
            refreshBtn.isHidden = true
        } else {
            refreshBtn.isHidden = false
        }
    }
    
    func optionAction() {
        if opertionBtnHandler != nil {
            opertionBtnHandler!()
        }
    }
    
    func refreshAction() {
        if testBtnHandler != nil {
            testBtnHandler!()
        }
    }

}
