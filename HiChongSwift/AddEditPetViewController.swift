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
    
    enum AddPetGender {
        case Male
        case Female
    }
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var tagTextBackView: UIView!
    @IBOutlet private weak var tagTextLabel: UILabel!
    
    
    @IBOutlet private var roundedViews: [UIView]!
    
    @IBOutlet private weak var genderImageView: UIImageView!
    var viewControllerType: AddEditPetVCType = .Add
    
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
    private var age: Int?
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
    // 是否绑定
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        switch viewControllerType {
        case .Add:
            navigationItem.title = "添加宠物"
            addRightButton("确定", action: "addConfirmButtonPressed:")
        case .Edit:
            navigationItem.title = "编辑宠物"
        }
        
        contentView.backgroundColor = UIColor.LCYThemeColor()
        view.backgroundColor = UIColor.LCYThemeColor()
        
        for roundView in roundedViews {
            roundView.layer.cornerRadius = 4.0
        }
        
        tagTextBackView.backgroundColor = UIColor.LCYTableLightBlue()
        
        tagTextLabel.textColor = UIColor.LCYThemeOrange()
        
        avatarImage = nil
        
        containerHeightConstraint.constant = 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func addConfirmButtonPressed(sender: AnyObject) {
        
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
    }
    
    @IBAction func avatarImageTapped(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "我要拍照", "从照片库选取", "取消")
        actionSheet.destructiveButtonIndex = 2
        actionSheet.showInView(self.view)
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
        switch age {
        case 0:
            ageLabel.text = "小于1岁"
        case 11:
            ageLabel.text = "大于10岁"
        default:
            ageLabel.text = "\(age)岁"
        }
        ageShown = false
    }
}
