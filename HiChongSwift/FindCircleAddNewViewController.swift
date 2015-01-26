//
//  FindCircleAddNewViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/16.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit
import CoreLocation

class FindCircleAddNewViewController: UITableViewController {
    
    // 上传数据 ⬇️
    private var locationString: String?
    private var myPet: GetUserInfoPetInfo?
    private var location: CLLocation?
    private weak var icyTextView: UITextView?
    private var petImages = [UIImage]()
    // 上传数据 ⬆️
    
    weak var delegate: AddCircleDelegate?
    
    private weak var imageCollectionView: UICollectionView?
    
    enum FindCircleAddNewType: Int {
        case textOnly = 0
        case mixed = 1
    }
    
    var currentType: FindCircleAddNewType = .textOnly
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        switch currentType {
        case .textOnly:
            self.title = "文字消息"
        case .mixed:
            self.title = "图文消息"
        }
        
        self.tableView.hideExtraSeprator()
        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        
        self.addRightButton("发送", action: "rightButtonPressed:")
        
        LCYCommon.sharedInstance.getLocation({ [weak self](location) -> Void in
            self?.location = location
            return
            }, fail: { [weak self]() -> Void in
                self?.alert("无法获取位置信息")
                return
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func rightButtonPressed(sender: AnyObject) {
        println("right button pressed!")
        if checkValid() {
            var parameters = [String: String]()
            switch currentType {
            case .textOnly:
                parameters.extend([
                    "twitter_keeper"    : LCYCommon.sharedInstance.userName!,
                    "twitter_pet"       : myPet!.petId,
                    "twitter_type"      : "1",
                    "twitter_content"   : icyTextView!.text,
                    "twitter_location"  : locationString ?? "",
                    "twitter_longitude" : "\(location!.coordinate.longitude)",
                    "twitter_latitude"  : "\(location!.coordinate.latitude)"
                    ])
                showHUD()
                LCYNetworking.sharedInstance.POST(LCYApi.TwitterAdd, parameters: parameters, success: { [weak self](object) -> Void in
                    if let result = object["result"] as? NSNumber {
                        if result.boolValue {
                            //                            self?.alertWithDelegate("提交成功", tag: 3301, delegate: self)
                            self?.delegate?.addCircleDone()
                            self?.navigationController?.popViewControllerAnimated(true)
                        } else {
                            self?.alert("提交失败")
                        }
                    } else {
                        self?.alert("提交失败")
                    }
                    self?.hideHUD()
                    return
                    }, failure: { [weak self](error) -> Void in
                        self?.alert("提交失败，请检查您的网络状态")
                        self?.hideHUD()
                        return
                })
            case .mixed:
                // TODO: 图文混合
                parameters.extend([
                    "twitter_keeper"    : LCYCommon.sharedInstance.userName!,
                    "twitter_pet"       : myPet!.petId,
                    "twitter_type"      : "2",
                    "twitter_content"   : icyTextView!.text,
                    "twitter_location"  : locationString ?? "",
                    "twitter_longitude" : "\(location!.coordinate.longitude)",
                    "twitter_latitude"  : "\(location!.coordinate.latitude)"
                    ])
                showHUD()
                let fileData = map(petImages, { (oneImage) -> NSData in
                    UIImageJPEGRepresentation(oneImage, 0.95)
                })
                LCYNetworking.sharedInstance.POSTMultipleFile(LCYApi.TwitterAdd, parameters: parameters, fileKey: "Filedata[]", fileData: fileData, success: {
                    [weak self](object) -> Void in
                    if let result = object["result"] as? NSNumber {
                        if result.boolValue {
                            //                            self?.alertWithDelegate("提交成功", tag: 3301, delegate: self)
                            self?.delegate?.addCircleDone()
                            self?.navigationController?.popViewControllerAnimated(true)
                        } else {
                            self?.alert("提交失败")
                        }
                    } else {
                        self?.alert("提交失败")
                    }
                    self?.hideHUD()
                    return
                    }, failure: { [weak self](error) -> Void in
                        return
                })
                break
            }
            
        }
    }
    
    private func checkValid() -> Bool {
        if location == nil {
            alert("未能获取用户位置信息")
            return false
        }
        if myPet == nil {
            alert("请选择一个宠物")
            return false
        }
        if let text = icyTextView?.text {
            if countElements(text) == 0 {
                alert("请输入要发送的消息")
                return false
            }
        } else {
            alert("程序员认为：此处不应该被执行到的;]")
            return false
        }
        if currentType == .mixed && petImages.count == 0 {
            alert("请至少上传一张照片")
            return false
        }
        return true
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "showLocation":
                let destination = segue.destinationViewController as FindLocationViewController
                destination.delegate = self
            case "showPet":
                let destination = segue.destinationViewController as FindPetViewController
                destination.delegate = self
            default:
                break
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        switch currentType {
        case .textOnly:
            return 2
        case .mixed:
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch currentType {
        case .textOnly:
            switch section {
            case 0:
                return 1
            case 1:
                return 2
            default:
                return 0
            }
        case .mixed:
            switch section {
            case 0:
                return 1
            case 1:
                return 2
            case 2:
                return 1
            default:
                return 0
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(FindCircleAddTextCell.identifier(), forIndexPath: indexPath) as UITableViewCell
            let cell = cell as FindCircleAddTextCell
            icyTextView = cell.icyTextView
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("pickerCell") as UITableViewCell
            switch indexPath.row {
            case 0:
                cell.imageView?.image = UIImage(named: "findCircle")
                cell.textLabel?.text = ""
                cell.backgroundColor = UIColor.LCYTableLightGray()
                if let petInfo = myPet {
                    cell.detailTextLabel?.text = petInfo.petName
                } else {
                    cell.detailTextLabel?.text = "选择宠物"
                }
            case 1:
                cell.imageView?.image = UIImage(named: "findNearby")
                cell.textLabel?.text = ""
                cell.backgroundColor = UIColor.LCYTableLightBlue()
                if let location = locationString {
                    cell.detailTextLabel?.text = location
                } else {
                    cell.detailTextLabel?.text = "选择位置"
                }
            default:
                break
            }
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(FindAddImageCell.identifier()) as UITableViewCell
            let cell = cell as FindAddImageCell
            cell.collectionDataSource = self
            imageCollectionView = cell.icyCollectionView
        default:
            break
        }
        
        // Configure the cell...
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150.0
        case 1:
            return 44.0
        case 2:
            return UIScreen.mainScreen().bounds.width / 4.0 * 3.0 + 20.0
        default:
            return 44.0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 1:
            if indexPath.row == 0 {
                // 选择宠物
                performSegueWithIdentifier("showPet", sender: nil)
            } else {
                // 选择位置
                performSegueWithIdentifier("showLocation", sender: nil)
            }
        default:
            break
        }
    }
    
}

extension FindCircleAddNewViewController: FindAddImageSource {
    func addImageWillTakePicture() {
        if petImages.count < 9 {
            let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "我要拍照", "从照片库选取", "取消")
            actionSheet.destructiveButtonIndex = 2
            actionSheet.showInView(self.view)
        } else {
            alert("您一次最多可以上传9张图片")
        }
    }
    func addImageCount() -> Int {
        return petImages.count
    }
    func addImageAt(index: Int) -> UIImage? {
        return petImages[index]
    }
}

extension FindCircleAddNewViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if petImages.count >= 9 {
            alert("您最多可以上传9张照片")
            return
        }
        switch buttonIndex {
        case 0:
            // 我要拍照
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .Camera
            imagePicker.delegate = self
            self.presentViewController(imagePicker, animated: true, completion: nil)
            break
        case 1:
            // 从照片库中选择
//            let imagePicker = UIImagePickerController()
//            imagePicker.sourceType = .PhotoLibrary
//            imagePicker.delegate = self
//            self.presentViewController(imagePicker, animated: true, completion: nil)
            let multiPicker = ICYMultiImagePicker()
            multiPicker.maxSelectNumber = 9 - petImages.count
            multiPicker.delegate = self
            multiPicker.show()
            break
        default:
            break
        }
    }
}

