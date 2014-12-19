//
//  LoginInputCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/18.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

enum LoginInputCellType {
    case PhoneNumber
    case Password
}

class LoginInputCell: UITableViewCell {
    
    @IBOutlet private weak var icyImageView: UIImageView!
    
    @IBOutlet private weak var icyTextField: UITextField!
    
    weak var delegate: LoginInputCellDelegate?
    
    var icyCellType: LoginInputCellType = .PhoneNumber {
        didSet {
            switch icyCellType {
            case .PhoneNumber:
                icyImageView.image = UIImage(named: "LoginPhone")
                self.icyTextField.keyboardType = UIKeyboardType.NumberPad
                self.icyTextField.secureTextEntry = false
                self.icyTextField.placeholder = "请输入您的手机号"
            case .Password:
                icyImageView.image = UIImage(named: "LoginPassword")
                self.icyTextField.keyboardType = UIKeyboardType.ASCIICapable
                self.icyTextField.secureTextEntry = true
                self.icyTextField.placeholder = "请输入6到18位的密码"
            }
            icyTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        }
    }
    
    class func identifier() -> String {
        return "LoginInputCellIdentifier"
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.LCYThemeColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension LoginInputCell: UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        delegate?.loginInputDidEndEditing(icyCellType, text: textField.text)
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        delegate?.loginInputDidEndEditing(icyCellType, text: textField.text)
        return true
    }
}

protocol LoginInputCellDelegate: class {
    func loginInputDidEndEditing(cellType: LoginInputCellType, text: String)
}
