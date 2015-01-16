//
//  FindPersonalViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class FindPersonalViewController: UITableViewController {
    
    var personID: String?
    var personNickname: String?
    
    //    private var infoData = [TwitterPersonalMsg]?
    
    private var infoData: [TwitterPersonalMsg]?
    
    private var keeperInfo : TwitterKeeperInfoMsg? {
        didSet {
            if let info = keeperInfo {
                avatarImageView.setImageWithURL(NSURL(string:info.headImage.toAbsolutePath()))
                personNameLabel.text = info.tip
                if info.bgImage != nil {
                    headerBackground.setImageWithURL(NSURL(string: info.bgImage.toAbsolutePath()))
                }
                if info.isAttention == 1.0 {
                    addRightButton("已关注", action: "removeCare:")
                } else {
                    addRightButton("关注", action: "addCare:")
                }
            }
        }
    }
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var personNameLabel: UILabel!
    @IBOutlet private weak var headerBackground: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let headerNib = UINib(nibName: "FindPersonalHeader", bundle: nil)
        let headerView = headerNib.instantiateWithOwner(self, options: nil).first as UIView
        headerView.bounds.size = CGSize(width: UIScreen.mainScreen().bounds.width, height:UIScreen.mainScreen().bounds.width / 320.0 * 200.0)
        tableView.tableHeaderView = headerView
        
        avatarImageView.roundCorner()
        avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        avatarImageView.layer.borderWidth = 1.0
        
        initKeeperInfo()
        reload()
        
        navigationItem.title = personNickname
        
        tableView.backgroundColor = UIColor.LCYThemeColor()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    private func initKeeperInfo() {
        personNameLabel.text = ""
        avatarImageView.image = nil
        if let personID = personID {
            let parameter = [
                "twitter_keeper": personID,
                "my_user_id": LCYCommon.sharedInstance.userName!
            ]
            LCYNetworking.sharedInstance.POST(LCYApi.TwitterKeeperInfo, parameters: parameter, success: { [weak self](object) -> Void in
                let retrieved = TwitterKeeperInfoBase.modelObjectWithDictionary(object)
                if retrieved.result {
                    self?.keeperInfo = retrieved.msg
                }
                return
            }, failure: { [weak self](error) -> Void in
                return
            })
        }
    }
    
    private func reload() {
        if let personID = personID {
            let parameter = [
                "twitter_keeper": personID
            ]
            LCYNetworking.sharedInstance.POST(LCYApi.twitterPersonal, parameters: parameter, success: { [weak self](object) -> Void in
                let retrieved = TwitterPersonalBase.modelObjectWithDictionary(object)
                if retrieved.result {
                    self?.infoData = [TwitterPersonalMsg]()
                    self?.infoData?.extend(retrieved.msg as [TwitterPersonalMsg])
                    self?.tableView.reloadData()
                }
                return
                }, failure: { [weak self](error) -> Void in
                    self?.alert("网络连接问题，无法获取个人信息")
                    return
            })
        } else {
            alert("无法获取个人信息")
        }
    }
    
    func addCare(sender: AnyObject) {
        if let personID = personID {
            let parameters = [
                "user_id"       : LCYCommon.sharedInstance.userName!,
                "to_user_id"    : personID,
                "control"       : "1"
            ]
            navigationItem.rightBarButtonItem?.enabled = false
            LCYNetworking.sharedInstance.POST(LCYApi.UserAttention, parameters: parameters, success: { [weak self](object) -> Void in
                if let result = object["result"] as? Bool {
                    if result {
//                        self?.alert("成功关注")
                        self?.addRightButton("已关注", action: "removeCare:")
                    } else {
                        self?.alert("关注失败")
                    }
                } else {
                    self?.alert("关注失败")
                }
                self?.navigationItem.rightBarButtonItem?.enabled = true
                return
            }, failure: { [weak self](error) -> Void in
                self?.alert("您的网络状态不佳哦s")
                self?.navigationItem.rightBarButtonItem?.enabled = true
                return
            })
        }
    }
    
    func removeCare(sender: AnyObject) {
        if let personID = personID {
            let parameters = [
                "user_id"       : LCYCommon.sharedInstance.userName!,
                "to_user_id"    : personID,
                "control"       : "2"
            ]
            navigationItem.rightBarButtonItem?.enabled = false
            LCYNetworking.sharedInstance.POST(LCYApi.UserAttention, parameters: parameters, success: { [weak self](object) -> Void in
                if let result = object["result"] as? Bool {
                    if result {
//                        self?.alert("成功取消关注")
                        self?.addRightButton("关注", action: "addCare:")
                    } else {
                        self?.alert("取消关注失败")
                    }
                } else {
                    self?.alert("取消关注失败")
                }
                self?.navigationItem.rightBarButtonItem?.enabled = true
                return
                }, failure: { [weak self](error) -> Void in
                    self?.alert("您的网络状态不佳哦s")
                    self?.navigationItem.rightBarButtonItem?.enabled = true
                    return
            })
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if let data = infoData {
            return data.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FindPersonalCell.identifier, forIndexPath: indexPath) as FindPersonalCell
        
        // Configure the cell...
        let data = infoData![indexPath.row]
        cell.petNickLabel.text = data.petName
        cell.icyContentLabel.text = data.twitterContent
        cell.icyImages = data.images as? [TwitterPersonalImages]
        if data.images.count == 0 {
            cell.currentType = .Text
        } else {
            cell.currentType = .Image
        }
        
        cell.icyTimeLabel.attributedText = data.addTime.toTwitterCalendar()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let data = infoData![indexPath.row]
        if data.images.count > 0 {
            performSegueWithIdentifier("showPageView", sender: data)
        }
    }
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "showPageView":
                let destination = segue.destinationViewController as FindTwitterPageViewController
                destination.data = sender as? TwitterPersonalMsg

            default:
                break
            }
        }
    }

    
}

