//
//  FindChooseSingleSelectionViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

enum FindChooseSingleResult: Int {
    case Yes                = 0
    case No                 = 1
    case Unselected         = 2
}

protocol FindChooseSingleDelegate: class {
    func findChooseSingleDone(indexPath: NSIndexPath, result: FindChooseSingleResult)
}

class FindChooseSingleSelectionViewController: UITableViewController {
    
    var indexPath: NSIndexPath?
    weak var delegate: FindChooseSingleDelegate?
    
    private var currentResult: FindChooseSingleResult = .Unselected {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        addRightButton("确定", action: "rightButtonPressed:")
    }
    
    func rightButtonPressed(sender: AnyObject) {
        if let delegate = delegate {
            if let indexPath = indexPath {
                delegate.findChooseSingleDone(indexPath, result: currentResult)
            }
        }
        navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        if indexPath.row == currentResult.rawValue {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "是"
        case 1:
            cell.textLabel?.text = "否"
        case 2:
            cell.textLabel?.text = "不限制"
        default:
            break
        }

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentResult = FindChooseSingleResult(rawValue: indexPath.row)!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
