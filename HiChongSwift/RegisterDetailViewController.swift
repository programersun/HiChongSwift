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
        var Gender: RegisterGender = .male {
            didSet {
                self.genderImageView.image = UIImage(named: Gender.rawValue)
            }
        }
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
        case .female:
            detailUserInfo.Gender = .male
        }
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
