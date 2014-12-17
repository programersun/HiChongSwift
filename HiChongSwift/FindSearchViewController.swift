//
//  FindSearchViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/17.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class FindSearchViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.title = "搜索"
        self.addRightButton("确定", action: "rightButtonPressed:")
        self.tableView.hideExtraSeprator()
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
        let placeHolder = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 14.0)))
        self.tableView.tableHeaderView = placeHolder
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func rightButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("showSearchResult", sender: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 6
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        switch indexPath.row % 2 {
        case 0:
            cell.backgroundColor = UIColor.LCYTableLightGray()
        case 1:
            cell.backgroundColor = UIColor.LCYTableLightBlue()
        default:
            break
        }
        
        let imageName = "findSearch_0\(indexPath.row)"
        cell.imageView?.image = UIImage(named: imageName)
        
        cell.textLabel?.textColor = UIColor.LCYThemeDarkText()

        cell.detailTextLabel?.text = "不限制"
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "宠物种类"
        case 1:
            cell.textLabel?.text = "距离"
        case 2:
            cell.textLabel?.text = "宠物年龄"
        case 3:
            cell.textLabel?.text = "找配种"
        case 4:
            cell.textLabel?.text = "求领养"
        case 5:
            cell.textLabel?.text = "被寄养"
        default:
            break
        }

        return cell
    }

}
