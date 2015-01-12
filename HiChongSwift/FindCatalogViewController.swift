//
//  FindCatalogViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/17.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class FindCatalogViewController: UITableViewController {
    
    private var fansData: [UserFansFriendsMsg]?
    private var friendsData: [UserFansFriendsMsg]?
    
    private enum FindCatalogType {
        case fans
        case care
    }
    
    private var currentType: FindCatalogType = FindCatalogType.fans {
        didSet {
            tableView.reloadData()
            switch currentType {
            case .fans:
                if fansData == nil {
                    reload()
                }
            case .care:
                if friendsData == nil {
                    reload()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "宠友录"
        
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        self.tableView.hideExtraSeprator()
        
        reload()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    private func reload() {
        let parameter = [
            "user_id"   : LCYCommon.sharedInstance.userName!
        ]
        switch currentType {
        case .fans:
            LCYNetworking.sharedInstance.POST(LCYApi.UserFansList, parameters: parameter, success: { [weak self](object) -> Void in
                let retrieved = UserFansFriendsBase.modelObjectWithDictionary(object)
                if retrieved.result {
                    self?.fansData = [UserFansFriendsMsg]()
                    self?.fansData?.extend(retrieved.msg as [UserFansFriendsMsg])
                    if self?.currentType == FindCatalogType.fans {
                        self?.tableView.reloadData()
                    }
                }
                return
                }, failure: { [weak self](error) -> Void in
                    return
            })
        case .care:
            LCYNetworking.sharedInstance.POST(LCYApi.UserFriendList, parameters: parameter, success: { [weak self](object) -> Void in
                let retrieved = UserFansFriendsBase.modelObjectWithDictionary(object)
                if retrieved.result {
                    self?.friendsData = [UserFansFriendsMsg]()
                    self?.friendsData?.extend(retrieved.msg as [UserFansFriendsMsg])
                    if self?.currentType == FindCatalogType.care {
                        self?.tableView.reloadData()
                    }
                }
                return
                }, failure: { [weak self](error) -> Void in
                    return
            })
            break
        }
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        currentType = sender.selectedSegmentIndex == 0 ? .fans : .care
    }
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch currentType {
        case .fans:
            if let data = fansData {
                return data.count
            } else {
                return 0
            }
        case .care:
            if let data = friendsData {
                return data.count
            } else {
                return 0
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FindCatalogCell.identifier(), forIndexPath: indexPath) as FindCatalogCell
        
        // Configure the cell...
        var data: UserFansFriendsMsg
        switch currentType {
        case .fans:
            data = fansData![indexPath.row]
        case .care:
            data = friendsData![indexPath.row]
        }
        cell.icyImagePath = data.headImage.toAbsolutePath()
        cell.gender = data.sex == "0" ? .Male : .Female
        cell.nickNameLabel.text = data.nickName
        cell.signLabel.text = data.tip
        cell.petCount = data.petCount
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var data: UserFansFriendsMsg
        switch currentType {
        case .fans:
            data = fansData![indexPath.row]
        case .care:
            data = friendsData![indexPath.row]
        }
        
        let storyBoard = UIStoryboard(name: "AboutMe", bundle: nil)
        let controller = storyBoard.instantiateViewControllerWithIdentifier("userInfo") as AboutMeViewController
        
        controller.otherUserID = data.userId

        navigationController?.pushViewController(controller, animated: true)
    }
    
}
