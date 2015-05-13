//
//  SquareCommentListViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareCommentListViewController: UITableViewController {
    
    var businessID: String?
    var businessName: String?
    
    private var commentData: [SquareCommentListMsg]?
    
    private var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
        self.title = "所有评价"
        
        let rightItem = UIBarButtonItem(image: UIImage(named: "sqDetailComment"), style: UIBarButtonItemStyle.Plain, target: self, action: "rightButtonPressed:")
        self.navigationItem.rightBarButtonItem = rightItem
        
        if businessID == nil {
            alert("无法加载商家信息，请退回重试")
        } else {
            reload()
        }
        
        tableView.addFooterWithCallback { [weak self]() -> Void in
            self?.loadMore()
            return
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    private func reload() {
        let parameter = [
            "business_id":  businessID!,
            "page":         "0"
        ]
        currentPage = 0
        LCYNetworking.sharedInstance.POST(LCYApi.SquareCommentList, parameters: parameter, success: { [weak self](object) -> Void in
            let retrieved = SquareCommentListBase.modelObjectWithDictionary(object as [NSObject : AnyObject])
            if retrieved.result {
                self?.commentData = [SquareCommentListMsg]()
                if let msg = retrieved.msg as? [SquareCommentListMsg] {
                    self?.commentData?.extend(msg)
                }
                self?.tableView.reloadData()
            } else {
                self?.alert("无法获取评论列表")
            }
            return
        }) { [weak self](error) -> Void in
            self?.alert("网络连接异常")
            return
        }
    }
    
    private func loadMore() {
        currentPage++
        let parameter = [
            "business_id":  businessID!,
            "page":         "\(currentPage)"
        ]
        LCYNetworking.sharedInstance.POST(LCYApi.SquareCommentList, parameters: parameter, success: { [weak self](object) -> Void in
            let retrieved = SquareCommentListBase.modelObjectWithDictionary(object as [NSObject : AnyObject])
            if retrieved.result {
                if let msg = retrieved.msg as? [SquareCommentListMsg] {
                    self?.commentData?.extend(msg)
                }
                self?.tableView.reloadData()
            } else {
                // 获取错误
                self?.currentPage--
            }
            self?.tableView.footerEndRefreshing()
        }) { [weak self](error) -> Void in
            self?.currentPage--
            self?.tableView.footerEndRefreshing()
            return
        }
    }
    
    func rightButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("showAdd", sender: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "showAdd":
                let destination = segue.destinationViewController as! SquareCommentViewController
                destination.businessID = businessID
                destination.businessName = businessName
                destination.delegate = self
            default:
                break
            }
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
        if let data = commentData {
            return data.count
        } else {
            return 0
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SquareCommentListCell.identifier(), forIndexPath: indexPath) as! SquareCommentListCell

        let data = commentData![indexPath.row]
        let commentText = data.content
        cell.icyContentLabel.text = commentText
        
        cell.icyNameLabel.text = data.nickName
        
        cell.imagePath = data.headImage.toAbsolutePath()
        
        cell.icyGender = .unknown
        
        cell.icyStar = (data.commentScore as NSString).floatValue

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let data = commentData![indexPath.row]
        let height = (data.content as NSString).boundingRectWithSize(CGSize(width:UIScreen.mainScreen().bounds.width - 88.0, height:20000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14.0)], context: nil).height
        return (height + 39.0 >= 80.0) ? height + 39.0 : 80.0
    }

}

extension SquareCommentListViewController: SquareCommentDelegate {
    func squareDidAddComment() {
        reload()
    }
}
