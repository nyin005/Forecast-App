//
//  OptionView.swift
//  JoeApp
//
//  Created by appledev018 on 3/24/16.
//  Copyright © 2016 PwC. All rights reserved.
//

import UIKit

let singleView = OptionView ()

class OptionView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ToBorderDistance: NSLayoutConstraint!
    @IBOutlet weak var slideContainer: UIView!
    
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var headerViewContainer: UIView!
    @IBOutlet weak var slideTableView: UITableView!
    var items: NSMutableDictionary = [:]
    var cellTouchUpHandler : CellTouchUpBlock?
    
    class var shareManager : OptionView {
        return singleView
    }
    
    
    func initUI() {
        ToBorderDistance.constant = LCDW / 2 + 180
        slideTableView.delegate = self
        slideTableView.dataSource = self
        slideTableView.register(UINib(nibName: "SlideTableViewCell", bundle: nil), forCellReuseIdentifier: "SlideTableViewCell")
        self.layoutIfNeeded()
        
        let view =  Bundle.main.loadNibNamed("SlideTableHeaderView", owner: self, options: nil)?[0] as? SlideTableHeaderView
        
        view?.frame = headerViewContainer.bounds
//        view?.initUI()
        headerViewContainer.addSubview(view!)
        view?.layoutIfNeeded()
        
        //        slideContainer.frame = CGRectMake(CGFloat(0 - LCDW + 70), 0, self.width(), LCDH)
        slideContainer.frame = CGRect(x: CGFloat(0 - LCDW + 70), y: 0, width: self.width(), height: LCDH)
        greyView.alpha = 0
        slideTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            self.greyView.alpha = 0.5
            
            self.slideContainer.frame = CGRect(x: 0, y: 0, width: self.width(), height: LCDH)
        }, completion: nil)
        
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(OptionView.handleSwipeGesture))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.left
        self.addGestureRecognizer(swipeGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(OptionView.handleSwipeGesture))
        
        self.greyView.addGestureRecognizer(tapGesture)
        
        
    }
    
    func handleSwipeGesture(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                self.greyView.alpha = 0
                
                self.slideContainer.setX(x: -LCDW)
            }) { (Bool) -> Void in
                self.removeFromSuperview()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.layoutIfNeeded()
        let cell = tableView.dequeueReusableCell(withIdentifier: "SlideTableViewCell") as! SlideTableViewCell
        cell.initUI(items: items, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let view = UIView()
//        view.backgroundColor = UIColor(red: 231/255, green: 230/255, blue: 221/255, alpha: 1)
//        
//        return view
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return CGFloat(8)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.items["didSelect"] = indexPath.item
        tableView.reloadData()
        if cellTouchUpHandler != nil {
            cellTouchUpHandler!(indexPath as IndexPath,"" as AnyObject)
            
        }
    }
    
    
}
