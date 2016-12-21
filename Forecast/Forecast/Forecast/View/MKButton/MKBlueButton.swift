//
//  MKBlueButton.swift
//  JoeApp
//
//  Created by Jian Zhang on 3/14/16.
//  Copyright © 2016 PwC. All rights reserved.
//

import UIKit

class MKBlueButton: MKButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = 2
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        }

}