extension FindCircleAddNewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.showHUDWithTips("处理中")
        
        let smallImage = UIImage(image: info[UIImagePickerControllerOriginalImage] as UIImage, scaledToFitToSize: CGSize(width: 600, height: 600))
        if picker.sourceType == .Camera {
            UIImageWriteToSavedPhotosAlbum(smallImage, nil, nil, nil)
        }
        
        petImages.append(smallImage)
        imageCollectionView?.reloadData()
        // 处理上传之后，隐藏HUD
        self.hideHUD()
    }
}

extension FindCircleAddNewViewController: FindLocationDelegate {
    func findLocationSuccess(location: String?) {
        locationString = location
        tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
}

extension FindCircleAddNewViewController: FindPetDelegate {
    func findPetSuccess(pet: GetUserInfoPetInfo?) {
        myPet = pet
        tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
}

extension FindCircleAddNewViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 3301 {
            delegate?.addCircleDone()
            navigationController?.popViewControllerAnimated(true)
        }
    }
}

extension FindCircleAddNewViewController: ICYMultiImagePickerDelegate {
    func ICYMultiImagePickerDidSelectImages(images: [UIImage]) {
        petImages.extend(images)
        imageCollectionView?.reloadData()
    }
}

protocol AddCircleDelegate: class {
    func addCircleDone()
}
