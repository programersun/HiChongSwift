//
//  AddEditPetViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/24.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class AddEditPetViewController: UIViewController {
    
    enum AddEditPetVCType {
        case Add
        case Edit
    }
    
    enum AddPetGender: String {
        case Male       = "0"
        case Female     = "1"
    }
    
    @IBOutlet weak var breedingImageView: UIImageView!
    @IBOutlet weak var adoptImageView: UIImageView!
    @IBOutlet weak var fosterImageView: UIImageView!
    
    weak var delegate: AddPetDelegate?
    
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var tagTextBackView: UIView!
    @IBOutlet private weak var tagTextLabel: UILabel!
    
    @IBOutlet weak var qrImageView: UIImageView!
    
    @IBOutlet private var roundedViews: [UIView]!
    
    @IBOutlet private weak var genderImageView: UIImageView!
    
    var viewControllerType: AddEditPetVCType = .Add
    var startInfo: LCYPetDetailBase?
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    private var ageShown: Bool = false {
        didSet {
            if oldValue != ageShown {
                if !ageShown {
                    containerHeightConstraint.constant = 0.0
                    UIView.animateWithDuration(0.25, animations: { [weak self] () -> Void in
                        self?.view.layoutIfNeeded()
                        return
                    })
                } else {
                    containerHeightConstraint.constant = 206.0
                    UIView.animateWithDuration(0.25, animations: { [weak self] () -> Void in
                        self?.view.layoutIfNeeded()
                        return
                    })
                }
            }
        }
    }
    
    // MARK: - 宠物数据
    // 头像
    private var avatarImage: UIImage? {
        didSet {
            if let uImage = avatarImage {
                avatarImageView.contentMode = .ScaleAspectFill
                avatarImageView.image = uImage
            } else {
                avatarImageView.contentMode = .Center
                avatarImageView.image = UIImage(named: "bigCamera")
            }
        }
    }
    private enum avatarUploadStatus {
        case None
        case Uploading
        case Failed
        case Success
    }
    private var avatarBeingUploading: avatarUploadStatus = .None
    private var avatarSaveName: String?
    // 昵称
    @IBOutlet private weak var petNameTextField: UITextField!
    // 性别
    private var petSex: AddPetGender = .Male {
        didSet {
            switch petSex {
            case .Female:
                genderImageView.image = UIImage(named: "sqFemale")
            case .Male:
                genderImageView.image = UIImage(named: "sqMale")
            }
        }
    }
    @IBAction private func genderButtonPressed(sender: AnyObject) {
        switch petSex {
        case .Male:
            petSex = .Female
        case .Female:
            petSex = .Male
        }
    }
    // 品种
    @IBOutlet private weak var petCateTextField: UITextField!
    private var category: LCYPetSubTypeChildStyle? {
        didSet{
            if let ucat = category {
                petCateTextField.text = ucat.name
            } else {
                petCateTextField.text = ""
            }
        }
    }
    // 年龄
    private var age: Int = 0 {
        didSet {
            switch age {
            case 0:
                ageLabel.text = "小于1岁"
            case 11:
                ageLabel.text = "大于10岁"
            default:
                ageLabel.text = "\(age)岁"
            }
        }
    }
    @IBOutlet private weak var ageLabel: UILabel!
    // 签名
    @IBOutlet private weak var signTextField: UITextField!
    // 三大状态
    private struct addEditStatus {
        var breeding: Bool = false
        var adopt   : Bool = false
        var entrust : Bool = false
    }
    private var status = addEditStatus()
    
    // 二维码
    private var QRCode: String? {
        didSet {
            if let code = QRCode {
                if countElements(code) != 0 {
                    bindSwitch.enabled = true
                    qrImageView.image = UIImage(named: "qrDuostec")
                } else {
                    bindSwitch.enabled = false
                }
            } else {
                bindSwitch.enabled = false
            }
        }
    }
    // 是否绑定
    @IBOutlet weak var bindSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        avatarImage = nil
        
        switch viewControllerType {
        case .Add:
            navigationItem.title = "添加宠物"
            addRightButton("确定", action: "addConfirmButtonPressed:")
        case .Edit:
            navigationItem.title = "编辑宠物"
            addRightButton("确定", action: "editConfirmButtonPressed:")
            loadStartInfo()
        }
        
        contentView.backgroundColor = UIColor.LCYThemeColor()
        view.backgroundColor = UIColor.LCYThemeColor()
        
        for roundView in roundedViews {
            roundView.layer.cornerRadius = 4.0
        }
        
        tagTextBackView.backgroundColor = UIColor.LCYTableLightBlue()
        
        tagTextLabel.textColor = UIColor.LCYThemeOrange()
        
        
        containerHeightConstraint.constant = 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    private func loadStartInfo() {
        if let info = startInfo {
            // 头像
            avatarImageView.contentMode = .ScaleAspectFill
            avatarImageView.setImageWithURL(NSURL(string: info.petInfo.headImage.toAbsolutePath()))
            // 昵称
            petNameTextField.text = info.petInfo.petName
            // 性别
            petSex = info.petInfo.petSex == "0" ? .Male : .Female
            // 品种
            petCateTextField.text = info.petInfo.cateName
            // 年龄
            if let petAge = info.petInfo.age.toInt() {
                age = petAge
            }
            // 签名
            signTextField.text = info.petInfo.sign
            // 三大状态
            status.breeding = (info.petInfo.fHybridization == "1")
            status.adopt = (info.petInfo.fAdopt == "1")
            status.entrust = (info.petInfo.isEntrust == "1")
            if status.breeding {
                breedingImageView.image = UIImage(named: "breedingDown")
                
            } else {
                breedingImageView.image = UIImage(named: "breedingButton")
            }
            if status.adopt {
                adoptImageView.image = UIImage(named: "adoptDown")
                
            } else {
                adoptImageView.image = UIImage(named: "adoptButton")
            }
            if status.entrust {
                fosterImageView.image = UIImage(named: "fosterDown")
                
            } else {
                fosterImageView.image = UIImage(named: "fosterButton")
            }
            // 二维码
            QRCode = info.petInfo.petCode
        }
    }
    func editConfirmButtonPressed(sender: AnyObject) {
        if let info = startInfo {
            // 昵称
            let text = petNameTextField.text
            if countElements(text) <= 0 {
                alert("请输入宠物昵称")
                return
            }
            // 二维码
            var myQR: String!
            if bindSwitch.enabled && bindSwitch.on {
                if let qr = QRCode {
                    myQR = qr
                } else {
                    myQR = ""
                }
            } else {
                myQR = ""
            }
            // 类型
            var parameters: [String: String]!
            if let ucategory = category {
                parameters = [
                    "pet_id"       :info.petInfo.petId,
                    "pet_name"      : petNameTextField.text,
                    "cat_id"        : ucategory.catId,
                    "sex"           : petSex.rawValue,
                    "age"           : "\(age)",
                    "tip"           : signTextField.text,
                    "f_hybridization": status.breeding ? "1" : "0",
                    "f_adopt"       : status.adopt ? "1" : "0",
                    "is_entrust"    : status.entrust ? "1" : "0",
                    "pet_code"      : myQR,
                ]
            } else {
                parameters = [
                    "pet_id"       :info.petInfo.petId,
                    "pet_name"      : petNameTextField.text,
                    "sex"           : petSex.rawValue,
                    "age"           : "\(age)",
                    "tip"           : signTextField.text,
                    "f_hybridization": status.breeding ? "1" : "0",
                    "f_adopt"       : status.adopt ? "1" : "0",
                    "is_entrust"    : status.entrust ? "1" : "0",
                    "pet_code"      : myQR,
                ]
            }
            showHUD()
            LCYNetworking.sharedInstance.POST(LCYApi.PetUpdatePetInfo, parameters: parameters, success: { [weak self](object) -> Void in
                self?.hideHUD()
                if let result = object["result"]?.boolValue {
                    if result {
                        self?.alertWithDelegate("修改成功", tag: 4000, delegate: self)
                    } else {
                        self?.alert("修改失败")
                    }
                } else {
                    self?.alert("修改失败")
                }
            }, failure: { [weak self](error) -> Void in
                self?.hideHUD()
                self?.alert("修改失败，请检查您的网络状态")
                return
            })
        }
    }
    
    func addConfirmButtonPressed(sender: AnyObject) {
        // 头像
        switch avatarBeingUploading {
        case .None:
            alert("请上传头像")
            return
        case .Uploading:
            alert("请等待头像上传成功")
            return
        case .Failed:
            alert("头像上传失败，请重新上传")
            return
        case .Success:
            break
        }
        
        // 昵称
        let text = petNameTextField.text
        if countElements(text) <= 0 {
            alert("请输入宠物昵称")
            return
        }
        // 类型
        if let ucategory = category {
        } else {
            alert("请选择宠物品种")
            return
        }
        
        var myQR: String!
        if bindSwitch.enabled && bindSwitch.on {
            if let qr = QRCode {
                myQR = qr
            } else {
                myQR = ""
            }
        } else {
            myQR = ""
        }
        let parameters: [String: String] = [
            "user_id"       : LCYCommon.sharedInstance.userName!,
            "pet_name"      : petNameTextField.text,
            "cat_id"        : category!.catId,
            "sex"           : petSex.rawValue,
            "age"           : "\(age)",
            "tip"           : signTextField.text,
            "f_hybridization": status.breeding ? "1" : "0",
            "f_adopt"       : status.adopt ? "1" : "0",
            "is_entrust"    : status.entrust ? "1" : "0",
            "pet_code"      : myQR,
            "image"         : avatarSaveName!
        ]
        showHUDWithTips("正在上传宠物信息")
        LCYNetworking.sharedInstance.POST(LCYApi.PetAdd, parameters: parameters, success: { [weak self](object) -> Void in
            self?.hideHUD()
            if let result = object["result"]?.boolValue {
                if result {
                    self?.alertWithDelegate("上传成功", tag: 3003, delegate: self)
                } else {
                    self?.alert("上传失败")
                }
            } else {
                self?.alert("上传失败")
            }
            
            return
            }) { [weak self](error) -> Void in
                self?.hideHUD()
                self?.alert("上传失败，请检查您的网络状态")
                return
        }
        
    }
    @IBAction func ageButtonPressed(sender: AnyObject) {
        ageShown = true
    }
    
    @IBAction func statusButtonPressed(sender: UITapGestureRecognizer) {
        if let tappedView = (sender.view as? UIImageView){
            switch tappedView.tag {
            case 1:
                if status.breeding {
                    status.breeding = false
                    tappedView.image = UIImage(named: "breedingButton")
                } else {
                    status.breeding = true
                    tappedView.image = UIImage(named: "breedingDown")
                }
            case 2:
                if status.adopt {
                    status.adopt = false
                    tappedView.image = UIImage(named: "adoptButton")
                } else {
                    status.adopt = true
                    tappedView.image = UIImage(named: "adoptDown")
                }
            case 3:
                if status.entrust {
                    status.entrust = false
                    tappedView.image = UIImage(named: "fosterButton")
                } else {
                    status.entrust = true
                    tappedView.image = UIImage(named: "fosterDown")
                }
            default:
                break
            }
        }
    }
    
    @IBAction func qrImageTapped(sender: AnyObject) {
        performSegueWithIdentifier("presentScan", sender: nil)
    }
    
    @IBAction func avatarImageTapped(sender: AnyObject) {
        switch viewControllerType {
        case .Add:
            let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "我要拍照", "从照片库选取", "取消")
            actionSheet.destructiveButtonIndex = 2
            actionSheet.showInView(self.view)
        case .Edit:
            alert("修改头像功能即将开放，敬请期待")
        }
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "container":
                let destination = segue.destinationViewController as AgePickerViewController
                destination.delegate = self
            case "presentScan":
                let destination = segue.destinationViewController as QRScanViewController
                destination.delegate = self
            default:
                break
            }
        }
    }
    
}

