//
//  AboutMeEditProfileViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/23.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit
import CoreData

class AboutMeEditProfileViewController: UITableViewController {
    var _userInfo: GetUserInfoUserInfo?
    private var userInfo: GetUserInfoUserInfo!
    typealias ModifyBlock = () -> Void
    var afterSuccessModify: ModifyBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if _userInfo != nil {
            userInfo = _userInfo?.copy() as GetUserInfoUserInfo
        } else {
            alert("无法获取个人信息")
        }
        tableView.backgroundColor = UIColor.LCYThemeColor()
        
        navigationItem.title = "编辑"
        
        addRightButton("确定", action: "rightButtonPressed:")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func rightButtonPressed(sender: AnyObject) {
        showHUDWithTips("正在提交")
        let parameters: [String: String!] = [
            "user_name" : LCYCommon.sharedInstance.userName,
            "nick_name" : userInfo.nickName,
            "sex"       : userInfo.sex,
            "town"      : userInfo.town,
            "city"      : userInfo.city,
            "province"  : userInfo.province,
            "email"     : userInfo.email != nil ? userInfo.email : "",
            "address"   : userInfo.address != nil ? userInfo.address : "",
            "tip"       : userInfo.tip != nil ? userInfo.tip : "",
            "qq"        : userInfo.qq != nil ? userInfo.qq : "",
            "telephone" : userInfo.telephone != nil ? userInfo.telephone : "",
            "wechat"    : userInfo.wechat != nil ? userInfo.wechat : "",
            "weibo"     : userInfo.weibo != nil ? userInfo.weibo : "",
            "f_qq"      : userInfo.fQq,
            "f_telephone": userInfo.fTelephone,
            "f_wechat"  : userInfo.fWechat,
            "f_weibo"   : userInfo.fWeibo,
            "f_cellphone": userInfo.fCellphone,
            "f_address" : userInfo.fAddress,
            "f_location": userInfo.fLocation,
            "f_tip"     : userInfo.fTip
        ]
        LCYNetworking.sharedInstance.POST(LCYApi.UserModifyInfo, parameters: parameters,
            success: { [weak self] (object) -> Void in
                if let result = object["result"]?.boolValue {
                    if result {
                        self?.alertWithDelegate("修改成功", tag: 9001, delegate: self)
                        self?._userInfo = self?.userInfo
                        if(self?.afterSuccessModify != nil)
                        {
                            self?.afterSuccessModify!()
                        }
                    } else {
                        self?.alert("修改失败")
                    }
                } else {
                    self?.alert("修改失败")
                }
                
                return
            }) { [weak self] (error) -> Void in
                return
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        if userInfo != nil {
            return 4
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return 1
        case 3:
            return 5
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(AboutMeHeaderCell.identifier()) as UITableViewCell
            let cell = cell as AboutMeHeaderCell
            cell.avatarImagePath = userInfo.headImage.toAbsolutePath()
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as UITableViewCell
            cell.textLabel?.textColor = UIColor.LCYThemeDarkText()
            cell.detailTextLabel?.textColor = UIColor.darkTextColor()
            
            switch indexPath.row % 2 {
            case 0:
                cell.backgroundColor = UIColor.LCYTableLightGray()
            case 1:
                cell.backgroundColor = UIColor.LCYTableLightBlue()
            default:
                break
            }
            
            switch indexPath.row {
            case 0:
                cell.imageView?.image = UIImage(named: "AboutMeMid1")
                cell.textLabel?.text = "昵称"
                cell.detailTextLabel?.text = userInfo.nickName
            case 1:
                cell.imageView?.image = UIImage(named: "AboutMeMid5")
                cell.textLabel?.text = "性别"
                cell.detailTextLabel?.text = userInfo.sex == "0" ? "男" : "女"
            case 2:
                cell.imageView?.image = UIImage(named: "AboutMeMid4")
                cell.textLabel?.text = "手机"
                cell.detailTextLabel?.text = userInfo.userName
            case 3:
                cell.imageView?.image = UIImage(named: "AboutMeMid2")
                cell.textLabel?.text = "位置"
                let province = userInfo.province
                let city = userInfo.city
                let town = userInfo.town
                var provinceText: String?
                var cityText: String?
                var townText: String?
                let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                let context = appDelegate.managedObjectContext!
                let fetchRequset = NSFetchRequest()
                let entity = NSEntityDescription.entityForName("Region", inManagedObjectContext: context)
                fetchRequset.entity = entity
                let predicate = NSPredicate(format: "region_id == %@ OR region_id == %@ OR region_id == %@", argumentArray:[province, city, town])
                fetchRequset.predicate = predicate
                var error: NSError? = nil
                let result = context.executeFetchRequest(fetchRequset, error: &error)
                if let entities = result {
                    for regionEntity in entities as [Region] {
                        switch regionEntity.region_id {
                        case province.toInt()!:
                            provinceText = regionEntity.region_name
                        case city.toInt()!:
                            cityText = regionEntity.region_name
                        case town.toInt()!:
                            townText = regionEntity.region_name
                        default:
                            break
                        }
                    }
                } else {
                    println("error!===>\(error)")
                }
                if let townText = townText {
                    cell.detailTextLabel?.text = "\(provinceText!) \(cityText!) \(townText)"
                } else {
                    cell.detailTextLabel?.text = "\(provinceText!) \(cityText!)"
                }
                
            default:
                break
            }
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(AboutMeSwitchCell.identifier()) as UITableViewCell
            let cell = cell as AboutMeSwitchCell
            cell.backgroundColor = UIColor.LCYTableLightGray()
            cell.icyMajorLabel.text = "签名"
            cell.minorText = userInfo.tip
            cell.switchOn = userInfo.fTip == "1"
            cell.delegate = self
            cell.indexPath = indexPath
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier(AboutMeSwitchCell.identifier()) as UITableViewCell
            switch indexPath.row % 2 {
            case 0:
                cell.backgroundColor = UIColor.LCYTableLightGray()
            case 1:
                cell.backgroundColor = UIColor.LCYTableLightBlue()
            default:
                break
            }
            let cell = cell as AboutMeSwitchCell
            cell.delegate = self
            cell.indexPath = indexPath
            switch indexPath.row {
            case 0:
                cell.icyMajorLabel.text = "QQ"
                cell.minorText = userInfo.qq
                cell.switchOn = userInfo.fQq == "1"
            case 1:
                cell.icyMajorLabel.text = "微信"
                cell.minorText = userInfo.wechat
                cell.switchOn = userInfo.fWechat == "1"
            case 2:
                cell.icyMajorLabel.text = "新浪微博"
                cell.minorText = userInfo.weibo
                cell.switchOn = userInfo.fWeibo == "1"
            case 3:
                cell.icyMajorLabel.text = "固定电话"
                cell.minorText = userInfo.telephone
                cell.switchOn = userInfo.fTelephone == "1"
            case 4:
                cell.icyMajorLabel.text = "详细地址"
                cell.minorText = userInfo.address
                cell.switchOn = userInfo.fAddress == "1"
            default:
                break
            }
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 85.0
        case 1, 2, 3:
            return 44.0
        default:
            return 44.0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            let actionSheet = UIActionSheet(title: "修改头像", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "我要拍照", "从照片库选取", "取消")
            actionSheet.destructiveButtonIndex = 2
            actionSheet.showInView(self.view)
        case 1:
            switch indexPath.row {
            case 0:
                performSegueWithIdentifier("showModifyText", sender: nil)
            case 1:
                performSegueWithIdentifier("showModifyGender", sender: nil)
            case 2:
                alert("手机号码修改功能将在后续版本中开放")
            case 3:
                performSegueWithIdentifier("showModifyLocation", sender: nil)
            default:
                break
            }
        case 2, 3:
            performSegueWithIdentifier("showModifyText", sender: nil)
        default:
            break
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showModifyText":
                let destination = segue.destinationViewController as AboutMeModifyTextViewController
                destination.delegate = self
                let indexPath = tableView.indexPathForSelectedRow()!
                var cellType: aboutMeModityTextType!
                switch indexPath.section {
                case 1:
                    cellType = .nickName
                    destination.defaultText = userInfo.nickName
                case 2:
                    cellType = .sign
                    destination.defaultText = userInfo.tip
                case 3:
                    switch indexPath.row {
                    case 0:
                        cellType = .qq
                        destination.defaultText = userInfo.qq
                    case 1:
                        cellType = .wechat
                        destination.defaultText = userInfo.wechat
                    case 2:
                        cellType = .weibo
                        destination.defaultText = userInfo.weibo
                    case 3:
                        cellType = .telephone
                        destination.defaultText = userInfo.telephone
                    case 4:
                        cellType = .address
                        destination.defaultText = userInfo.address
                    default:
                        cellType = nil
                    }
                default:
                    cellType = nil
                }
                destination.icyType = cellType
            case "showModifyLocation":
                let destination = segue.destinationViewController as AboutMeModifyLocationViewController
                destination.province = userInfo.province
                destination.city = userInfo.city
                destination.town = userInfo.town
                destination.delegate = self
            case "showModifyGender":
                let destination = segue.destinationViewController as AboutMeModifyGenderController
                destination.defaultGender = userInfo.sex == "0" ? .male : .female
                destination.delegate = self
            default:
                break
            }
        }
    }
    
}

