//
//  CustomDetailView.swift
//  Forecast
//
//  Created by appledev110 on 11/22/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class CustomDetailView: UIView {

    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!

    func initValue(listModel: SummaryValueModel) {
        dataLabel.text = listModel.title
        contentLabel.text = listModel.value
    }
}
