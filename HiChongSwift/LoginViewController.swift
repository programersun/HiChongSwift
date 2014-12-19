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
    
    func login() {
        
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
            println("register")
        }
    }
}
