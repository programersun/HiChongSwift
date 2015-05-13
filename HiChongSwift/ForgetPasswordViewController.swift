//
//  ForgetPasswordViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UITableViewController {
    
    private struct UserInfo {
//        var LoginName: String? = nil
//        var UserPassword: String? = nil
//        var AuthCode: String? = nil
        var RetrievedAuthCode: String? = nil
    }
    private var userInfo = UserInfo()
    
    var lockPhoneNumber: Bool = false
    
    private var phoneNumberTextView: UITextField?
    private var authCodeTextView: UITextField?
    private var passwordTextView: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        navigationItem.title = "找回密码"
        
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(LoginInputCell.identifier()) as! UITableViewCell
            let cell = cell as! LoginInputCell
            cell.icyCellType = .PhoneNumber
            phoneNumberTextView = cell.icyTextField
            if lockPhoneNumber {
                phoneNumberTextView?.text = LCYCommon.sharedInstance.userPhone
                phoneNumberTextView?.enabled = false
            }
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(LoginCodeCell.identifier()) as! UITableViewCell
            let cell = cell as! LoginCodeCell
            cell.isReset = true
            cell.delegate = self
            authCodeTextView = cell.icyTextField
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(LoginInputCell.identifier()) as! UITableViewCell
            let cell = cell as! LoginInputCell
            cell.icyCellType = .Password
            passwordTextView = cell.icyTextField
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier(LoginSingleButtonCell.identifier()) as! UITableViewCell
            let cell = cell as! LoginSingleButtonCell
            cell.currentType = .Forget
            cell.delegate = self
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
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

extension ForgetPasswordViewController: LoginCodeCellDelegate {
    func loginCodeCellNeedPhoneNumber() -> NSString? {
        return phoneNumberTextView?.text
    }
    func loginCodeCellFailCode(masage: String) {
        alert(masage)
    }
    func loginCodeCellGetGode(code: String) {
        userInfo.RetrievedAuthCode = code
    }
    func loginCodeCellInputCode(code: String) {
    }
}

extension ForgetPasswordViewController:LoginSingleButtonCellDelegate {
    func loginSingleButtonDidPressed(buttonType: LoginSingleButtonCellType) {
        save()
    }
    private func save() {
        if let phoneField = phoneNumberTextView {
            if count(phoneField.text) == 0 {
                alert("请输入手机号")
                return
            }
        } else {
            alert("请输入手机号")
            return
        }
        
        if let passwordField = passwordTextView {
            if count(passwordField.text) > 16 || count(passwordField.text) < 6 {
                alert("请输入6-18位的密码")
                return
            }
        } else {
            alert("请输入密码")
            return
        }
        
        if userInfo.RetrievedAuthCode == nil {
            alert("请获取验证码")
            return
        }
        
        if let auth = authCodeTextView {
            if count(auth.text) == 0 {
                alert("请输入验证码")
                return
            } else if auth.text != userInfo.RetrievedAuthCode {
                alert("请输入正确的验证码")
                return
            }
        } else {
            alert("请输入验证码")
        }
        
        
        let parameter = [
            "user_id": phoneNumberTextView!.text,
            "password": passwordTextView!.text
        ]
        LCYNetworking.sharedInstance.POST(LCYApi.UserSetPassword, parameters: parameter, success: { [weak self](object) -> Void in
            if let result = object["result"] as? Bool {
                if result {
                    self?.alertWithDelegate("修改成功", tag: 3009, delegate: self)
                } else {
                    self?.alert("修改失败")
                }
            } else {
                self?.alert("修改失败")
            }
            return
        }) { [weak self](error) -> Void in
            self?.alert("网络状态不佳哦s")
            return
        }
    }
}

extension ForgetPasswordViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 3009 {
            navigationController?.popViewControllerAnimated(true)
        }
    }
}
