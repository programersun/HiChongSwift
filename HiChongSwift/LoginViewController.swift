//
//  LoginViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/18.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController {
    
    private struct UserInfo {
        var LoginName: String? = nil
        var UserPassword: String? = nil
        var AuthCode: String? = nil
        var RetrievedAuthCode: String? = nil
    }
    
    private var userInfo = UserInfo()
    
    private enum LoginViewControllerType {
        case register
        case login
    }
    
    private var currentType = LoginViewControllerType.register
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showDetail":
                let destination = segue.destinationViewController as RegisterDetailViewController
                destination.detailUserInfo.LoginName = userInfo.LoginName
                destination.detailUserInfo.UserPassword = userInfo.UserPassword
            default:
                break
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func segmentValueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.currentType = LoginViewControllerType.register
            self.tableView.reloadData()
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 3, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Bottom)
            self.tableView.endUpdates()
            break
        case 1:
            self.currentType = LoginViewControllerType.login
            self.tableView.reloadData()
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 3, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Bottom)
            self.tableView.endUpdates()
        default:
            break
        }
        
        
        
    }
    
    private func login() {
        if userInfo.LoginName == nil {
            alert("请输入手机号")
            return
        }
        if userInfo.UserPassword == nil {
            alert("请输入6-18位的密码")
            return
        }
        if let unwrapped = userInfo.UserPassword {
            if (unwrapped as NSString).length < 6 || (unwrapped as NSString).length > 18 {
                alert("请输入6-18位的密码")
                return
            }
        }
        showHUDWithTips("登录中")
        // 输入合法，登陆
        let parameter = ["user_name": userInfo.LoginName!,
            "password": userInfo.UserPassword!]
        LCYNetworking.sharedInstance.POST(LCYApi.UserLogin, parameters: parameter, success: { [weak self] (object) -> Void in
            let result = UserLoginBaseClass.modelObjectWithDictionary(object)
            if result.result {
                // 登录成功
                self?.loginSuccess(result.userName)
            } else {
                // 登录失败
                self?.alert(result.msg)
            }
            self?.hideHUD()
            }) { [weak self] (error) -> Void in
                self?.alert("网络错误，请检查您的网络状态。")
                self?.hideHUD()
        }
    }
    
    private func loginSuccess(userName: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        appDelegate.window?.rootViewController = (storyboard.instantiateInitialViewController() as UIViewController)
        LCYCommon.sharedInstance.login(userName)
    }
    
    private func register() {
        if userInfo.LoginName == nil {
            alert("请输入手机号")
            return
        }
        if userInfo.UserPassword == nil {
            alert("请输入6-18位的密码")
            return
        }
        if let unwrapped = userInfo.UserPassword {
            if (unwrapped as NSString).length < 6 || (unwrapped as NSString).length > 18 {
                alert("请输入6-18位的密码")
                return
            }
        }
        if userInfo.AuthCode == nil {
            alert("请输入验证码")
            return
        }
        if userInfo.AuthCode != userInfo.RetrievedAuthCode {
            alert("验证码错误")
            return
        }
        // 验证成功，跳到下一步填写详细信息
        self.performSegueWithIdentifier("showDetail", sender: nil)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(LoginInputCell.identifier()) as UITableViewCell
            let cell = cell as LoginInputCell
            cell.icyCellType = .PhoneNumber
            cell.delegate = self
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(LoginInputCell.identifier()) as UITableViewCell
            let cell = cell as LoginInputCell
            cell.icyCellType = .Password
            cell.delegate = self
        case 2:
            switch currentType {
            case .register:
                cell = tableView.dequeueReusableCellWithIdentifier(LoginCodeCell.identifier()) as UITableViewCell
                let cell = cell as LoginCodeCell
                cell.delegate = self
            case .login:
                cell = tableView.dequeueReusableCellWithIdentifier(LoginSingleButtonCell.identifier()) as UITableViewCell
                let cell = cell as LoginSingleButtonCell
                cell.currentType = .Login
                cell.delegate = self
            }
            
        case 3:
            switch self.currentType {
            case .register:
                cell = tableView.dequeueReusableCellWithIdentifier(LoginSingleButtonCell.identifier()) as UITableViewCell
                let cell = cell as LoginSingleButtonCell
                cell.currentType = .Register
                cell.delegate = self
            case .login:
                cell = tableView.dequeueReusableCellWithIdentifier(LoginForgetCell.identifier()) as UITableViewCell
            }
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
}

extension LoginViewController: LoginInputCellDelegate {
    func loginInputDidEndEditing(cellType: LoginInputCellType, text: String) {
        switch cellType {
        case .Password:
            userInfo.UserPassword = text
        case .PhoneNumber:
            userInfo.LoginName = text
        }
    }
}

extension LoginViewController: LoginSingleButtonCellDelegate {
    func loginSingleButtonDidPressed(buttonType: LoginSingleButtonCellType) {
        switch buttonType {
        case .Login:
            login()
        case .Register:
            register()
        }
    }
}

extension LoginViewController: LoginCodeCellDelegate {
    func loginCodeCellNeedPhoneNumber() -> NSString? {
        return userInfo.LoginName
    }
    func loginCodeCellGetGode(code: String) {
        userInfo.RetrievedAuthCode = code
    }
    func loginCodeCellInputCode(code: String) {
        userInfo.AuthCode = code
    }
    func loginCodeCellFailCode(masage: String) {
        alert(masage)
    }
}
