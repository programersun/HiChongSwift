//
//  SquareViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/9.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareViewController: UITableViewController {
    
    var categoryData: LCYGetSquareCategoryResult?
    
    private let sectionHeaderHeight: CGFloat = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.showHUD()
        LCYNetworking.sharedInstance.POST(LCYApi.SquareGetSquareCategory, parameters: nil, success: { [unowned self] (object) -> Void in
            self.hideHUD()
            self.categoryData = LCYGetSquareCategoryResult.modelObjectWithDictionary(object)
            self.tableView.reloadData()
        }) { [unowned self] (error) -> Void in
            self.hideHUD()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let destination = segue.destinationViewController as SquareListViewController
            destination.categoryInfo = self.categoryData!.listInfo[(self.tableView.indexPathForSelectedRow() as NSIndexPath!).row + 5] as LCYGetSquareCategoryListInfo
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        if let unwrappedData = self.categoryData {
            return 2
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        var number = 0
        switch section {
        case 0:
            number = 2
        case 1:
            number = self.categoryData!.listInfo.count >= 5 ? self.categoryData!.listInfo.count - 5 : 0
        default:
            break
            
        }
        return number
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier(SquareAdCell.identifier()) as SquareAdCell
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier(SquareMainButtonCell.identifier()) as SquareMainButtonCell
            default:
                break
            }
        } else if indexPath.section == 1 {
            cell = tableView.dequeueReusableCellWithIdentifier(SquareSmallButtonCell.identifier()) as SquareSmallButtonCell
            let cell = cell as SquareSmallButtonCell
            let listInfo = self.categoryData!.listInfo[indexPath.row + 5] as LCYGetSquareCategoryListInfo
            cell.icyLabel.text = listInfo.cateName
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return UIScreen.mainScreen().bounds.size.width / 2.0
            case 1:
                return UIScreen.mainScreen().bounds.size.width / 40.0 * 26.0 + 8.0
            default:
                return 44.0
            }
        case 1:
            return 44.0
        default:
            return 44.0
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height: CGFloat = 0.0
        switch section {
        case 0:
            break;
        case 1:
            height = self.sectionHeaderHeight
        default:
            break;
        }
        return height
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view: UIView?
        switch section {
        case 1:
            view = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: UIScreen.mainScreen().bounds.size.width, height: self.sectionHeaderHeight)))
            view?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
            let label = UILabel()
            label.text = "其他服务"
            label.font = UIFont.systemFontOfSize(14.0)
            label.textColor = UIColor.LCYThemeOrange()
            label.sizeToFit()
            view?.addSubview(label)
            label.center = CGPoint(x: 0.0, y: view!.bounds.size.height / 2.0)
            label.frame.origin.x = 8.0
        default:
            break
        }
        return view
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            self.performSegueWithIdentifier("showDetail", sender: nil)
        }
    }
}
