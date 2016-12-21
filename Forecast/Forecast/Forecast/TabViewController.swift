//
//  TabViewController.swift
//  Forecast
//
//  Created by appledev110 on 11/17/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    var first : DashBoardViewController!
    var second : AvailableViewController!
    var third: SummaryViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
    }
    
    func initUI() {
        first = DashBoardViewController()
        self.addChildVC(childVC: first)
        first.sideBarTappedHandler = {(index) -> Void in
            self.selectedIndex = NSInteger(index as! NSNumber)
        }
        
        second = AvailableViewController()
        self.addChildVC(childVC: second)
        second.sideBarTappedHandler = {(index) -> Void in
            self.selectedIndex = NSInteger(index as! NSNumber)
        }
        
        third = SummaryViewController()
        self.addChildVC(childVC: third)
        third.sideBarTappedHandler = {(index) -> Void in
            self.selectedIndex = NSInteger(index as! NSNumber)
        }
    }
    
    func addChildVC(childVC : UIViewController){
        let nav = NavViewController(rootViewController: childVC)
        self.addChildViewController(nav)
    }
    
}