extension AboutMeEditProfileViewController: ModifyTextDelegate {
    func didModifyText(type: aboutMeModityTextType?, text: String?) {
        if let type = type {
            switch type {
            case .nickName:
                userInfo.nickName = text
            case .sign:
                userInfo.tip = text
            case .qq:
                userInfo.qq = text
            case .wechat:
                userInfo.wechat = text
            case .weibo:
                userInfo.weibo = text
            case .telephone:
                userInfo.telephone = text
            case .address:
                userInfo.address = text
            }
        }
        tableView.reloadData()
    }
}

extension AboutMeEditProfileViewController: AboutMeModifyLocationDelegate {
    func didModifyLocation(province: String, city: String, town: String) {
        userInfo.town = town
        userInfo.city = city
        userInfo.province = province
        tableView.reloadData()
    }
}

extension AboutMeEditProfileViewController: ModifyGenderDelegate {
    func didModifyGender(gender: String) {
        userInfo.sex = gender
        tableView.reloadData()
    }
}

extension AboutMeEditProfileViewController: AboutMeSwitchCellDelegate {
    func switchStatusChanged(indexPath: NSIndexPath, isOn: Bool) {
        let value = isOn ? "1" : "0"
        switch indexPath.section {
        case 2:
            userInfo.fTip = value
        case 3:
            switch indexPath.row {
            case 0:
                userInfo.fQq = value
            case 1:
                userInfo.fWechat = value
            case 2:
                userInfo.fWeibo = value
            case 3:
                userInfo.fTelephone = value
            case 4:
                userInfo.fAddress = value
                
            default:
                break
            }
        default:
            break
        }
    }
}

