//
//  FindSearchViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/17.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class FindSearchViewController: UITableViewController {
    
    private var child: LCYPetSubTypeChildStyle?
    private var age: (Int, Int)? {
        didSet {
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    private var breeding: FindChooseSingleResult = FindChooseSingleResult.Unselected {
        didSet {
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    private var adopt: FindChooseSingleResult = FindChooseSingleResult.Unselected{
        didSet {
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 3, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    private var foster: FindChooseSingleResult = FindChooseSingleResult.Unselected{
        didSet {
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 4, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.title = "搜索"
        self.addRightButton("确定", action: "rightButtonPressed:")
        self.tableView.hideExtraSeprator()
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
        let placeHolder = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 14.0)))
        self.tableView.tableHeaderView = placeHolder
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func rightButtonPressed(sender: AnyObject) {
        var parameter = [String: String]()
        if let myChild = child {
            parameter.extend(["cate_id":myChild.catId])
        }
        if let myAge = age {
            parameter.extend([
                "start_age": "\(myAge.0)",
                "end_age"   : "\(myAge.1)"
                ])
        }
        switch breeding {
        case .Yes:
            parameter.extend(["f_hybridization": "1"])
        case .No:
            parameter.extend(["f_hybridization": "0"])
        case .Unselected:
            break
        }
        switch adopt {
        case .Yes:
            parameter.extend(["f_adopt": "1"])
        case .No:
            parameter.extend(["f_adopt": "0"])
        case .Unselected:
            break
        }
        switch foster {
        case .Yes:
            parameter.extend(["is_entrust": "1"])
        case .No:
            parameter.extend(["is_entrust": "0"])
        case .Unselected:
            break
        }
        self.performSegueWithIdentifier("showSearchResult", sender: parameter)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        switch indexPath.row % 2 {
        case 0:
            cell.backgroundColor = UIColor.LCYTableLightGray()
        case 1:
            cell.backgroundColor = UIColor.LCYTableLightBlue()
        default:
            break
        }
        
        var imageName = indexPath.row == 0 ? "findSearch_0\(indexPath.row)" : "findSearch_0\(indexPath.row + 1)"
        cell.imageView?.image = UIImage(named: imageName)
        
        cell.textLabel?.textColor = UIColor.LCYThemeDarkText()
        
        cell.detailTextLabel?.text = "不限制"
        
        switch indexPath.row {
        case 0:
            if let myChild = child {
                cell.detailTextLabel?.text = myChild.name
            }
            cell.textLabel?.text = "宠物种类"
            //        case 1:
            //            cell.textLabel?.text = "距离"
        case 1:
            if let age = age {
                cell.detailTextLabel?.text = "\(age.0.toAge())~\(age.1.toAge())"
            }
            cell.textLabel?.text = "宠物年龄"
        case 2:
            switch breeding {
            case .Unselected:
                cell.detailTextLabel?.text = "不限制"
            case .Yes:
                cell.detailTextLabel?.text = "是"
            case .No:
                cell.detailTextLabel?.text = "否"
            }
            cell.textLabel?.text = "找配种"
        case 3:
            switch adopt {
            case .Unselected:
                cell.detailTextLabel?.text = "不限制"
            case .Yes:
                cell.detailTextLabel?.text = "是"
            case .No:
                cell.detailTextLabel?.text = "否"
            }
            cell.textLabel?.text = "求领养"
        case 4:
            switch foster {
            case .Unselected:
                cell.detailTextLabel?.text = "不限制"
            case .Yes:
                cell.detailTextLabel?.text = "是"
            case .No:
                cell.detailTextLabel?.text = "否"
            }
            cell.textLabel?.text = "被寄养"
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            // 宠物种类
            let storyBoard = UIStoryboard(name: "PetCateFilter", bundle: nil)
            let destination = storyBoard.instantiateInitialViewController() as! PetCateFilterViewController
            destination.delegate = self
            destination.root = self
            navigationController?.pushViewController(destination, animated: true)
        case 1:
            performSegueWithIdentifier("chooseAge", sender: nil)
        case 2, 3, 4:
            performSegueWithIdentifier("showSingle", sender: nil)
        default:
            break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "chooseAge":
                let destination = segue.destinationViewController as! FindChooseAgeViewController
                destination.delegate = self
            case "showSingle":
                let destination = segue.destinationViewController as! FindChooseSingleSelectionViewController
                destination.indexPath = tableView.indexPathForSelectedRow()
                destination.delegate = self
            case "showSearchResult":
                let destination = segue.destinationViewController as! FindSearchResultViewController
                let parameter = sender as? [String: String]
                destination.parameter = parameter
            default:
                break
            }
        }
    }
    
}

extension FindSearchViewController: PetCateFilterDelegate {
    func didSelectCategory(childCategory: LCYPetSubTypeChildStyle) {
        child = childCategory
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
}

extension FindSearchViewController: FindChooseAgeDelegate {
    func chooseAgeDone(#from: Int, to: Int) {
        age = (from, to)
    }
}

extension FindSearchViewController: FindChooseSingleDelegate {
    func findChooseSingleDone(indexPath: NSIndexPath, result: FindChooseSingleResult) {
        switch indexPath.row {
        case 2:
            breeding = result
        case 3:
            adopt = result
        case 4:
            foster = result
        default:
            break
        }
    }
}
