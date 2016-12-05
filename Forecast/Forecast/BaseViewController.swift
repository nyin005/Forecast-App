//
//  BaseViewController.swift
//  Forecast
//
//  Created by appledev110 on 11/11/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var hNav: HorizontalNavView?
    
    var optionView = OptionView.shareManager
    
    var sideBarTappedHandler : ReturnBlock?
    
    var items = DataManager.shareManager.items
    
    var tapGes : UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
//        listenTapGesture()
    }
    
    func listenTapGesture(){
        tapGes = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.viewTapped))
        tapGes?.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGes!)
    }
    
    func viewTapped(){
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    
    func initNavView(title : String, bolBack : Bool, bolRefresh: Bool) {
    
        hNav = HorizontalNavView.init(frame: CGRect(x: 0, y: 0, width: LCDW, height: 32))
        hNav?.initUI(str: title, bolBack: bolBack, bolRefresh: bolRefresh)
        hNav?.opertionBtnHandler = {
            if bolBack == true
            {
                let _ = self.navigationController?.popViewController(animated: true)
            }
            else
            {
                self.initSideBar()
            }
        }
        self.view.addSubview(self.hNav!)
        
    }
    
    func initSideBar(){
        self.optionView = (Bundle.main.loadNibNamed("OptionView", owner: self, options: nil)?[0] as? OptionView)!
        self.optionView.items = self.items
        self.optionView.frame = self.view.bounds
        self.optionView.initUI()
        
        self.view.addSubview(self.optionView)
        self.optionView.cellTouchUpHandler = {(index, obj) -> Void in
            self.items["didSelect"] = index.item
            self.optionView.handleSwipeGesture()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            DispatchQueue.main.async {
                appDelegate.tabVC?.selectedIndex = index.row
                let currentVC = appDelegate.tabVC?.childViewControllers[index.row] as! UINavigationController
                currentVC.popToRootViewController(animated: false)
            }
        }
    }
    
}


