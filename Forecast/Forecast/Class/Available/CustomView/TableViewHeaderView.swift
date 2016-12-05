//
//  TableViewHeaderView.swift
//  Forecast
//
//  Created by appledev110 on 11/30/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class TableViewHeaderView: UIView {

    @IBOutlet weak var nameLbl: UILabel!
    
    func initUI(count: Int) {
        nameLbl.text = "Name" + " (" + String(count) + ")"
    }

}
