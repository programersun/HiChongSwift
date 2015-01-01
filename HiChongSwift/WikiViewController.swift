//
//  WikiViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/25.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

let WikiAdvertisementRatio: CGFloat = 320.0 / 120.0

class WikiViewController: UITableViewController {
    
    private enum WikiListType: String {
        case More               = "More"
        case LargeSizedDogs     = "LargeSizedDogs"
        case MediumSizedDogs    = "MediumSizedDogs"
        case SmallSizedDogs     = "SmallSizedDogs"
        case Cats               = "Cats"
    }
    
    private var currentPage = 1
    
    private var listInfo: [WikiTodayData] = [WikiTodayData]()
    
    private let sectionHeaderHeight = CGFloat(40.0)
    private var sectionHeaderView: UIView!
    @IBAction func moreButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("showWikiList", sender: WikiListType.More.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // 加载数据
        reload()
        tableView.hideExtraSeprator()
        
        let nib = UINib(nibName: "WikiSectionHeader", bundle: nil)
        sectionHeaderView = nib.instantiateWithOwner(self, options: nil).first as UIView
        sectionHeaderView.bounds.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: sectionHeaderHeight)
        
        addRightButton("分类", action: "rightButtonPressed:")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func rightButtonPressed(sender: AnyObject) {
        
    }
    
    private func reload() {
        currentPage = 1
        let parameters = [
            "p" : "\(currentPage)"
        ]
        LCYNetworking.sharedInstance.GET(LCYApi.WikiToday, parameters: nil, success: { [weak self](object) -> Void in
            let dataBase = WikiTodayBase.modelObjectWithDictionary(object)
            self?.listInfo = (dataBase.data as [WikiTodayData])
            self?.tableView.reloadData()
            self?.hideHUD()
            return
            }) { [weak self](error) -> Void in
                self?.hideHUD()
                return
        }
    }
    
    @IBAction func majorCateButtonPressed(sender: UIButton) {
        switch sender.tag {
        case 1:
            performSegueWithIdentifier("showWikiList", sender: WikiListType.LargeSizedDogs.rawValue)
        case 2:
            performSegueWithIdentifier("showWikiList", sender: WikiListType.MediumSizedDogs.rawValue)
        case 3:
            performSegueWithIdentifier("showWikiList", sender: WikiListType.SmallSizedDogs.rawValue)
        case 4:
            performSegueWithIdentifier("showWikiList", sender: WikiListType.Cats.rawValue)
        default:
            break
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch section {
        case 0, 1:
            return 1
        case 2:
            return listInfo.count
        default:
            return 0
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(WikiAdCell.identifier()) as UITableViewCell
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(WikiMidCell.identifier()) as UITableViewCell
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(WikiInfoCell.identifier()) as UITableViewCell
            switch indexPath.row % 2 {
            case 0:
                cell.backgroundColor = UIColor.LCYTableLightBlue()
            case 1:
                cell.backgroundColor = UIColor.LCYTableLightGray()
            default:
                break
            }
            
            let data = listInfo[indexPath.row]
            let cell = cell as WikiInfoCell
            cell.icyTitle = data.title
            cell.keyWord = data.keyword
            cell.readCount = data.encyRead
            cell.collectCount = data.encyCollect
            cell.imagePath = data.headImg.toAbsolutePath()
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UIScreen.mainScreen().bounds.width / WikiAdvertisementRatio
        case 1:
            return 100.0
        case 2:
            return 65.0
        default:
            return 44.0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            return sectionHeaderView
        } else {
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return sectionHeaderHeight
        } else {
            return 0.0
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            performSegueWithIdentifier("showArticle", sender: nil)
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "showArticle":
                let destination = segue.destinationViewController as WikiArticleViewController
                if let index = tableView.indexPathForSelectedRow()?.row {
                    destination.wikiArticleID = listInfo[index].encyId
                }
            case "showWikiList":
                let destination = segue.destinationViewController as WikiListViewController
                if let key = sender as? String {
                    switch key {
                    case WikiListType.More.rawValue:
                        destination.navigationItemTitle = "更多"
                    case WikiListType.LargeSizedDogs.rawValue:
                        destination.navigationItemTitle = "大型犬"
                        destination.cate_id = "5"
                    case WikiListType.MediumSizedDogs.rawValue:
                        destination.navigationItemTitle = "中型犬"
                        destination.cate_id = "8"
                    case WikiListType.SmallSizedDogs.rawValue:
                        destination.navigationItemTitle = "小型犬"
                        destination.cate_id = "11"
                    case WikiListType.Cats.rawValue:
                        destination.navigationItemTitle = "猫咪"
                        destination.cate_id = "14"
                    default:
                        break
                    }
                }
            default:
                break
            }
        }
    }
    
}