//
//  AvailableTableView.swift
//  Forecast
//
//  Created by appledev110 on 11/30/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class AvailableTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var items = [PersonListModel]()
    var placeholderView: TableViewHeaderView?
    
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame,style: style)
        
        self.delegate = self
        self.dataSource = self
//        self.separatorStyle = .none
        self.register(UINib(nibName: "AvailableTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].person!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: AvailableTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AvailableTableViewCell
        cell.initUI(arr: (items[indexPath.section].person?[indexPath.row])!,skillStr: items[indexPath.section].skill!)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        placeholderView = Bundle.main.loadNibNamed("TableViewHeaderView", owner: self, options: nil)?[0] as? TableViewHeaderView
        placeholderView?.initUI(count: items[section].person!.count)
        placeholderView?.backgroundColor = StringUtil.getColorWithRGB(red: 231, green: 230, blue: 221)
        return placeholderView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}

