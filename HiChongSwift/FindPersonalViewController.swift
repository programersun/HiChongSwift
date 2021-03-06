//
//  FindPersonalViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class FindPersonalViewController: UITableViewController {
    
    var personID: String? {
        didSet {
            if let personID = personID {
                if personID == LCYCommon.sharedInstance.userName! {
                    ownView = true
                }
            }
        }
    }
    var personNickname: String?
    var ownView = false
    
    var delegate: FindPersonalViewControllerDelegate?
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
    
    private var infoForDelete: TwitterPersonalMsg?
    
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
        let headerView = headerNib.instantiateWithOwner(self, options: nil).first as! UIView
        headerView.bounds.size = CGSize(width: UIScreen.mainScreen().bounds.width, height:UIScreen.mainScreen().bounds.width / 320.0 * 200.0)
        tableView.tableHeaderView = headerView
        
        avatarImageView.roundCorner()
        avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        avatarImageView.layer.borderWidth = 1.0
        
        initKeeperInfo()
        reload()
        
        navigationItem.title = personNickname
        
//        tableView.backgroundColor = UIColor.LCYThemeColor()
        
        
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
                let retrieved = TwitterKeeperInfoBase.modelObjectWithDictionary(object as [NSObject : AnyObject])
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
                let retrieved = TwitterPersonalBase.modelObjectWithDictionary(object as [NSObject : AnyObject])
                if retrieved.result {
                    self?.infoData = [TwitterPersonalMsg]()
                    self?.infoData?.extend(retrieved.msg as! [TwitterPersonalMsg])
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
                self?.alert("您的网络状态不佳哦")
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
                    self?.alert("您的网络状态不佳哦")
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
        let cell = tableView.dequeueReusableCellWithIdentifier(FindPersonalCell.identifier, forIndexPath: indexPath) as! FindPersonalCell
        
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
        
        cell.indexPath = indexPath
        cell.delegate = self
        
        if ownView {
            cell.deleteButton.hidden = false
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let data = infoData![indexPath.row]
        if data.images.count > 0 {
//            performSegueWithIdentifier("showPageView", sender: data)
            let pageView = ICYImageBrowser()
            pageView.imageDataSource = self
            pageView.show()
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
                let destination = segue.destinationViewController as! FindTwitterPageViewController
                destination.data = sender as? TwitterPersonalMsg

            default:
                break
            }
        }
    }

    
}

extension FindPersonalViewController: ICYImageBrowserDataSource {
    func numberOfImagesInICYImageBrowser(icyImageBrowser: ICYImageBrowser) -> Int {
        let index = tableView.indexPathForSelectedRow()!.row
        return infoData![index].images.count
    }
    func icyImageBrowser(icyImageBrowser: ICYImageBrowser, imageForIndex imageIndex: Int) -> UIImage? {
        return nil
    }
    func icyImageBrowser(icyImageBrowser: ICYImageBrowser, pathForIndex pathIndex: Int) -> String? {
        let index = tableView.indexPathForSelectedRow()!.row
        let imageData = infoData![index].images as! [TwitterPersonalImages]
        return imageData[pathIndex].imagePath.toAbsolutePath()
    }
    func icyImageBrowser(icyImageBrowser: ICYImageBrowser, titleForIndex titleIndex: Int) -> String? {
        return nil
    }
}

extension FindPersonalViewController: FindPersonalCellDelegate, UIAlertViewDelegate {
    func personalCellDeleteButtonClicked(index: NSIndexPath) {
//        alertWithDelegate("真的要删除这条消息吗", tag: 1000, delegate: self)
        infoForDelete = infoData![index.row]
        let alertView = UIAlertView(title: "", message: "真的要删除这条消息吗", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alertView.show()
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            // 删除
            showHUD()
            let deletingtwitterID = infoForDelete!.twitterId.copy() as! String
            let parameter = ["twitter_id": infoForDelete!.twitterId]
            LCYNetworking.sharedInstance.POST(
                LCYApi.TwitterDelete,
                parameters: parameter,
                success: { [weak self](object) -> Void in
                    let result = object["result"] as? Bool
                    if result == true {
                        // 删除成功
                        if let data = self?.infoData {
                            self?.infoData = data.filter({ $0.twitterId != deletingtwitterID })
                            self?.delegate?.findPersonalVCDidRemoveTwitter(deletingtwitterID)
                            self?.tableView.reloadData()
                        }
                    } else {
                        self?.alert("删除失败")
                    }
                    self?.hideHUD()
                    return
            }, failure: { [weak self](error) -> Void in
                self?.hideHUD()
                self?.alert("网络状态不佳")
                return
            })
        }
    }
}

protocol FindPersonalViewControllerDelegate {
    func findPersonalVCDidRemoveTwitter(twitterID: String)
}

