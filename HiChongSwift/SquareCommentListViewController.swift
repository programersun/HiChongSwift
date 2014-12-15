//
//  SquareCommentListViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareCommentListViewController: UITableViewController {
    
    private let lan = "韦氏智力量表的一个重要特点是采用了离差智商（deviation IQ）。所谓离差智商就是用标准分数来表示的智商，即让每一个被试和他同年龄的人相比，而不像以前比纳量表所用的智商是和上下年龄的人相比。1960年修订的斯坦福—比纳量表也采用了离差智商，使每一年龄都有平均分数，M=100，标准差σ=16；而韦氏成人和儿童智力量表，其均数也定为100，但标准差定为15。"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
        self.title = "所有评价"
        
        let rightItem = UIBarButtonItem(image: UIImage(named: "sqDetailComment"), style: UIBarButtonItemStyle.Plain, target: self, action: "rightButtonPressed:")
        self.navigationItem.rightBarButtonItem = rightItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rightButtonPressed(sender: AnyObject) {
        println("123")
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
        let cell = tableView.dequeueReusableCellWithIdentifier(SquareCommentListCell.identifier(), forIndexPath: indexPath) as SquareCommentListCell

        cell.icyContentLabel.text = lan
        
        switch indexPath.row % 2 {
        case 0:
            cell.icyGender = .male
        case 1:
            cell.icyGender = .female
        default:
            break
        }
        
        cell.icyStar = 0.5 * Float(indexPath.row)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = (lan as NSString).boundingRectWithSize(CGSize(width:UIScreen.mainScreen().bounds.width - 88.0, height:20000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14.0)], context: nil).height
        return (height + 39.0 >= 80.0) ? height + 39.0 : 80.0
    }

}
