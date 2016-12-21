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
    var reportViewModel : ReportViewModel = ReportViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initNavView(title: "Availability", bolBack: false, bolRefresh: true)
        self.view.showhud()
        self.reportViewModel.getAvailableReport("https://forecast-production.herokuapp.com/api/report/obes", parameters: [:], success: {
            self.initAvailableView()
        }) { (errStr) in
            self.errorAlert(errStr: errStr)
        }
        self.hNav?.refreshBtnHandler = {
            self.viewDidLoad()
        }
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
        availableTabView?.items = (self.reportViewModel.availableModel?.data)!
        self.view.addSubview(availableTabView!)
        self.view.hidehud()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
