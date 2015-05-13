//
//  SquareCommentViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareCommentViewController: UITableViewController {
    
    var businessID: String?
    var businessName: String?
    
    weak var delegate: SquareCommentDelegate?
    
    private var cellOnceToken: dispatch_once_t = 0
    
    private weak var starCell: SquareAddStarCell?
    
    private weak var icyTextView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.hideExtraSeprator()
        
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
        self.title = "评价"
        
        if businessID == nil {
            alert("无法加载商家信息，请退回重试")
        } else {
            // 添加一个确定按钮
            self.addRightButton("确定", action: "rightButtonPressed:")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rightButtonPressed(sender: AnyObject) {
        if let textView = icyTextView {
            if count(textView.text) == 0 {
                alert("请填写评论内容")
                return
            } else {
                if let starCell = starCell {
                    if let scoreText = starCell.scoreLabel.text {
                        let parameter: [String: String] = [
                            "user_id":      LCYCommon.sharedInstance.userName!,
                            "business_id":  businessID!,
                            "content":      textView.text,
                            "score":        scoreText
                        ]
                        LCYNetworking.sharedInstance.POST(LCYApi.SquareCommentAdd, parameters: parameter, success: { [weak self](object) -> Void in
                            if let result = object["result"] as? NSNumber {
                                if result.boolValue {
                                    self?.alertWithDelegate("评论成功", tag: 2001, delegate: self)
                                } else {
                                    self?.alert("评论失败")
                                }
                            } else {
                                self?.alert("评论解析失败")
                            }
                            return
                        }, failure: { [weak self](error) -> Void in
                            self?.alert("网络连接异常，请检查网络状态")
                            return
                        })
                    } else {
                        // 这条语句应该不会执行
                        alert("请打分，丷丷")
                    }
                } else {
                    alert("内部错误，无法加载评论分数，请尝试重新打开评论页面")
                }
            }
        } else {
            alert("内部错误，无法加载评论内容，请尝试重新打开评论页面")
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("title") as! UITableViewCell
            dispatch_once(&cellOnceToken)
                { () -> Void in
                    cell.textLabel?.textColor = UIColor.whiteColor()
                    cell.backgroundColor = UIColor.LCYThemeColor()
                    return
            }
            if let name = businessName {
                cell.textLabel?.text = name
            } else {
                cell.textLabel?.textColor = UIColor.lightGrayColor()
                cell.textLabel?.text = "未能获取商家名称"
            }
            
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(SquareAddStarCell.identifier()) as! SquareAddStarCell
            let cell = cell as! SquareAddStarCell
            self.starCell = cell
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(SquareAddCommentCell.identifier()) as! UITableViewCell
            let cell = cell as! SquareAddCommentCell
            icyTextView = cell.icyTextView
        default:
            break
        }
        
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 44.0
        case 1:
            return 44.0
        case 2:
            return 170.0
        default:
            return 44.0
        }
    }
    
}

extension SquareCommentViewController: UIGestureRecognizerDelegate {
    
    @IBAction func panGestureHandler(sender: UIPanGestureRecognizer) {
        
        let xInView = sender.locationInView(sender.view).x
        if (xInView < 14.0) || (xInView > 180.0) {
            return
        }
        
        if xInView > 144.0 {
            self.starCell?.imageWidth = 144.0
        } else {
            self.starCell?.imageWidth = xInView
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        let xInView = touch.locationInView(gestureRecognizer.view).x
        if (xInView < 14.0) || (xInView > 180.0) {
            if xInView < 14.0 {
                self.starCell?.imageWidth = 16.0
            }
            return true
        }
        if xInView > 144.0 {
            self.starCell?.imageWidth = 144.0
        } else {
            self.starCell?.imageWidth = xInView
        }
        return true
    }
    
}

extension SquareCommentViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 2001 {
            delegate?.squareDidAddComment()
            navigationController?.popViewControllerAnimated(true)
        }
    }
}

protocol SquareCommentDelegate: class {
    func squareDidAddComment()
}
