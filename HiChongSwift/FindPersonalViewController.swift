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
    
    //    private var infoData = [TwitterPersonalMsg]?
    
    private var infoData: [TwitterPersonalMsg]?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let headerNib = UINib(nibName: "FindPersonalHeader", bundle: nil)
        let headerView = headerNib.instantiateWithOwner(self, options: nil).first as UIView
        headerView.bounds.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: 200.0)
        tableView.tableHeaderView = headerView
        
        avatarImageView.roundCorner()
        avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        avatarImageView.layer.borderWidth = 1.0
        
        reload()
        
        tableView.backgroundColor = UIColor.LCYThemeColor()
        
        addRightButton("关注", action: "addCare:")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
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
            LCYNetworking.sharedInstance.POST(LCYApi.UserAttention, parameters: parameters, success: { (object) -> Void in
                return
            }, failure: { (error) -> Void in
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

