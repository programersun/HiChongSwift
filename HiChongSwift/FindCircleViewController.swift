//
//  FindCircleViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/16.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class FindCircleViewController: UITableViewController {
    
    private let testContent = "I am the bone of my sword.\n" +
        "Steel is my body,and fire is my blood.\n" +
        "I have created over a thousand blades.\n" +
        "Unknown to Death.\n" +
        "Nor known to Life.\n" +
        "Have withstood pain to create many weapons.\n" +
        "Yet, those hands will never hold anything.\n" +
    "So as I pray, Unlimited Blade Works."
    
    private var keeperInfo: TwitterKeeperInfoMsg? {
        didSet {
            if let myInfo = keeperInfo {
                avatarImageView.setImageWithURL(NSURL(string:myInfo.headImage.toAbsolutePath()))
                nickNameLabel.text = myInfo.nickName
                if myInfo.bgImage != nil && countElements(myInfo.bgImage) != 0 {
                    println("set bg url = \(myInfo.bgImage.toAbsolutePath())")
                    headerBackground.setImageWithURL(NSURL(string: myInfo.bgImage.toAbsolutePath()))
                    headerTipLabel.hidden = true
                } else {
                    headerBackground.image = nil
                    headerTipLabel.hidden = false
                }
            }
        }
    }
    
    private var imagePicker: UIImagePickerController?
    
    private var twitters: [TwitterListMsg]?
    
    private enum magicNumber: Int {
        case changeCover = 3391
        case addTwitter = 3392
    }
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nickNameLabel: UILabel!
    @IBOutlet private weak var headerTipLabel: UILabel!
    @IBOutlet private weak var headerBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "宠物圈"
        self.tableView.hideExtraSeprator()
        
        let headerNib = UINib(nibName: "FindCircleHeader", bundle: nil)
        let headerView = headerNib.instantiateWithOwner(self, options: nil).first as UIView
        headerView.bounds.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.width / 320.0 * 200.0)
        self.tableView.tableHeaderView = headerView
        
        self.avatarImageView.roundCorner()
        self.avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.avatarImageView.layer.borderWidth = 1.0
        
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
        let rightItem = UIBarButtonItem(image: UIImage(named: "circleDots"), style: UIBarButtonItemStyle.Plain, target: self, action: "rightButtonPressed:")
        self.navigationItem.rightBarButtonItem = rightItem
        
        loadKeeperInfo()
        showHUD()
        reload()
        
        tableView.addHeaderWithCallback { [weak self]() -> Void in
            self?.reload()
            return
        }
        tableView.baseTextColor = UIColor.whiteColor()
    }
    
    @IBAction func headerBackgroundTouched(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "更换相册封面", "取消")
        actionSheet.destructiveButtonIndex = 1
        actionSheet.tag = magicNumber.changeCover.rawValue
        actionSheet.showInView(self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    private func loadKeeperInfo() {
        let parameters = [
            "twitter_keeper"    : LCYCommon.sharedInstance.userName!
        ]
        LCYNetworking.sharedInstance.POST(LCYApi.TwitterKeeperInfo, parameters: parameters, success: { [weak self](object) -> Void in
            let retrieved = TwitterKeeperInfoBase.modelObjectWithDictionary(object)
            if retrieved.result {
                self?.keeperInfo = retrieved.msg
            } else {
                // 个人信息加载失败
            }
            return
            }) { (error) -> Void in
                // 个人信息加载失败
                return
        }
    }
    private func reload() {
        let parameters = [
            "user_id"   : LCYCommon.sharedInstance.userName!
        ]
        LCYNetworking.sharedInstance.POST(LCYApi.TwitterList, parameters: parameters, success: { [weak self](object) -> Void in
            let retrieved = TwitterListBase.modelObjectWithDictionary(object)
            if retrieved.result {
                self?.twitters = [TwitterListMsg]()
                self?.twitters?.extend(retrieved.msg as [TwitterListMsg])
                self?.tableView.reloadData()
            }
            self?.hideHUD()
            self?.tableView.headerEndRefreshing()
            return
            }) { [weak self](error) -> Void in
                self?.hideHUD()
                self?.alert("您的网络状态不佳")
                self?.tableView.headerEndRefreshing()
                return
        }
    }
    
    func rightButtonPressed(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "新建文字消息", "新建图文消息", "取消")
        actionSheet.destructiveButtonIndex = 2
        actionSheet.tag = magicNumber.addTwitter.rawValue
        actionSheet.showInView(self.view)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showAdd" {
            let destination = segue.destinationViewController as FindCircleAddNewViewController
            let caseNumber = sender as Int
            destination.delegate = self
            
            switch caseNumber {
            case 0:
                destination.currentType = .textOnly
            case 1:
                destination.currentType = .mixed
            default:
                break
            }
        } else if segue.identifier == "showPersonal" {
            let destination = segue.destinationViewController as FindPersonalViewController
            let data = sender as TwitterListMsg
            destination.personID = data.twitterKeeper
            destination.personNickname = data.nickName
        } else if segue.identifier == "showPageView" {
            let destination = segue.destinationViewController as FindTwitterListPageViewController
            let data = sender as? TwitterListMsg
            destination.listData = data
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if let data = twitters {
            return data.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FindCircleListCell.identifier(), forIndexPath: indexPath) as FindCircleListCell
        
        // Configure the cell...
        //        cell.upNumber = indexPath.row
        cell.indexPath = indexPath
        
        let data = twitters![indexPath.row]
        cell.keeperAvatarPath = data.keeperImage.toAbsolutePath()
        cell.petAvatarPath = data.petImage.toAbsolutePath()
        cell.icyContentLabel.text = data.twitterContent
        cell.petNicknameLabel.text = data.petName
        cell.timeLabel.text = data.addTime.toTwitterDeltaTime()
        cell.keeperNicknameLabel.text = data.nickName
        cell.twitterImages = data.images as? [TwitterListImages]
        cell.starPeople = data.starList as? [TwitterListStarList]
        
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let data = twitters![indexPath.row]
        // 公式: max(96, 文字高度+34) + 94 + 图片模块高度
        // 新公式: 34 + 文字高度 + 54 + 图片高度 (+40? 取决于有没有点赞)
        let textHeight = data.twitterContent.boundingRectWithSize(CGSize(width:self.screenWidth() - 84.0, height:20000.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14.0)], context: nil).height
        var imageHeight: CGFloat = 86.0
        switch data.images.count {
        case 0:
            imageHeight = 0.0
        case 1:
            let imageData = data.images[0] as TwitterListImages
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
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let data = twitters![indexPath.row]
        if data.images != nil && data.images.count > 0 {
            performSegueWithIdentifier("showPageView", sender: data)
        }
    }
    
}