extension AboutMeEditProfileViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 9001 {
            navigationController?.popViewControllerAnimated(true)
        }
    }
}

extension AboutMeEditProfileViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            // 从照片库选择
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            presentViewController(imagePicker, animated: true, completion: nil)
        case 0:
            // 从相机拍照
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(imagePicker, animated: true, completion: nil)
            break
        default:
            return
        }
    }
}

extension AboutMeEditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        showHUDWithTips("处理中")
        
        let smallImage = UIImage(image: info[UIImagePickerControllerOriginalImage] as UIImage, scaledToFillToSize: CGSize(width: 300, height: 300))
        
        // 处理上传之后，隐藏HUD
        
        // 上传照片
        let data = UIImageJPEGRepresentation(smallImage, 0.97)
        let parameter = [
            "user_name": LCYCommon.sharedInstance.userName!
        ]
        LCYNetworking.sharedInstance.POSTFile(LCYApi.UserModifyImage, parameters: parameter, fileKey: "filedata", fileData: data, fileName: "tiancailcy.jpg", mimeType: LCYMimeType.JPEG, success: { [weak self](object) -> Void in
            if let result = object["result"] as? Bool {
                if result {
                    self?.alert("头像修改成功")
                    self?.userInfo.headImage = object["head_image"] as? String
                    self?.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
                } else {
                    self?.alert("修改头像失败")
                }
            } else {
                self?.alert("修改头像失败")
            }
            return
        }) { [weak self](error) -> Void in
            self?.alert("修改头像失败")
            return
        }
    }
}
