//
//  AboutMeModifyGenderController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/24.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class AboutMeModifyGenderController: UITableViewController {
    
    weak var delegate: ModifyGenderDelegate?
    
    enum ModifyGender {
        case male
        case female
    }
    
    var defaultGender: ModifyGender = .male

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        addRightButton("确定", action: "rightButtonPressed:")
        
        navigationItem.title = "选择性别"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Actions
    func rightButtonPressed(sender: AnyObject) {
        let parameter = [
            "user_name" : LCYCommon.sharedInstance.userName!,
            "key"       : "sex",
            "value"     : defaultGender == .male ? "0" : "1"
        ]
        showHUDWithTips("正在提交修改")
        LCYNetworking.sharedInstance.POST(LCYApi.UserModifySingle,
            parameters: parameter,
            success: { [weak self](object) -> Void in
                self?.hideHUD()
                if let result = object["result"]?.boolValue {
                    if result {
                        self?.alertWithDelegate("修改成功", tag: 9001, delegate: self)
                        if let strongSelf = self {
                            let gender = strongSelf.defaultGender == .male ? "0" : "1"
                            strongSelf.delegate?.didModifyGender(gender)
                        }
                    } else {
                        self?.alert("修改失败")
                    }
                } else {
                    self?.alert("修改失败")
                }
                return
            }) { [weak self] (error) -> Void in
                self?.hideHUD()
                self?.alert("修改失败，请检查网络状态")
                return
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        cell.tintColor = UIColor.LCYThemeDarkText()

        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "男"
            if defaultGender == .male {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        case 1:
            cell.textLabel?.text = "女"
            if defaultGender == .female {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        default:
            break
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            defaultGender = .male
        case 1:
            defaultGender = .female
        default:
            return
        }
        tableView.reloadData()
    }

}

extension AboutMeModifyGenderController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 9001 {
            navigationController?.popViewControllerAnimated(true)
        }
    }
}

protocol ModifyGenderDelegate: class {
    func didModifyGender(gender: String)
}