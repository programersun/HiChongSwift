//
//  PetSubTypeViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/24.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class PetSubTypeViewController: UITableViewController {
    
    weak var delegate: PetCateFilterDelegate?
    weak var root: UIViewController?
    
    var parentID: String?
    
    private var subTypeInfo: LCYPetSubTypeBase?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let uid = parentID{
            let parameter = ["f_id": uid]
            LCYNetworking.sharedInstance.POST(LCYApi.PetSubType, parameters: parameter, success: { [weak self] (object) -> Void in
                self?.subTypeInfo = LCYPetSubTypeBase.modelObjectWithDictionary(object)
                self?.tableView.reloadData()
                return
            }, failure: { [weak self](error) -> Void in
                self?.alert("您的网络状态不给力哟")
                return
            })
        } else {
            alert("内部错误，请退回重试")
        }
        
        tableView.backgroundColor = UIColor.LCYThemeColor()
        
        navigationItem.title = "分类"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        if subTypeInfo != nil {
            return 1
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if let count = subTypeInfo?.childStyle.count {
            return count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(PetCateFilterCell.identifier(), forIndexPath: indexPath) as PetCateFilterCell

        if let childInfo = subTypeInfo?.childStyle[indexPath.row] as? LCYPetSubTypeChildStyle {
            cell.icyImageView?.setImageWithURL(NSURL(string: childInfo.headImg.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
            cell.icyTextLabel?.text = childInfo.name
        }

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "showLV3":
                let destination = segue.destinationViewController as PetFinalFilterViewController
                if let indexPath = tableView.indexPathForSelectedRow()?.row {
                    let info = subTypeInfo?.childStyle[indexPath] as? LCYPetSubTypeChildStyle
                    destination.parentID = info?.catId
                    destination.delegate = delegate
                    destination.root = root
                }

            default:
                break
            }
        }
    }

}