extension AddEditPetViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            // 从照片库选择
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            presentViewController(imagePicker, animated: true, completion: nil)
        case 0:
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(imagePicker, animated: true, completion: nil)
            // 从相机拍照
            break
        default:
            return
        }
    }
}

extension AddEditPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        view.setNeedsLayout()
        showHUDWithTips("处理中")
        
        let smallImage = UIImage(image: info[UIImagePickerControllerOriginalImage] as UIImage, scaledToFillToSize: CGSize(width: 300, height: 300))
        avatarImage = smallImage
        
        // 处理上传之后，隐藏HUD
        hideHUD()
        
        // 上传照片
        avatarBeingUploading = .Uploading
        let data = UIImagePNGRepresentation(smallImage)
        LCYNetworking.sharedInstance.POSTCommonFile("Filedata", fileData: data, fileName: "tiancailcy.png", mimeType: LCYMimeType.PNG, success: { [weak self] (object) -> Void in
            let resultInfo = CommonUploadBase.modelObjectWithDictionary(object)
            if resultInfo.result {
                self?.avatarSaveName = (resultInfo.images[0] as CommonUploadImages).savename
                self?.avatarBeingUploading = .Success
            } else {
                self?.avatarBeingUploading = .Failed
            }
            return
            }) { [weak self](error) -> Void in
                self?.avatarBeingUploading = .Failed
                return
        }
    }
}

extension AddEditPetViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == petCateTextField {
            // 开始分类筛选
            let storyBoard = UIStoryboard(name: "PetCateFilter", bundle: nil)
            let destination = storyBoard.instantiateInitialViewController() as PetCateFilterViewController
            destination.delegate = self
            destination.root = self
            navigationController?.pushViewController(destination, animated: true)
            return false
        }
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddEditPetViewController: PetCateFilterDelegate {
    func didSelectCategory(childCategory: LCYPetSubTypeChildStyle) {
        category = childCategory
    }
}

extension AddEditPetViewController: AgePickerDelegate {
    func agePickerDidPick(age: Int) {
        self.age = age
        ageShown = false
    }
}

extension AddEditPetViewController: QRScanDelegate {
    func QRCodeDidScan(info: String) {
        QRCode = info
    }
}

extension AddEditPetViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 3003 {
            // 添加成功
            delegate?.addPetDone()
            navigationController?.popToRootViewControllerAnimated(true)
        } else if alertView.tag == 4000 {
            // 修改成功
            navigationController?.popToRootViewControllerAnimated(true)
        }
    }
}

protocol AddPetDelegate: class {
    func addPetDone()
}
