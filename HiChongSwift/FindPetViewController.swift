//
//  FindPetViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/7.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class FindPetViewController: UITableViewController {
    
    private var userInfo: [GetUserInfoPetInfo]?
    
    weak var delegate: FindPetDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        reload()
        tableView.hideExtraSeprator()
        navigationItem.title = "选择宠物"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Actions
    private func reload() {
        showHUD()
        let parameter = ["user_name": LCYCommon.sharedInstance.userName!]
        LCYNetworking.sharedInstance.POST(LCYApi.UserGetInfo, parameters: parameter, success: { [weak self] (object) -> Void in
            let retrieved = GetUserInfoBase.modelObjectWithDictionary(object)
            if retrieved.result {
                self?.userInfo = retrieved.petInfo as? [GetUserInfoPetInfo]
                self?.tableView.reloadData()
            } else {
                self?.alert("无法获取宠物信息")
            }
            self?.hideHUD()
            return
            }) { [weak self](error) -> Void in
                self?.hideHUD()
                self?.alert("无法获取宠物信息")
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
        return userInfo?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = userInfo![indexPath.row].petName
        cell.detailTextLabel?.text = userInfo![indexPath.row].name

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.findPetSuccess(userInfo![indexPath.row])
        navigationController?.popViewControllerAnimated(true)
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

protocol FindPetDelegate: class {
    func findPetSuccess(pet: GetUserInfoPetInfo?)
}
