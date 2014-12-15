//
//  SquareCommentViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareCommentViewController: UITableViewController {
    
    private var cellOnceToken: dispatch_once_t = 0
    
    private var starCell: SquareAddStarCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.hideExtraSeprator()
        
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
        self.title = "评价"
        
        // 添加一个确定按钮
        let doneButton = UIButton(frame: CGRect(origin: CGPointZero, size: LCYCommon.sharedInstance.rightButtonSize))
        doneButton.addTarget(self, action: "rightButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        doneButton.backgroundColor = UIColor.LCYThemeDarkText()
        let doneString = NSAttributedString(string: "确定", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(12.0)])
        doneButton.setAttributedTitle(doneString, forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        doneButton.layer.cornerRadius = 4.0
        let rightItem = UIBarButtonItem(customView: doneButton)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rightButtonPressed(sender: AnyObject) {
        println("right button pressed!")
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
            cell = tableView.dequeueReusableCellWithIdentifier("title") as UITableViewCell
            dispatch_once(&cellOnceToken)
                { () -> Void in
                    cell.textLabel?.textColor = UIColor.whiteColor()
                    cell.backgroundColor = UIColor.LCYThemeColor()
                    return
            }
            cell.textLabel?.text = "小马宠物医院"
            
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(SquareAddStarCell.identifier()) as SquareAddStarCell
            let cell = cell as SquareAddStarCell
            self.starCell = cell
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(SquareAddCommentCell.identifier()) as UITableViewCell
            let cell = cell as SquareAddCommentCell
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
            self.starCell.imageWidth = 144.0
        } else {
            self.starCell.imageWidth = xInView
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        let xInView = touch.locationInView(gestureRecognizer.view).x
        if (xInView < 14.0) || (xInView > 180.0) {
            if xInView < 14.0 {
                self.starCell.imageWidth = 16.0
            }
            return true
        }
        if xInView > 144.0 {
            self.starCell.imageWidth = 144.0
        } else {
            self.starCell.imageWidth = xInView
        }
        return true
    }
    
}
