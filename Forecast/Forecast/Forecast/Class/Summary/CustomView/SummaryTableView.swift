//
//  SummaryTableView.swift
//  Forecast
//
//  Created by appledev110 on 11/22/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class SummaryTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var reports = [SummaryTimeModel]()
    var cellClickedHandler: ButtonTouchUpWithParmBlock?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame,style: style)
        
        self.delegate = self
        self.dataSource = self
        self.register(UINib(nibName: "SummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SummaryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SummaryTableViewCell
        cell.initDetailUI(listModel: reports[indexPath.row])
        cell.onBenchClickedHandler = {
//            print(indexPath.row)
            if self.cellClickedHandler != nil {
                self.cellClickedHandler!(indexPath.row as AnyObject)
            }
        }
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10.0
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return reports[section].date
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
////        let placeholderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10))
//        let placeholderView = UIView()
//        placeholderView.backgroundColor = .clear
//        return placeholderView
//    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10.0
//    }
//    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let placeholderView = UIView()
//        placeholderView.backgroundColor = .clear
//        return placeholderView
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178
    }
    
}
