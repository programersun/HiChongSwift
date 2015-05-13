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
    
    private var healthPage = 1, keepPage = 1, trainPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        icySegmentControl.setBackgroundImage(UIImage(named: "sqSegmentNormal"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        icySegmentControl.setBackgroundImage(UIImage(named: "sqSegmentSelected"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        icySegmentControl.setDividerImage(UIImage(named: "sqSegmentNormal"), forLeftSegmentState: UIControlState.Normal, rightSegmentState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        icySegmentControl.backgroundColor = UIColor(patternImage: UIImage(named: "segmentBackground")!)
        
        navigationItem.title = navigationItemTitle
        
        reload()
        
        icyTableView.backgroundColor = UIColor.LCYTableLightBlue()
        
        // 添加下拉刷新
        icyTableView.addHeaderWithCallback { [weak self]() -> Void in
            self?.reload()
            return
        }
        // 添加上拉加载更多
        icyTableView.addFooterWithCallback { [weak self]() -> Void in
            self?.loadMore()
            return
        }
    }
    
    private func reload() {
        if cate_id == nil {
            cate_id = "0"
        }
        let parameters = [
            "cate_id": cate_id!,
            "type_id": "\(type.rawValue)",
            "p": "1"
        ]
        switch type {
        case .Health:
            healthPage = 1
        case .Keep:
            keepPage = 1
        case .Train:
            trainPage = 1
        }
        loadDataWithParameters(parameters, append: false)
    }
    
    private func loadMore() {
        if cate_id == nil {
            cate_id = "0"
        }

        var page: Int = 1
        switch type {
        case .Health:
            page = healthPage
        case .Keep:
            page = keepPage
        case .Train:
            page = trainPage
        }
        let parameters = [
            "cate_id": cate_id!,
            "type_id": "\(type.rawValue)",
            "p": "\(page)"
        ]
        loadDataWithParameters(parameters, append: true)
    }
    
    private func loadDataWithParameters(parameter: [String: String], append: Bool) {
        typealias mySuccessClosure = ((object: NSDictionary) -> Void)
        var successClosure: mySuccessClosure?
        switch type {
        case .Health:
            successClosure = {
                [weak self] (object: NSDictionary) -> Void in
                let retrived = WikiMoreBase.modelObjectWithDictionary(object as [NSObject : AnyObject])
                if !append {
                    self?.healthData = [WikiMoreData]()
                }
                if let data = retrived.data {
                    self?.healthData?.extend(data as! [WikiMoreData])
                    self?.healthPage++
                    if self?.icySegmentControl.selectedSegmentIndex == 0 {
                        self?.icyTableView.reloadData()
                    }
                }
                self?.icyTableView.headerEndRefreshing()
                self?.icyTableView.footerEndRefreshing()
            }
            break
        case .Keep:
            successClosure = {
                [weak self] (object: NSDictionary) -> Void in
                let retrived = WikiMoreBase.modelObjectWithDictionary(object as [NSObject : AnyObject])
                if !append {
                    self?.keepData = [WikiMoreData]()
                }
                if let data = retrived.data {
                    self?.keepData?.extend(data as! [WikiMoreData])
                    self?.keepPage++
                    if self?.icySegmentControl.selectedSegmentIndex == 1 {
                        self?.icyTableView.reloadData()
                    }
                }
                self?.icyTableView.headerEndRefreshing()
                self?.icyTableView.footerEndRefreshing()
            }
            break
        case .Train:
            successClosure = {
                [weak self] (object: NSDictionary) -> Void in
                let retrived = WikiMoreBase.modelObjectWithDictionary(object as [NSObject : AnyObject])
                if !append {
                    self?.trainData = [WikiMoreData]()
                }
                if let data = retrived.data {
                    self?.trainData?.extend(data as! [WikiMoreData])
                    self?.trainPage++
                    if self?.icySegmentControl.selectedSegmentIndex == 2 {
                        self?.icyTableView.reloadData()
                    }
                }
                self?.icyTableView.headerEndRefreshing()
                self?.icyTableView.footerEndRefreshing()
            }
            break
        }
        LCYNetworking.sharedInstance.GET(LCYApi.WikiMore, parameters: parameter, success: successClosure) { [weak self](error) -> Void in
            self?.icyTableView.headerEndRefreshing()
            self?.icyTableView.footerEndRefreshing()
            return
        }
    }
    
    @IBAction func segmentValueChanged(sender: UISegmentedControl) {
        type = articleType(rawValue: sender.selectedSegmentIndex + 1)!
        switch type{
        case .Health:
            if healthData == nil {
                reload()
            } else {
                icyTableView.reloadData()
            }
        case .Keep:
            if keepData == nil {
                reload()
            } else {
                icyTableView.reloadData()
            }
        case .Train:
            if trainData == nil {
                reload()
            } else {
                icyTableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "showArticle":
                let destination = segue.destinationViewController as! WikiArticleViewController
                if let indexPath = icyTableView.indexPathForSelectedRow() {
                    var data: WikiMoreData?
                    switch type {
                    case .Health:
                        data = healthData?[indexPath.row]
                    case .Keep:
                        data = keepData?[indexPath.row]
                    case .Train:
                        data = trainData?[indexPath.row]
                    }
                    destination.wikiArticleID = data?.encyId
                    var readInt : Int = 0
                    if let datas = data
                    {
                        var readString : NSString  = NSString(format: "%@", datas.encyRead)
                        readInt         = readString.integerValue + 1
                        data?.encyRead  = "\(readInt)"
                        icyTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                        destination.afterCollection = {[weak self] (isadd) -> Void in
                            
                            var collectString : NSString = NSString(format: "%@", data!.encyCollect)
                            var collectInt    : Int      = collectString.integerValue
                            if(!isadd)
                            {
                                data?.encyCollect = "\(collectInt + 1)"
                                self?.icyTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                            }
                            else
                            {
                                data?.encyCollect = "\(collectInt - 1)"
                                self?.icyTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                            }
                        }

                    }

                }
                
            default:
                break
            }
        }
    }
    
}

extension WikiListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .Health:
            return healthData != nil ? healthData!.count : 0
        case .Keep:
            return keepData != nil ? keepData!.count : 0
        case .Train:
            return trainData != nil ? trainData!.count : 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(WikiInfoCell.identifier()) as! WikiInfoCell
        var data: WikiMoreData?
        switch type {
        case .Health:
            data = healthData?[indexPath.row]
        case .Keep:
            data = keepData?[indexPath.row]
        case .Train:
            data = trainData?[indexPath.row]
        }
        
        switch indexPath.row % 2 {
        case 0:
            cell.backgroundColor = UIColor.LCYTableLightBlue()
        case 1:
            cell.backgroundColor = UIColor.LCYTableLightGray()
        default:
            break
        }
        
        if let info = data {
            cell.icyTitle = info.title
            cell.keyWord = info.keyword
            cell.readCount = info.encyRead
            cell.collectCount = info.encyCollect
            cell.imagePath = info.headImg.toAbsolutePath()
        }
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65.0
    }
}
