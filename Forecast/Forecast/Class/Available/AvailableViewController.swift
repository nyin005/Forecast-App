//
//  AvailableViewController.swift
//  Forecast
//
//  Created by appledev110 on 11/30/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class AvailableViewController: BaseViewController {

    var availableModel: AvailableModel?
    var availableTabView: AvailableTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initNavView(title: "Available", bolBack: false, bolRefresh: false)
        fetchAvailableData()
    }

    
    func fetchAvailableData() {
        let path = Bundle.main.path(forResource: "available", ofType: "json")
        do {
            let content = try String(contentsOfFile: path!)
            self.availableModel = AvailableModel(JSONString: content)!
           
        } catch _ {
            
        }
        if self.availableModel != nil {
            initAvailableView()
        }
    }
    
    func initAvailableView() {
        availableTabView = AvailableTableView(frame: CGRect(x: 0, y: 32, width: LCDW, height: LCDH - 32))
        availableTabView?.items = (availableModel?.data)!
        self.view.addSubview(availableTabView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
