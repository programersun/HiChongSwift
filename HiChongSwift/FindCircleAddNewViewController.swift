//
//  FindCircleAddNewViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/16.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class FindCircleAddNewViewController: UITableViewController {
    
    enum FindCircleAddNewType: Int {
        case textOnly = 0
        case mixed = 1
    }
    
    var currentType: FindCircleAddNewType = .textOnly
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        switch currentType {
        case .textOnly:
            self.title = "文字消息"
        case .mixed:
            self.title = "图文消息"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        switch currentType {
        case .textOnly:
            return 2
        case .mixed:
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch currentType {
        case .textOnly:
            switch section {
            case 0:
                return 1
            case 1:
                return 2
            default:
                return 0
            }
        case .mixed:
            switch section {
            case 0:
                return 1
            case 1:
                return 2
            case 2:
                return 1
            default:
                return 0
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FindCircleAddTextCell.identifier(), forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        
        return cell
    }
    
}
