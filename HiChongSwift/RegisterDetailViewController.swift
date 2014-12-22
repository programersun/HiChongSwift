//
//  RegisterDetailViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/22.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit
import CoreData

class RegisterDetailViewController: UIViewController {
    @IBOutlet private weak var genderImageView: UIImageView!
    
    @IBOutlet private weak var nameTextField: UITextField!
    
    @IBOutlet private weak var regionTextField: UITextField!
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    private enum RegisterDetailTextFieldTag: Int {
        case name = 1
        case region = 2
    }
    
    enum RegisterGender: String{
        case male = "sqMale"
        case female = "sqFemale"
    }
    
    private var regionPickerShown: Bool = false {
        didSet {
            if oldValue != regionPickerShown {
                if regionPickerShown {
                    // 显示
                    regionPickerHeightConstraint.constant = 224.0
                    UIView.animateWithDuration(0.25, animations: {[weak self] () -> Void in
                        self?.view.layoutIfNeeded()
                        return
                    })
                } else {
                    // 隐藏
                    regionPickerHeightConstraint.constant = 0.0
                    UIView.animateWithDuration(0.25, animations: {[weak self] () -> Void in
                        self?.view.layoutIfNeeded()
                        return
                    })
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showPicker":
                let destination = segue.destinationViewController as RegionPickerViewController
                destination.delegate = self
            default:
                break
            }
        }
    }
    
    @IBOutlet private weak var icyDoneButton: UIButton!
    
    @IBOutlet weak var regionPickerHeightConstraint: NSLayoutConstraint!
    
    struct DetailUserInfo {
        var LoginName: String? = nil
        var UserPassword: String? = nil
        var Province: Region? = nil
        var City: Region? = nil
        var Town: Region? = nil
        var Gender: RegisterGender = .male
        var ImageData: NSData? = nil
        var nickName: String? = nil
    }
    
    var detailUserInfo = DetailUserInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        title = "个人信息"
        view.backgroundColor = UIColor.LCYThemeColor()
        icyDoneButton.backgroundColor = UIColor.LCYTableLightBlue()
        
        regionPickerHeightConstraint.constant = 0.0
        avatarImageView.roundCorner()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    private func clearScreen() {
        nameTextField.resignFirstResponder()
        regionPickerShown = false
    }
    
    @IBAction private func backgroundTouched(sender: AnyObject) {
        clearScreen()
    }
    
    @IBAction func changeGenderButtonPressed(sender: AnyObject) {
        switch detailUserInfo.Gender {
        case .male:
            detailUserInfo.Gender = .female
            genderImageView.image = UIImage(named: RegisterGender.female.rawValue)
        case .female:
            detailUserInfo.Gender = .male
            genderImageView.image = UIImage(named: RegisterGender.male.rawValue)
        }
    }
    
    @IBAction func avatarTapped(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "从照片库选取", "用相机拍照", "取消")
        actionSheet.destructiveButtonIndex = 2
        actionSheet.showInView(self.view)
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        // 检查数据是否完善
        if let nickname = detailUserInfo.nickName {
        } else {
            alert("请输入昵称")
            return
        }
        if let province = detailUserInfo.Province {
        } else {
            alert("请选择所在地")
            return
        }
        if let avatar = detailUserInfo.ImageData {
        } else {
            alert("请上传您的头像")
            return
        }
        // 信息完善
//        @{@"user_name"       : [LCYGlobal sharedInstance].registerUserPhone,
//            @"password"        : [[LCYCommon sharedInstance] takePassword],
//            @"nick_name"       : self.nameTextField.text,
//            @"town"            : [NSNumber numberWithInteger:self.regionTown],
//            @"city"            : [NSNumber numberWithInteger:self.regionCity],
//            @"province"        : [NSNumber numberWithInteger:self.regionProvince],
//            //                                     @"city"            : [NSNumber numberWithInteger:self.regionResult],
//            @"sex"             : self.currentGender == RegisterDetailGenderMale ? @"0" : @"1",
//            @"Filedata"        : self.avatarData};
        let parameter = ["user_name": detailUserInfo.LoginName,
            "password": detailUserInfo.UserPassword,
            "nick_name": detailUserInfo.nickName,
            "town": detailUserInfo.Town?.region_id,
            "city": detailUserInfo.City?.region_id,
            "province": detailUserInfo.Province?.region_id,
            "sex": detailUserInfo.Gender == .male ? "0" : "1",
            "Filedata": detailUserInfo.ImageData
        ]
    }
    
}

extension RegisterDetailViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.tag == RegisterDetailTextFieldTag.region.rawValue {
            // 开启动画
            if !regionPickerShown {
                clearScreen()
                regionPickerShown = true
            }
            return false
        } else {
            clearScreen()
            return true
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == RegisterDetailTextFieldTag.name.rawValue {
            let newText = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
            detailUserInfo.nickName = newText
        }
        return true
    }
}

extension RegisterDetailViewController: RegionPickerViewControllerDelegate{
    func regionDoneButtonPressed(province: Region, city: Region, town: Region) {
        regionPickerShown = false
        detailUserInfo.Province = province
        detailUserInfo.City = city
        detailUserInfo.Town = town
        
        regionTextField.text = "\(province.region_name) \(city.region_name) \(town.region_name)"
    }
}

extension RegisterDetailViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            // 从照片库选择
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        case 1:
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
            // 从相机拍照
            break
        default:
            return
        }
    }
}

extension RegisterDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.showHUDWithTips("处理中")
        
        let smallImage = UIImage(image: info[UIImagePickerControllerOriginalImage] as UIImage, scaledToFillToSize: CGSize(width: 300, height: 300))
        detailUserInfo.ImageData = UIImagePNGRepresentation(smallImage)
        avatarImageView.image = smallImage
        
        // 处理上传之后，隐藏HUD
        self.hideHUD()
    }
}
