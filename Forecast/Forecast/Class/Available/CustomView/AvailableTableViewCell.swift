//
//  AvailableTableViewCell.swift
//  Forecast
//
//  Created by appledev110 on 11/30/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class AvailableTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var skillLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var startLbl: UILabel!
    @IBOutlet weak var endLbl: UILabel!
    @IBOutlet weak var marketLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func initUI(arr: PersonModel,skillStr: String) {
        nameLbl.text = " " + arr.name!
        skillLbl.text = " " + skillStr
        titleLbl.text = " " + arr.title!
        startLbl.text = " " + arr.startOnbench!
        endLbl.text = " " + arr.endOnbench!
        marketLbl.text = " " + arr.market!
//        self.nameLbl?.layer.borderColor = UIColor.gray.cgColor
//        self.nameLbl?.layer.borderWidth = 0.5
//        self.skillLbl?.layer.borderColor = UIColor.gray.cgColor
//        self.skillLbl?.layer.borderWidth = 0.5
//        self.titleLbl?.layer.borderColor = UIColor.gray.cgColor
//        self.titleLbl?.layer.borderWidth = 0.5
//        self.rlLbl?.layer.borderColor = UIColor.gray.cgColor
//        self.rlLbl?.layer.borderWidth = 0.5
//        self.coachLbl?.layer.borderColor = UIColor.gray.cgColor
//        self.coachLbl?.layer.borderWidth = 0.5
//        self.marketLbl?.layer.borderColor = UIColor.gray.cgColor
//        self.marketLbl?.layer.borderWidth = 0.5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
