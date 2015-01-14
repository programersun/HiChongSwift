//
//  WikiCollectionListViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/25.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class WikiCollectionListViewController: UITableViewController {
    
    private var infoData: [WikiCollectListData]?
    
    private var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        reload()
        
        tableView.backgroundColor = UIColor.LCYThemeColor()
        
        tableView.hideExtraSeprator()
        
        tableView.addFooterWithCallback { [weak self]() -> Void in
            self?.loadMore()
            return
        }
    }
    
    private func loadMore() {
        let parameters = [
            "p": "\(currentPage)",
            "user_name": LCYCommon.sharedInstance.userName!
        ]
        LCYNetworking.sharedInstance.POST(LCYApi.WikiCollectList, parameters: parameters, success: { [weak self](object) -> Void in
            let retrived = WikiCollectListBase.modelObjectWithDictionary(object)
            if var list = self?.infoData {
                if let data = retrived.data {
                    if data.count == 0 {
                        self?.alert("已经没有更多了")
                    } else {
                        list.extend(data as [WikiCollectListData])
                        self?.infoData = list
                        self?.tableView.reloadData()
                        self?.currentPage++
                    }
                } else {
                    self?.alert("加载失败")
                }
            }
            self?.tableView.footerEndRefreshing()
        }) { [weak self](error) -> Void in
            self?.alert("加载失败")
            self?.tableView.footerEndRefreshing()
            return
        }
    }
    
    private func reload() {
        currentPage = 1
        let parameters = [
            "p": "\(currentPage)",
            "user_name": LCYCommon.sharedInstance.userName!
        ]
        LCYNetworking.sharedInstance.POST(LCYApi.WikiCollectList, parameters: parameters, success: { [weak self](object) -> Void in
            let retrived = WikiCollectListBase.modelObjectWithDictionary(object)
            self?.infoData = [WikiCollectListData]()
            if let data = retrived.data {
                self?.infoData?.extend(data as [WikiCollectListData])
                self?.tableView.reloadData()
                self?.currentPage++
            } else {
                self?.alert("加载失败")
            }
        }) { [weak self](error) -> Void in
            self?.alert("加载失败")
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
        if infoData != nil {
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if let data = infoData {
            return data.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(WikiInfoCell.identifier(), forIndexPath: indexPath) as WikiInfoCell
        
        switch indexPath.row % 2 {
        case 0:
            cell.backgroundColor = UIColor.LCYTableLightBlue()
        case 1:
            cell.backgroundColor = UIColor.LCYTableLightGray()
        default:
            break
        }
        
        // Configure the cell...
        if let data = infoData?[indexPath.row] {
            cell.icyTitle = data.title
            cell.keyWord = data.keyword
            cell.readCount = data.encyRead
            cell.collectCount = data.encyCollect
            cell.imagePath = data.headImg.toAbsolutePath()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65.0
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
                    destination.wikiArticleID = infoData?[index].encyId
                }
            default:
                break
            }
        }
    }
}