extension FindCircleViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch actionSheet.tag {
        case magicNumber.addTwitter.rawValue:
            // 新建
            switch buttonIndex {
            case 0:
                self.performSegueWithIdentifier("showAdd", sender: buttonIndex)
            case 1:
                self.performSegueWithIdentifier("showAdd", sender: buttonIndex)
            default:
                break
            }
        case magicNumber.changeCover.rawValue:
            //            println("change cover at \(buttonIndex)")
            if buttonIndex == 0 {
                imagePicker = UIImagePickerController()
                imagePicker?.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker?.delegate = self
                presentViewController(imagePicker!, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    func willPresentActionSheet(actionSheet: UIActionSheet) {
        for subView in actionSheet.subviews {
            if subView is UIButton {
                let button = subView as UIButton
                if button.titleLabel?.text != "取消" {
                    button.setTitleColor(UIColor.LCYThemeDarkText(), forState: UIControlState.Normal)
                }
            }
        }
    }
}

extension FindCircleViewController: FindCircleListCellDelegate {
    func findCircleListCellStar(indexPath: NSIndexPath) {
        println("stared \(indexPath)")
        let data = twitters![indexPath.row]
        if let starList = data.starList as? [TwitterListStarList] {
            for starPerson in starList {
                if starPerson.userId == LCYCommon.sharedInstance.userName {
                    alert("您已经点过赞啦")
                    return
                }
            }
        }
        // 没有点过赞，点赞成功后加入到点赞列表中
        let parameter = [
            "twitter_id": data.twitterId,
            "user_id": LCYCommon.sharedInstance.userName!
        ]
        LCYNetworking.sharedInstance.POST(LCYApi.TwitterStar, parameters: parameter, success: {
            [weak self](object) -> Void in
            if let result = object["result"] as? Bool {
                if result {
                    if var dynamicList = data.starList as? [TwitterListStarList] {
                        let dic = [
                            "user_id": LCYCommon.sharedInstance.userName!,
                            "head_image": self?.keeperInfo?.headImage ?? ""
                        ]
                        let me = TwitterListStarList.modelObjectWithDictionary(dic)
                        dynamicList.insert(me, atIndex: 0)
                        data.starList = dynamicList
                        data.starCount = "\(data.starCount.toInt()! + 1)"
                        
                        self?.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    } else {
                        self?.alert("点赞失败")
                    }
                } else {
                    self?.alert("点赞失败")
                }
            } else {
                
            }
            return
        }) { [weak self](error) -> Void in
            self?.alert("点赞失败，请检查您的网络状态")
            return
        }
        
        
    }
    func findCircleListCellTitleClicked(indexPath: NSIndexPath) {
        println("selected \(indexPath)")
        let data = twitters![indexPath.row]
        
        performSegueWithIdentifier("showPersonal", sender: data)
        
        //        let storyBoard = UIStoryboard(name: "AboutMe", bundle: nil)
        //        let controller = storyBoard.instantiateViewControllerWithIdentifier("userInfo") as AboutMeViewController
        //
        //        navigationController?.pushViewController(controller, animated: true)
    }
}

extension FindCircleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.showHUDWithTips("处理中")
        
        let smallImage = UIImage(image: info[UIImagePickerControllerOriginalImage] as UIImage, scaledToFillToSize: CGSize(width: 320, height: 200))
        //        UIImageWriteToSavedPhotosAlbum(smallImage, nil, nil, nil)
        
        let imageData = UIImageJPEGRepresentation(smallImage, 0.95)
        let parameters = [
            "user_id" : LCYCommon.sharedInstance.userName!
        ]
        LCYNetworking.sharedInstance.POSTFile(LCYApi.UserModifyBackgroundImage, parameters: parameters, fileKey: "filedata", fileData: imageData, fileName: "\(imageData.hash).jpg", mimeType: LCYMimeType.JPEG, success: { [weak self](object) -> Void in
            self?.hideHUD()
            if let result = object["result"] as? Bool {
                if result {
                    self?.alert("修改成功")
                    self?.loadKeeperInfo()
                } else {
                    self?.alert("修改失败")
                }
            } else {
                self?.alert("修改失败")
            }
            return
            }) { [weak self](error) -> Void in
                self?.hideHUD()
                self?.alert("您的网络状况不佳，上传失败")
                return
        }
    }
}

extension FindCircleViewController: AddCircleDelegate {
    func addCircleDone() {
        reload()
    }
}