//
//  PetFinalFilterViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/24.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class PetFinalFilterViewController: UITableViewController {
    
    weak var delegate: PetCateFilterDelegate?
    weak var root: UIViewController?
    
    var parentID: String?
    
    private var subTypeInfo: LCYPetSubTypeBase?
    
    private var groupedTypeInfo: [String: [LCYPetSubTypeChildStyle]] = [String: [LCYPetSubTypeChildStyle]]()
    private var keyList: [String]?

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
                self?.groupInfo()
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
        
        tableView.tintColor = UIColor.LCYThemeDarkText()
        
        navigationItem.title = "品种"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func groupInfo() {
        if let resultList = subTypeInfo?.childStyle as? [LCYPetSubTypeChildStyle] {
            for child in resultList {
                let key = child.spell
                var startArray: [LCYPetSubTypeChildStyle]?
                if groupedTypeInfo[key] != nil {
                    startArray = groupedTypeInfo[key]
                } else {
                    startArray = [LCYPetSubTypeChildStyle]()
                }
                startArray?.append(child)
                groupedTypeInfo[key] = startArray
            }
        }
        keyList = (groupedTypeInfo as NSDictionary).allKeys.sorted({ (a: AnyObject, b: AnyObject) -> Bool in
            return (a as String) < (b as String)
        }) as? [String]
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        if let keys = keyList {
            return keys.count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let groupedData = groupedTypeInfo[keyList![section]] {
            return groupedData.count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(PetCateFilterCell.identifier(), forIndexPath: indexPath) as PetCateFilterCell

        if let groupedData = groupedTypeInfo[keyList![indexPath.section]] {
            let childInfo = groupedData[indexPath.row]
            cell.icyImageView?.setImageWithURL(NSURL(string: childInfo.headImg.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
            cell.icyTextLabel?.text = childInfo.name
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let keys = keyList {
            return keys[section]
        } else {
            return nil
        }
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        if let keys = keyList {
            return keys
        } else {
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let groupedData = groupedTypeInfo[keyList![indexPath.section]] {
            let childInfo = groupedData[indexPath.row]
            
            if let myRoot = root {
                if myRoot.isKindOfClass(WikiViewController.classForCoder()) {
                    // 如果是百科，则直接跳转
                    let wikiStoryBoard = UIStoryboard(name: "Wiki", bundle: nil)
                    let wikiVC = wikiStoryBoard.instantiateViewControllerWithIdentifier("catedWiki") as WikiesViewController
                    wikiVC.childCate = childInfo
                    navigationController?.pushViewController(wikiVC, animated: true)
                    return
                } else {
                    // 一般情况，返回处理
                    delegate?.didSelectCategory(childInfo)
                    navigationController?.popToViewController(myRoot, animated: true)
                    return
                }
            }
            
            delegate?.didSelectCategory(childInfo)
            if let uroot = root {
                navigationController?.popToViewController(uroot, animated: true)
            } else {
                navigationController?.popToRootViewControllerAnimated(true)
            }
        }
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

protocol PetCateFilterDelegate: class {
    func didSelectCategory(childCategory: LCYPetSubTypeChildStyle)
}
