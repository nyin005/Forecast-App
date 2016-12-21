//
//  SummaryViewController.swift
//  Forecast
//
//  Created by appledev110 on 11/22/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class SummaryViewController: BaseViewController {

    var scrollViewSet: ScrollViewSet?
    var summaryView: SummaryTableView?
    var onBenchVC: OnBenchViewController?
    
    private var summaryModel: SummaryListModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initNavView(title: "Summary", bolBack: false, bolRefresh: false)
        
        fetchSummaryData()

    }

    func fetchSummaryData() {
        let path = Bundle.main.path(forResource: "summary", ofType: "json")
        do {
            let content = try String(contentsOfFile: path!)
            self.summaryModel = SummaryListModel(JSONString: content)!
        } catch _ {
            
        }
        if self.summaryModel != nil {
            initUI()
            
        }
    }
    
    func initUI() {        
        scrollViewSet = ScrollViewSet.init(frame: CGRect(x: 0, y: 32, width: LCDW, height: LCDH - 32))
        self.view.addSubview(scrollViewSet!)
        initSummaryView()
    }
    
    func initSummaryView() {
        for i in 0..<Int((self.summaryModel?.data.count)!) {
            summaryView = SummaryTableView.init(frame: CGRect(x: CGFloat(i) * LCDW, y: 0, width: LCDW, height: LCDH - 64), style: .plain)
            summaryView?.reports = (self.summaryModel?.data[i].reports)!
            summaryView?.cellClickedHandler = {(obj) -> Void in
                let index : Int = Int(obj as! NSNumber)
                self.openOnBenchVC(titleStr: (self.summaryModel?.data[index].reports[index].date)!)
            }
            self.scrollViewSet?.scrollView?.addSubview(summaryView!)
        }
    }
    
    func openOnBenchVC(titleStr: String) {
        onBenchVC = OnBenchViewController()
        onBenchVC?.titleStr = titleStr
        self.navigationController?.pushViewController(onBenchVC!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
