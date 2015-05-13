//
//  AboutMeFeedBackViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/13.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class AboutMeFeedBackViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    
    @IBAction func confirmButtonPressed(sender: AnyObject) {
        showHUD()
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.35 * Double(NSEC_PER_SEC))), dispatch_get_main_queue())
            {
                [weak self] in
                self?.hideHUD()
                self?.alertWithDelegate("感谢您提供的宝贵意见", tag: 3301, delegate: self)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }

}

extension AboutMeFeedBackViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        navigationController?.popViewControllerAnimated(true)
    }
}
