//
//  AboutMeSettingViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class AboutMeSettingViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        navigationItem.title = "设置"
        
        tableView.backgroundColor = UIColor.LCYThemeColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch section {
        case 0:
            return 1
        case 1:
            return 6
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "忘记密码"
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "用户帮助"
            case 1:
                cell.textLabel?.text = "用户协议"
            case 2:
                cell.textLabel?.text = "意见反馈"
            case 3:
                cell.textLabel?.text = "打分支持"
            case 4:
                cell.textLabel?.text = "版本升级"
            case 5:
                cell.textLabel?.text = "退出账号"
            default:
                break
            }
        default:
            break
        }
        
        switch indexPath.row % 2 {
        case 0:
            cell.backgroundColor = UIColor.LCYTableLightBlue()
        case 1:
            cell.backgroundColor = UIColor.LCYTableLightGray()
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            // 忘记密码
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier("reset") as ForgetPasswordViewController
            viewController.lockPhoneNumber = true
            navigationController?.pushViewController(viewController, animated: true)
        case 1:
            switch indexPath.row {
            case 0:
                // 用户帮助
                performSegueWithIdentifier("showHelp", sender: nil)
            case 1:
                // 使用协议
                performSegueWithIdentifier("showAgreement", sender: nil)
            case 2:
                // 意见反馈
                performSegueWithIdentifier("showFeedback", sender: nil)
            case 3:
                // 打分支持
                let URLString = "https://itunes.apple.com/cn/app/hai-chong-chong-wu/id918809824?l=zh&ls=1&mt=8"
                UIApplication.sharedApplication().openURL(NSURL(string: URLString)!)
            case 4:
                // 版本升级
                let URLString = "http://itunes.apple.com/cn/lookup?id=918809824"
                if let URL = NSURL(string: URLString) {
                    if let jsonData = NSData(contentsOfURL: URL) {
                        if let jsonObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions(0), error: nil) as? [String: AnyObject] {
                            if let version = (((jsonObject["results"] as? NSArray)?[0] as? NSDictionary)?["version"] as? String) {
                                if let localVersion = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
                                    let remoteSep = version.componentsSeparatedByString(".")
                                    let localSep = localVersion.componentsSeparatedByString(".")
                                    if remoteSep.first?.toInt() > localSep.first?.toInt() {
                                        // 有升级版
                                        let URLString = "https://itunes.apple.com/cn/app/hai-chong-chong-wu/id918809824?l=zh&ls=1&mt=8"
                                        UIApplication.sharedApplication().openURL(NSURL(string: URLString)!)
                                        break
                                    } else if (remoteSep[0].toInt() == localSep[0].toInt()) && (remoteSep[1].toInt() > localSep[1].toInt()) {
                                        // 有升级版
                                        let URLString = "https://itunes.apple.com/cn/app/hai-chong-chong-wu/id918809824?l=zh&ls=1&mt=8"
                                        UIApplication.sharedApplication().openURL(NSURL(string: URLString)!)
                                        break
                                    }
                                }
                            }
                        }
                    }
                }
                alert("没有更新的版本哦～")
            case 5:
                // 退出账号
                let alertView = UIAlertView(title: "", message: "您确定要退出吗", delegate: self, cancelButtonTitle: "确定", otherButtonTitles: "取消")
                alertView.tag = 3000
                alertView.show()
            default:
                break
            }
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

extension AboutMeSettingViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 3000 {
            if buttonIndex == 0 {
                LCYCommon.sharedInstance.logout()
            }
        }
    }
}


