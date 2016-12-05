//
//  SlideTableViewCell.swift
//  JoeApp
//
//  Created by appledev018 on 3/24/16.
//  Copyright © 2016 PwC. All rights reserved.
//

import UIKit

class SlideTableViewCell: UITableViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    
    func initUI(items: NSMutableDictionary, index: Int){
        cellLabel.text = items.value(forKey: "\(index)") as? String
        cellLabel.textColor = StringUtil.getColorWithRGB(red: 166, green: 156, blue: 145)
        self.backgroundColor = UIColor(red: 231/255, green: 230/255, blue: 221/255, alpha: 1)

        if index == items.value(forKey: "didSelect") as! Int {
            cellLabel.textColor = UIColor.white
            self.backgroundColor = StringUtil.getColorWithRGB(red: 166, green: 156, blue: 145)
            
            cellImage.image = UIImage(named: items.value(forKey: "\(index)") as! String + "_1")
//            cellImage.backgroundColor = UIColor.white
        } else {
            cellImage.image = UIImage(named: items.value(forKey: "\(index)") as! String)
//            cellImage.backgroundColor = StringUtil.getColorWithRGB(red: 166, green: 156, blue: 145)
        }
        
    }
    
}
