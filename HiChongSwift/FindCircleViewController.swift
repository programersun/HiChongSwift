//
//  FindCircleViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/16.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class FindCircleViewController: UITableViewController {
    
    private let testContent = "I am the bone of my sword.\n" +
    "Steel is my body,and fire is my blood.\n" +
    "I have created over a thousand blades.\n" +
    "Unknown to Death.\n" +
    "Nor known to Life.\n" +
    "Have withstood pain to create many weapons.\n" +
    "Yet, those hands will never hold anything.\n" +
    "So as I pray, Unlimited Blade Works."

    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "宠物圈"
        self.tableView.hideExtraSeprator()
        
        let headerNib = UINib(nibName: "FindCircleHeader", bundle: nil)
        let headerView = headerNib.instantiateWithOwner(self, options: nil).first as UIView
        headerView.bounds.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: 200.0)
        self.tableView.tableHeaderView = headerView
        
        self.avatarImageView.roundCorner()
        self.avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.avatarImageView.layer.borderWidth = 1.0
        
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
    }

    @IBAction func headerBackgroundTouched(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "更换相册封面","更换2")
        actionSheet.showInView(self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 14
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FindCircleListCell.identifier(), forIndexPath: indexPath) as FindCircleListCell

        // Configure the cell...
        cell.upNumber = indexPath.row

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // 公式: max(96, 文字高度+34) + 94 + 图片模块高度
        let textHeight = (testContent as NSString).boundingRectWithSize(CGSize(width:self.screenWidth() - 166.0, height:20000.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14.0)], context: nil).height
        return max(96.0, 34.0 + textHeight) + 94.0 + 86.0
    }

}

extension FindCircleViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
    }
}
