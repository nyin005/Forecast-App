//
//  DashBoardViewController.swift
//  Forecast
//
//  Created by appledev110 on 11/17/16.
//  Copyright © 2016 appledev110. All rights reserved.
//

import UIKit

class DashBoardViewController: BaseViewController {
    
    var scrollViewSet: ScrollViewSet?
    var lineChartView: LineChartRootView?
    var losChartView: BarChartRootView?
    var pieChartView: PieChartRootView?
    var reportViewModel : ReportViewModel = ReportViewModel()
    private var losModel: ReportLosModel? = nil
    
    var BaseURL = "https://forecast-production.herokuapp.com/api/report/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        DispatchQueue.main.async {
            self.initNavView(title: "DashBoard", bolBack: false, bolRefresh: true)
            self.initUI()
            self.view.showhud()
            
            // reload chart scrollview
            self.hNav?.testBtnHandler = {
                self.scrollViewSet?.scrollView?.removeFromSuperview()
                self.viewDidLoad()
            }
        }
        
    }    
    
    func initUI() {
        scrollViewSet = ScrollViewSet.init(frame: CGRect(x: 0, y: 32, width: LCDW, height: LCDH - 32))
        self.view.addSubview(scrollViewSet!)
        initData()
    }
    
    func initData() {
        self.reportViewModel.getLineChartReport("\(BaseURL)\("ut")", parameters: [:], success: {
            self.initUT()
            self.reportViewModel.getLosReport("\(self.BaseURL)\("obe")", parameters: [:], success: {
                self.initLos()
                self.reportViewModel.getPieChartReport("\(self.BaseURL)\("hc")", parameters: [:], success: {
                    self.initHC()
                    self.reportViewModel.getPieChartReport("\(self.BaseURL)\("ytdh")", parameters: [:], success: {
                        self.initYTDH()
                        self.reportViewModel.getPieChartReport("\(self.BaseURL)\("lospie")", parameters: [:], success: {
                            self.initLosPie()
                                self.reportViewModel.getLineChartReport("\(self.BaseURL)\("ma")", parameters: [:], success: {
                                    self.initMA()
                                }) { (errStr) in
                                    self.errorAlert(errStr: errStr)
                                }
                            }) { (errStr) in
                                self.errorAlert(errStr: errStr)
                            }
                    }) { (errStr) in
                        self.errorAlert(errStr: errStr)
                    }
                }) { (errStr) in
                    self.errorAlert(errStr: errStr)
                }
            }) { (errStr) in
                self.errorAlert(errStr: errStr)
            }
        }) { (errStr) in
            self.errorAlert(errStr: errStr)
        }
    }
    
    func initUT() {
        lineChartView = Bundle.main.loadNibNamed("LineChartRootView", owner: self, options: nil)?[0] as? LineChartRootView
        self.lineChartView?.frame = CGRect(x: 0, y: 0, width: LCDW, height: (self.scrollViewSet?.scrollView?.height())!)
        self.lineChartView?.initChartUI(arr: (self.reportViewModel.lineChartRootModel?.responseData)!)
        self.scrollViewSet?.scrollView?.addSubview(self.lineChartView!)
    }
    
    func initMA() {
        lineChartView = Bundle.main.loadNibNamed("LineChartRootView", owner: self, options: nil)?[0] as? LineChartRootView
        self.lineChartView?.frame = CGRect(x: LCDW * 5, y: 0, width: LCDW, height: (self.scrollViewSet?.scrollView?.height())!)
        self.lineChartView?.initChartUI(arr: (self.reportViewModel.lineChartRootModel?.responseData)!)
        self.scrollViewSet?.scrollView?.addSubview(self.lineChartView!)
    }
    
    func initLos() {
        losChartView = Bundle.main.loadNibNamed("BarChartRootView", owner: self, options: nil)?[0] as? BarChartRootView
        self.losChartView?.frame = CGRect(x: LCDW, y: 0, width: LCDW, height: (self.scrollViewSet?.scrollView?.height())!)
        self.losChartView?.initChartUI(arr: (self.reportViewModel.losListModel?.responseData)!)
        self.scrollViewSet?.scrollView?.addSubview(self.losChartView!)
    }
    
    func initHC() {
        pieChartView = Bundle.main.loadNibNamed("PieChartRootView", owner: self, options: nil)?[0] as? PieChartRootView
        self.pieChartView?.frame = CGRect(x: LCDW * 2, y: 0, width: LCDW, height: (self.scrollViewSet?.scrollView?.height())!)
        self.pieChartView?.initChartUI(arr: (self.reportViewModel.pieChartListModel?.responseData)!)
        self.scrollViewSet?.scrollView?.addSubview(self.pieChartView!)
    }
    
    func initYTDH() {
        pieChartView = Bundle.main.loadNibNamed("PieChartRootView", owner: self, options: nil)?[0] as? PieChartRootView
        self.pieChartView?.frame = CGRect(x: LCDW * 3, y: 0, width: LCDW, height: (self.scrollViewSet?.scrollView?.height())!)
        self.pieChartView?.initChartUI(arr: (self.reportViewModel.pieChartListModel?.responseData)!)
        self.scrollViewSet?.scrollView?.addSubview(self.pieChartView!)
    }
    
    func initLosPie() {
        pieChartView = Bundle.main.loadNibNamed("PieChartRootView", owner: self, options: nil)?[0] as? PieChartRootView
        self.pieChartView?.frame = CGRect(x: LCDW * 4, y: 0, width: LCDW, height: (self.scrollViewSet?.scrollView?.height())!)
        self.pieChartView?.initChartUI(arr: (self.reportViewModel.pieChartListModel?.responseData)!)
        self.scrollViewSet?.scrollView?.addSubview(self.pieChartView!)
        self.view.hidehud()
    }
    
    func errorAlert(errStr: String) {
        let alert: UIAlertController = UIAlertController(title: "Error", message: errStr, preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
        })
        alert.addAction(cancelAction)
        self.navigationController?.showDetailViewController(alert, sender: nil)
        self.view.hidehud()
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
