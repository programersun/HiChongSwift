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
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("title") as UITableViewCell
            dispatch_once(&cellOnceToken)
                { () -> Void in
                cell.textLabel?.textColor = UIColor.LCYThemeDarkText()
                return
            }
            cell.textLabel?.text = "小马宠物医院"
            
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(SquareAddStarCell.identifier()) as SquareAddStarCell
            let cell = cell as SquareAddStarCell
            self.starCell = cell
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("title") as UITableViewCell
        default:
            break
        }

        return cell
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
