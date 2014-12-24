//
//  PetCateFilterViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/24.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class PetCateFilterViewController: UITableViewController {

    weak var delegate: PetCateFilterDelegate?
    weak var root: UIViewController?
    
    private var allTypeBase: LCYPetAllTypeBase?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        let parameter = NSDictionary()
        LCYNetworking.sharedInstance.POST(LCYApi.PetAllType, parameters: nil, success: { [weak self](object) -> Void in
            self?.allTypeBase = LCYPetAllTypeBase.modelObjectWithDictionary(object)
            self?.tableView.reloadData()
            return
        }) { [weak self](error) -> Void in
            self?.alert("获取信息失败，请检查网络状态")
            return
        }
        
        tableView.backgroundColor = UIColor.LCYThemeColor()
        tableView.hideExtraSeprator()
        
        navigationItem.title = "科目"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        if allTypeBase != nil {
            return 1
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return allTypeBase!.fatherStyle.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(PetCateFilterCell.identifier(), forIndexPath: indexPath) as PetCateFilterCell

        // Configure the cell...
        if let styleInfo = allTypeBase?.fatherStyle[indexPath.row] as? LCYPetAllTypeFatherStyle {
            cell.icyImageView?.setImageWithURL(NSURL(string: styleInfo.headImg.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
            cell.icyTextLabel?.text = styleInfo.name
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
            case "showLv2":
                let destination = segue.destinationViewController as PetSubTypeViewController
                if let indexPath = tableView.indexPathForSelectedRow()?.row {
                    let info = allTypeBase?.fatherStyle[indexPath] as? LCYPetAllTypeFatherStyle
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
