//
//  FindLocationViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/7.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit
import CoreLocation

class FindLocationViewController: UITableViewController {
    
    private var location: CLLocation?
    
    private var data: [DianpingBusinesses]?
    
    weak var delegate: FindLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        navigationItem.title = "选择位置"
        
        tableView.hideExtraSeprator()
        
        showHUD()
        LCYCommon.sharedInstance.getLocation({ [weak self](location) -> Void in
            self?.location = location
            self?.reload()
            return
            }, fail: { [weak self]() -> Void in
                self?.hideHUD()
                self?.alert("无法获取您的位置信息")
                return
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    private func reload() {
        if let location = location {
            let parameters = [
                "page": "1",
                "latitude": "\(location.coordinate.latitude)",
                "longitude": "\(location.coordinate.longitude)",
            ]
            LCYNetworking.sharedInstance.Dianping(parameters, success: { [weak self](object) -> () in
                let retrieved = DianpingBase.modelObjectWithDictionary(object)
                if retrieved.status == "OK" {
                    // 成功获取
                    self?.data = [DianpingBusinesses]()
                    self?.data?.extend(retrieved.businesses as [DianpingBusinesses])
                    self?.tableView.reloadData()
                } else {
                    // 获取失败
                    self?.alert("无法加载周边商家")
                }
                self?.hideHUD()
                return
                }, failure: { [weak self](error) -> () in
                    // 获取失败
                    self?.alert("无法加载周边商家")
                    self?.hideHUD()
                    return
            })
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if data != nil {
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch section {
        case 0:
            return 1
        case 1:
            return data!.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        // Configure the cell...
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("noLocation") as UITableViewCell
            cell.textLabel?.text = "不显示位置"
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as UITableViewCell
            cell.textLabel?.text = data![indexPath.row].name.stringByReplacingOccurrencesOfString("(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)", withString: "", options: NSStringCompareOptions(0), range: nil)
            cell.detailTextLabel?.text = data![indexPath.row].address
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            delegate?.findLocationSuccess(nil)
            navigationController?.popViewControllerAnimated(true)
        case 1:
            delegate?.findLocationSuccess(data![indexPath.row].name.stringByReplacingOccurrencesOfString("(这是一条测试商户数据，仅用于测试开发，开发完成后请申请正式数据...)", withString: "", options: NSStringCompareOptions(0), range: nil))
            navigationController?.popViewControllerAnimated(true)
        default:
            break
        }
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}

protocol FindLocationDelegate: class {
    func findLocationSuccess(location: String?)
}
