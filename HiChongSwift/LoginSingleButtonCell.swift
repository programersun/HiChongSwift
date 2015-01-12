//
//  LoginSingleButtonCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/18.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

enum LoginSingleButtonCellType {
    case Login
    case Register
    case Forget
}

class LoginSingleButtonCell: UITableViewCell {
    
    var currentType: LoginSingleButtonCellType = .Login {
        didSet {
            switch currentType {
            case .Login:
                icyButton.setTitle("登录", forState: UIControlState.Normal)
            case .Register:
                icyButton.setTitle("注册", forState: UIControlState.Normal)
            case .Forget:
                icyButton.setTitle("保存", forState: UIControlState.Normal)
            }
        }
    }
    
    @IBOutlet private weak var icyButton: UIButton!
    class func identifier() -> String {
        return "LoginSingleButtonCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.LCYThemeColor()
        icyButton.setBackgroundImage(UIImage(named: "LoginButtonNormal")?.resizableImageWithCapInsets(UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)), forState: UIControlState.Normal)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    weak var delegate: LoginSingleButtonCellDelegate?
    @IBAction func buttonPressed(sender: AnyObject) {
        delegate?.loginSingleButtonDidPressed(currentType)
    }
    
}

protocol LoginSingleButtonCellDelegate: class {
    func loginSingleButtonDidPressed(buttonType: LoginSingleButtonCellType)
}
