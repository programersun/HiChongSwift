//
//  FindViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/16.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class FindViewController: UITableViewController {
    
    private let sectionHeaderHeight = CGFloat(24.0)
    
    private var remindInfo: TwitterRemindInfoMsg? {
        didSet {
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
            if let info = remindInfo {
                if info.headImage != nil {
                    navigationController?.tabBarItem.badgeValue = ""
                } else {
                    navigationController?.tabBarItem.badgeValue = nil
                }
            } else {
                navigationController?.tabBarItem.badgeValue = nil
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.hideExtraSeprator()
        let placeHolder = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 14.0)))
        self.tableView.tableHeaderView = placeHolder
        
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
        self.title = "发现"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "checkUpdate", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearBadge() {
        remindInfo = nil
        tableView.reloadData()
        navigationController?.tabBarItem.badgeValue = nil
    }
    
    func checkUpdate() {
        if LCYCommon.sharedInstance.needToUpdateTwitter {
            // 需要更新信息
            LCYCommon.sharedInstance.needToUpdateTwitter = false
            let parameter = [
                "lasttime": LCYCommon.sharedInstance.lastTime,
                "user_id": LCYCommon.sharedInstance.userName!
            ]
            LCYNetworking.sharedInstance.POST(LCYApi.TwitterRemindInfo, parameters: parameter, success: { [weak self](object) -> Void in
                let base = TwitterRemindInfoBase.modelObjectWithDictionary(object)
                if base.result {
                    self?.remindInfo = base.msg
                }
                return
                }, failure: { (error) -> Void in
                    return
            })
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch section {
        case 0:
            return 4
        case 1:
            return 1
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FindViewCell.identifier, forIndexPath: indexPath) as FindViewCell

//        cell.textLabel?.textColor = UIColor.LCYThemeDarkText()
        
        cell.icyImagePath = nil
        cell.badgeNumber = nil
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.icyLabel.text = "宠物圈"
                cell.backgroundColor = UIColor.whiteColor()
                cell.imageView?.image = UIImage(named: "findCircle")
                if let remindInfo = remindInfo {
                    if remindInfo.headImage != nil {
                        cell.icyImagePath = remindInfo.headImage.toAbsolutePath()
                    }
                    cell.badgeNumber = remindInfo.comment.count + remindInfo.star.count
                }
            case 1:
                cell.icyLabel.text = "附近"
                cell.backgroundColor = UIColor.LCYTableLightBlue()
                cell.imageView?.image = UIImage(named: "findNearby")
            case 2:
                cell.icyLabel.text = "宠友动态"
                cell.backgroundColor = UIColor.whiteColor()
                cell.imageView?.image = UIImage(named: "findFriends")
            case 3:
                cell.icyLabel.text = "搜索"
                cell.backgroundColor = UIColor.LCYTableLightBlue()
                cell.imageView?.image = UIImage(named: "findSearch")
            default:
                break
            }
        case 1:
            cell.icyLabel.text = "宠友录"
            cell.backgroundColor = UIColor.LCYTableLightBlue()
            cell.imageView?.image = UIImage(named: "findContact")
            break
        default:
            break
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return sectionHeaderHeight
        default:
            return 0.0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: sectionHeaderHeight)))
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.performSegueWithIdentifier("showCircle", sender: nil)
            case 1:
                self.performSegueWithIdentifier("showSearchResult", sender: nil)
            case 2:
                self.performSegueWithIdentifier("showSearchResult", sender: true)
            case 3:
                self.performSegueWithIdentifier("showSearch", sender: nil)
            default:
                break
            }
        case 1:
            self.performSegueWithIdentifier("showCatalog", sender: nil)
        default:
            break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showSearchResult":
                let destination = segue.destinationViewController as FindSearchResultViewController
                if let sender = sender as? Bool {
                    destination.forFriend = sender
                }
            case "showCircle":
                clearBadge()
            default:
                break
            }
        }
    }

}
