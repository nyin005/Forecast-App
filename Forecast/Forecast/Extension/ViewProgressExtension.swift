//
//  ViewProgressExtension.swift
//  BusinessOS
//
//  Created by Jian Zhang on 11/2/15.
//  Copyright © 2015 PwC. All rights reserved.
//

import UIKit
import JGProgressHUD

let window = UIApplication.shared.windows[0]
var hud : JGProgressHUD?

extension UIView
{
    func showhud()
    {
        hud = JGProgressHUD.init(style: .dark)
        hud?.show(in: self)
    }
    
    func showhudAndDismiss() {
        self.showhud()
        hud?.dismiss(afterDelay: 3)
    }
    
    func showhudForString(_ str : String ) {
        hud = JGProgressHUD.init(style: .dark)
        hud?.textLabel.text = str
        hud?.show(in: self)
        hud?.dismiss(afterDelay: 3)
    }
    
    func showhudForError(_ str : String) {
        hud = JGProgressHUD.init(style: .dark)
        hud?.textLabel.text = str
        hud?.indicatorView = JGProgressHUDErrorIndicatorView.init()
        hud?.show(in: self)
        hud?.dismiss(afterDelay: 3)
    }
    
    func hidehud(){
        hud?.dismiss(animated: true)
    }
}

