//
//  FindSearchResultViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/17.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit
import CoreLocation

class FindSearchResultViewController: UITableViewController {
    
    var parameter: [String: String]?
    
    private var location: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
        LCYCommon.sharedInstance.getLocation({ [weak self](location) -> Void in
            self?.location = location
            self?.reload()
            return
        }, fail: { [weak self]() -> Void in
            self?.alert("无法获取您的地理位置信息。")
            return
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    private func reload() {
        if var parameter = parameter {
            parameter.extend([
                "longitude": "\(location!.coordinate.longitude)",
                "latitude": "\(location!.coordinate.latitude)"
                ])
            LCYNetworking.sharedInstance.POST(LCYApi.UserSearchFriend, parameters: parameter, success: { (object) -> Void in
                return
            }, failure: { (error) -> Void in
                return
            })
        } else {
            let parameter = [
                "longitude": "\(location!.coordinate.longitude)",
                "latitude": "\(location!.coordinate.latitude)"
            ]
            LCYNetworking.sharedInstance.POST(LCYApi.UserSearchFriend, parameters: parameter, success: { (object) -> Void in
                return
                }, failure: { (error) -> Void in
                    return
            })
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 12
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FindSearchResultCell.identifier(), forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76.0
    }

}
