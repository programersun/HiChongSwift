//
//  FindTwitterCommentViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/13.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class FindTwitterCommentViewController: UITableViewController {
    
    var twitterData: TwitterListMsg?
    
    private var infoData: TwitterCommentListMsg?
    
    private weak var icyTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if twitterData != nil {
            reload()
        } else {
            alert("无法获取宠物圈信息，请退回重试")
        }
        
        tableView.backgroundColor = UIColor.LCYThemeColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    private func reload() {
        if let twitterID = twitterData?.twitterId {
            let parameters = [
                "twitter_id": twitterID
            ]
            LCYNetworking.sharedInstance.POST(LCYApi.TwitterCommentList, parameters: parameters, success: { [weak self](object) -> Void in
                let retrieved = TwitterCommentListBase.modelObjectWithDictionary(object)
                if retrieved.result {
                    self?.infoData = retrieved.msg
                    self?.tableView.reloadData()
                } else {
                    self?.alert("内容加载失败")
                }
                return
                }, failure: { [weak self](error) -> Void in
                    self?.alert("您的网络状况不佳")
                    return
            })
        }
    }
    
    @IBAction func sendButtonPressed(sender: UIButton) {
        
        if let data = twitterData {
            if let content = icyTextField?.text {
                if countElements(content) == 0 {
                    alert("不能回复空消息哦")
                    return
                } else {
                    // 检查完毕，发送啦～
                    let parameter = [
                        "twitter_id": data.twitterId,
                        "keeper_id": LCYCommon.sharedInstance.userName,
                        "content": content
                    ]
                    icyTextField?.text = ""
                    sender.enabled = false
                    LCYNetworking.sharedInstance.POST(LCYApi.TwitterCommentAdd, parameters: parameter,
                        success: { [weak self, weak sender](object) -> Void in
                            sender?.enabled = true
                            self?.reload()
                            return
                        }, failure: { [weak self, weak sender](error) -> Void in
                            sender?.enabled = true
                            return
                    })
                }
            } else {
                alert("不能回复空消息哦")
                return
            }
        }
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        if infoData != nil {
            return 3
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch section {
        case 0:
            return 1
        case 1:
            return infoData?.comment.count ?? 0
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        // Configure the cell...
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(FindCircleListCell.identifier()) as FindCircleListCell
            let cell = cell as FindCircleListCell
            
            if let data = twitterData {
                cell.keeperAvatarPath = data.keeperImage.toAbsolutePath()
                cell.petAvatarPath = data.petImage.toAbsolutePath()
                cell.icyContentLabel.text = data.twitterContent
                cell.petNicknameLabel.text = data.petName
                cell.timeLabel.text = data.addTime.toTwitterDeltaTime()
                cell.keeperNicknameLabel.text = data.nickName
                cell.twitterImages = data.images as? [TwitterListImages]
                cell.starPeople = data.starList as? [TwitterListStarList]
                
                //                cell.delegate = self
            }
            
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(FindTwitterCommentListCell.identifier) as FindTwitterCommentListCell
            let cell = cell as FindTwitterCommentListCell
            
            let comment = infoData!.comment[indexPath.row] as TwitterCommentListComment
            
            var attributed = NSMutableAttributedString(string: "\(comment.keeperName):\(comment.content)")
            let nameRange = NSRange(location: 0, length: countElements(comment.keeperName))
            let contentRange = NSRange(location: countElements(comment.keeperName) + 1, length: countElements(comment.content))
            attributed.addAttributes([
                NSFontAttributeName             : UIFont.systemFontOfSize(12.0),
                NSForegroundColorAttributeName  : UIColor.LCYThemeDarkText()
                ], range: nameRange)
            attributed.addAttributes([
                NSFontAttributeName             : UIFont.systemFontOfSize(12.0),
                NSForegroundColorAttributeName  : UIColor.blackColor()
                ], range: contentRange)
            cell.icyLabel.attributedText = attributed
            
            switch indexPath.row % 2 {
            case 0:
                cell.backgroundColor = UIColor.LCYTableLightBlue()
            case 1:
                cell.backgroundColor = UIColor.LCYTableLightGray()
            default:
                break
            }
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(FindTwitterCommentCell.identifier) as FindTwitterCommentCell
            let cell = cell as FindTwitterCommentCell
            icyTextField = cell.icyTextField
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            let data = infoData!
            // 公式: max(96, 文字高度+34) + 94 + 图片模块高度
            // 新公式: 34 + 文字高度 + 54 + 图片高度 (+40? 取决于有没有点赞)
            let textHeight = data.twitterContent.boundingRectWithSize(CGSize(width:self.screenWidth() - 84.0, height:20000.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14.0)], context: nil).height
            var imageHeight: CGFloat = 86.0
            switch data.image.count {
            case 0:
                imageHeight = 0.0
            case 1:
                let imageData = data.image[0] as TwitterListImages
                imageHeight = CGFloat((imageData.imageHeight as NSString).floatValue) / CGFloat((imageData.imageWidth as NSString).floatValue) * CGFloat(242.0 * 0.667)
            case 2, 3:
                imageHeight = 86.0
            case 4, 5, 6:
                imageHeight = 164.0
            case 7, 8, 9:
                imageHeight = 242.0
            default:
                break
            }
            return 34.0 + textHeight + 54.0 + imageHeight + ( data.starCount == "0" ? 0.0 : 40.0 )
        case 1:
            let comment = infoData!.comment[indexPath.row] as TwitterCommentListComment
            var attributed = NSMutableAttributedString(string: "\(comment.keeperName):\(comment.content)")
            let nameRange = NSRange(location: 0, length: countElements(comment.keeperName))
            let contentRange = NSRange(location: countElements(comment.keeperName) + 1, length: countElements(comment.content))
            attributed.addAttributes([
                NSFontAttributeName             : UIFont.systemFontOfSize(12.0),
                NSForegroundColorAttributeName  : UIColor.LCYThemeDarkText()
                ], range: nameRange)
            attributed.addAttributes([
                NSFontAttributeName             : UIFont.systemFontOfSize(12.0),
                NSForegroundColorAttributeName  : UIColor.blackColor()
                ], range: contentRange)
            let height = attributed.boundingRectWithSize(CGSize(width: UIScreen.mainScreen().bounds.width - 16.0, height: 20000.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil).height
            return height + 12.0
        case 2:
            return 44.0
        default:
            return 0.0
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