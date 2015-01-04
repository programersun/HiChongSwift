//
//  WikiesViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/4.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class WikiesViewController: UITableViewController {
    
    var childCate: LCYPetSubTypeChildStyle?
    
    private var infoData: WikiMoreBase?
    
    private var currentType = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationItem.title = childCate?.name
        
        reload()
        
        tableView.backgroundColor = UIColor.LCYTableLightBlue()
        
        addRightButton("详细", action: "rightButtonPressed:")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func rightButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("wikiWeb", sender: nil)
    }
    
    private func reload() {
        if let child = childCate {
            LCYNetworking.sharedInstance.POSTAndGET(LCYApi.WikiMore, GETParameters: ["cate_id": child.catId], POSTParameters: nil,
                success: { [weak self](object) -> Void in
                    let retrived = WikiMoreBase.modelObjectWithDictionary(object)
                    if let data = retrived {
                        self?.infoData = data
                        self?.tableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.Automatic)
                    }
                },
                failure: { [weak self](error) -> Void in
                    self?.alert("加载失败")
                    return
            })
        } else {
            alert("信息加载失败")
        }
    }
    
    @IBAction func segmentedChanged(sender: UISegmentedControl) {
        currentType = sender.selectedSegmentIndex + 1
        tableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "showArticle":
                let destination = segue.destinationViewController as WikiArticleViewController
                var info: WikiMoreData?
                for ps in (infoData!.data as [WikiMoreData]) {
                    if ps.typeId == "\(currentType)" {
                        info = ps
                        break
                    }
                }
                if let myData = info {
                    destination.wikiArticleID = myData.encyId
                }
            case "wikiWeb":
                let destination = segue.destinationViewController as WikiWebViewController
                destination.wikiTitle = childCate?.name
                destination.wikiID = childCate?.catId
            default:
                break
            }
        }
    }
    
    
    // MARK: - Outlets
    
    
    // MARK: - TableView
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            if infoData != nil {
                return 1
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(WikiesHeadCell.identifier()) as UITableViewCell
            let cell = cell as WikiesHeadCell
            cell.imagePath = childCate?.headImg.toAbsolutePath()
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(WikiesMidCell.identifier()) as UITableViewCell
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(WikiInfoCell.identifier()) as UITableViewCell
            let cell = cell as WikiInfoCell
            var info: WikiMoreData?
            for ps in (infoData!.data as [WikiMoreData]) {
                if ps.typeId == "\(currentType)" {
                    info = ps
                    break
                }
            }
            if let myData = info {
                cell.icyTitle = myData.title
                cell.keyWord = myData.keyword
                cell.readCount = myData.encyRead
                cell.collectCount = myData.encyCollect
                cell.imagePath = myData.headImg.toAbsolutePath()
            }
        default:
            break
        }
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80.0
        case 1:
            return 44.0
        case 2:
            return 65.0
        default:
            return 0.0
        }
    }
}
