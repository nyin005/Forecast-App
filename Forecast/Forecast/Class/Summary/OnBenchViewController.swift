//
//  OnBenchViewController.swift
//  Forecast
//
//  Created by appledev110 on 11/23/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class OnBenchViewController: BaseViewController {

    var titleStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initNavView(title: titleStr, bolBack: true, bolRefresh: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
