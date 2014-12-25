//
//  WikiCollectionListViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/25.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class WikiCollectionListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//        let parameters = [
//            "p" : "3",
//            "user_name" : LCYCommon.sharedInstance.userName!
//        ]
//        LCYNetworking.sharedInstance.POST(LCYApi.WikiCollectList, parameters: parameters, success: { (object) -> Void in
//            return
//        }) { (error) -> Void in
//            return
//        }
        LCYNetworking.sharedInstance.POSTAndGET(LCYApi.WikiCollectList, GETParameters: ["p": "1"], POSTParameters: ["user_name": LCYCommon.sharedInstance.userName!], success: { (object) -> Void in
            return
        }) { (error) -> Void in
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
