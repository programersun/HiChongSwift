//
//  WikiListViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/26.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class WikiListViewController: UIViewController {
    
    var cate_id: String?
    
    private var healthData: [WikiMoreData]?
    private var keepData: [WikiMoreData]?
    private var trainData: [WikiMoreData]?
    
    private enum articleType: Int {
        case Health = 1
        case Keep = 2
        case Train = 3
    }
    private var type: articleType = .Keep
    
    /// 页面标题
    var navigationItemTitle: String?
    
    @IBOutlet private weak var icySegmentControl: UISegmentedControl!
    @IBOutlet private weak var icyTableView: UITableView!
    
    private var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        icySegmentControl.setBackgroundImage(UIImage(named: "sqSegmentNormal"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        icySegmentControl.setBackgroundImage(UIImage(named: "sqSegmentSelected"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        icySegmentControl.setDividerImage(UIImage(named: "sqSegmentNormal"), forLeftSegmentState: UIControlState.Normal, rightSegmentState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        
        navigationItem.title = navigationItemTitle
        
        reload()
    }
    
    private func reload() {
        if cate_id == nil {
            cate_id = "0"
        }
        let parameters = [
            "cate_id": cate_id!,
            "type_id": "\(type.rawValue)",
            "p": "\(currentPage)"
        ]
        typealias mySuccessClosure = ((object: NSDictionary) -> Void)
        var successClosure: mySuccessClosure?
        switch type {
        case .Health:
            successClosure = {
                [weak self] (object: NSDictionary) -> Void in
                let retrived = WikiMoreBase.modelObjectWithDictionary(object)
                self?.healthData = [WikiMoreData]()
                if let data = retrived.data {
                    self?.healthData?.extend(data as [WikiMoreData])
                    if self?.icySegmentControl.selectedSegmentIndex == 0 {
                        self?.icyTableView.reloadData()
                    }
                }
            }
            break
        case .Keep:
            successClosure = {
                [weak self] (object: NSDictionary) -> Void in
                let retrived = WikiMoreBase.modelObjectWithDictionary(object)
                self?.keepData = [WikiMoreData]()
                if let data = retrived.data {
                    self?.keepData?.extend(data as [WikiMoreData])
                    if self?.icySegmentControl.selectedSegmentIndex == 1 {
                        self?.icyTableView.reloadData()
                    }
                }
            }
            break
        case .Train:
            successClosure = {
                [weak self] (object: NSDictionary) -> Void in
                let retrived = WikiMoreBase.modelObjectWithDictionary(object)
                self?.trainData = [WikiMoreData]()
                if let data = retrived.data {
                    self?.trainData?.extend(data as [WikiMoreData])
                    if self?.icySegmentControl.selectedSegmentIndex == 2 {
                        self?.icyTableView.reloadData()
                    }
                }
            }
            break
        }
        LCYNetworking.sharedInstance.GET(LCYApi.WikiMore, parameters: parameters, success: successClosure) { (error) -> Void in
            return
        }
    }
    
    @IBAction func segmentValueChanged(sender: UISegmentedControl) {
        type = articleType(rawValue: sender.selectedSegmentIndex + 1)!
        switch type{
        case .Health:
            if healthData == nil {
                reload()
            }
        case .Keep:
            if keepData == nil {
                reload()
            }
        case .Train:
            if trainData == nil {
                reload()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
