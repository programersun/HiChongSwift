//
//  AboutMeModifyTextViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/23.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

enum aboutMeModityTextType: String {
    case nickName   = "姓名"
    case sign       = "签名"
    case qq         = "QQ"
    case wechat     = "微信"
    case weibo      = "新浪微博"
    case address    = "固定电话"
    case telephone  = "详细地址"
    func keyValue() -> String {
        switch self {
        case .nickName:
            return "nick_name"
        case .sign:
            return "tip"
        case .qq:
            return "qq"
        case .wechat:
            return "wechat"
        case .weibo:
            return "weibo"
        case .address:
            return "address"
        case .telephone:
            return "telephone"
        }
    }
}

class AboutMeModifyTextViewController: UITableViewController {
    
    var icyType: aboutMeModityTextType!
    
    weak var delegate: ModifyTextDelegate?
    
    private weak var icyTextField: UITextField!
    
    var defaultText: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        addRightButton("确定", action: "rightButtonPressed:")
        navigationItem.title = icyType.rawValue
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    private var _parameters: [String: String!]!
    func rightButtonPressed(sender: AnyObject) {
        let parameter = [
            "user_name" : LCYCommon.sharedInstance.userName!,
            "key"       : icyType.keyValue(),
            "value"     : icyTextField.text
        ]
        _parameters = parameter
        showHUDWithTips("正在提交修改")
        LCYNetworking.sharedInstance.POST(LCYApi.UserModifySingle,
            parameters: parameter,
            success: { [weak self](object) -> Void in
                self?.hideHUD()
                if let result = object["result"]?.boolValue {
                    if result {
                        self?.alertWithDelegate("修改成功", tag: 9001, delegate: self)
                        self?.delegate?.didModifyText(self?.icyType, text: self?._parameters["value"])
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
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AboutMeModifyTextCell.identifier(), forIndexPath: indexPath) as! AboutMeModifyTextCell

        icyTextField = cell.icyTextField
        cell.icyTextField.text = defaultText
        cell.icyTextField.becomeFirstResponder()

        return cell
    }
    
}

extension AboutMeModifyTextViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 9001 {
            navigationController?.popViewControllerAnimated(true)
        }
    }
}

protocol ModifyTextDelegate: class {
    func didModifyText(type: aboutMeModityTextType?, text: String?)
}
