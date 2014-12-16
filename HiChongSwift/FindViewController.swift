//
//  FindViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/16.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class FindViewController: UITableViewController {
    
    private let sectionHeaderHeight = CGFloat(24.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.hideExtraSeprator()
        let placeHolder = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 14.0)))
        self.tableView.tableHeaderView = placeHolder
        
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
        self.title = "发现"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch section {
        case 0:
            return 4
        case 1:
            return 1
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.textColor = UIColor.LCYThemeDarkText()
        cell.imageView?.image = UIImage(named: "sqDetailPhone")
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "宠物圈"
                cell.backgroundColor = UIColor.LCYTableLightGray()
            case 1:
                cell.textLabel?.text = "附近"
                cell.backgroundColor = UIColor.LCYTableLightBlue()
            case 2:
                cell.textLabel?.text = "宠友"
                cell.backgroundColor = UIColor.LCYTableLightGray()
            case 3:
                cell.textLabel?.text = "搜索"
                cell.backgroundColor = UIColor.LCYTableLightBlue()
            default:
                break
            }
        case 1:
            cell.textLabel?.text = "宠友录"
            cell.backgroundColor = UIColor.LCYTableLightBlue()
            break
        default:
            break
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return sectionHeaderHeight
        default:
            return 0.0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: sectionHeaderHeight)))
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.performSegueWithIdentifier("showCircle", sender: nil)
            default:
                break
            }
        default:
            break
        }
    }

}
