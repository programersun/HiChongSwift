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
    
    var forFriend = false
    
    var parameter: [String: String]?
    
    private var location: CLLocation?
    
    private var infoData: [UserSearchFriendMsg]? {
        didSet {
            tableView.reloadData()
        }
    }
    
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
            LCYNetworking.sharedInstance.POST(LCYApi.UserSearchFriend, parameters: parameter, success: { [weak self](object) -> Void in
                let retrieved = UserSearchFriendBase.modelObjectWithDictionary(object)
                if retrieved.result {
                    self?.infoData = retrieved.msg as? [UserSearchFriendMsg]
                } else {
                    self?.alert("未能获取到所找寻的宠物")
                }
                return
                }, failure: { [weak self](error) -> Void in
                    self?.alert("网络状态不佳")
                    return
            })
        } else {
            if !forFriend {
                let parameter = [
                    "longitude": "\(location!.coordinate.longitude)",
                    "latitude": "\(location!.coordinate.latitude)"
                ]
                LCYNetworking.sharedInstance.POST(LCYApi.UserSearchFriend, parameters: parameter, success: { [weak self](object) -> Void in
                    let retrieved = UserSearchFriendBase.modelObjectWithDictionary(object)
                    if retrieved.result {
                        self?.infoData = retrieved.msg as? [UserSearchFriendMsg]
                    } else {
                        self?.alert("未能获取到所找寻的宠物")
                    }
                    return
                    }, failure: { [weak self](error) -> Void in
                        self?.alert("网络状态不佳")
                        return
                })
            } else {
                let parameter = [
                    "longitude": "\(location!.coordinate.longitude)",
                    "latitude": "\(location!.coordinate.latitude)",
                    "user_id": LCYCommon.sharedInstance.userName!
                ]
                LCYNetworking.sharedInstance.POST(LCYApi.UserSearchFriend2, parameters: parameter, success: { [weak self](object) -> Void in
                    let retrieved = UserSearchFriendBase.modelObjectWithDictionary(object)
                    if retrieved.result {
                        self?.infoData = retrieved.msg as? [UserSearchFriendMsg]
                    } else {
                        self?.alert("未能获取到所找寻的宠物")
                    }
                    return
                    }, failure: { [weak self](error) -> Void in
                        self?.alert("网络状态不佳")
                        return
                })
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if let data = infoData {
            return data.count
        } else {
            return 0
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FindSearchResultCell.identifier(), forIndexPath: indexPath) as FindSearchResultCell
        
        // Configure the cell...
        let data = infoData![indexPath.row]
        cell.icyImagePath = data.headImage.toAbsolutePath()
        cell.currentGender = data.sex == "0" ? .Male : .Female
        cell.icyNickLabel.text = data.nickName
        cell.icyPetCountLabel.text = "宠物：\(data.petCount)"
        cell.icyTipLabel.text = data.tip
        
        cell.location = (data.latitude, data.longitude, location)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showPersonal", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showPersonal":
                let destination = segue.destinationViewController as FindPersonalViewController
                if let indexPath = tableView.indexPathForSelectedRow() {
                    let data = infoData![indexPath.row]
                    destination.personID = data.userId
                    destination.personNickname = data.nickName
                }
            default:
                break
            }
        }
    }
}
