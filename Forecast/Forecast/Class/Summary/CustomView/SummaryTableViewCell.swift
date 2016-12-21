//
//  SummaryTableViewCell.swift
//  Forecast
//
//  Created by appledev110 on 11/22/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLalel: UILabel!
    var onBenchClickedHandler: ButtonTouchUpBlock?
    var customDetailView: CustomDetailView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code    
        self.selectionStyle = .none
    }
    
    func initDetailUI(listModel: SummaryTimeModel) {
        
        for i in 0..<listModel.values.count {
            dateLalel.text = listModel.date
            let containerView = self.viewWithTag(i+11)
            self.customDetailView = Bundle.loadView(fromNib: "CustomDetailView", withType: CustomDetailView.self)
            self.customDetailView?.initValue(listModel: listModel.values[i])
            self.customDetailView?.frame = (containerView?.bounds)!
            self.customDetailView?.layer.borderColor = UIColor.gray.cgColor
            self.customDetailView?.layer.borderWidth = 0.5
            if i == 1 {
                customDetailView?.backgroundColor = UIColor.yellow
                let tapGesturer = UITapGestureRecognizer(target: self, action: #selector(selectOnbench))
                customDetailView?.addGestureRecognizer(tapGesturer)
            }
            containerView?.addSubview(self.customDetailView!)
        }
        
    }
    
    func selectOnbench(sender: UITapGestureRecognizer) {
        if onBenchClickedHandler != nil {
            self.onBenchClickedHandler!()
        }
    }

    
}
