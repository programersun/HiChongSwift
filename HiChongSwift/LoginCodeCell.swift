//
//  LoginCodeCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/18.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class LoginCodeCell: UITableViewCell {
    
    @IBOutlet private weak var icyButton: UIButton!
    
    var isReset: Bool = false
    
    class func identifier() -> String {
        return "LoginCodeCellIdentifier"
    }
    
    weak var delegate: LoginCodeCellDelegate?
    
    @IBOutlet weak var icyTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.LCYThemeColor()
        
        icyButton.setBackgroundImage(UIImage(named: "LoginButtonNormal")?.resizableImageWithCapInsets(UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)), forState: UIControlState.Normal)
        icyButton.setBackgroundImage(UIImage(named: "LoginButtonDisabled")?.resizableImageWithCapInsets(UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)), forState: UIControlState.Disabled)
        icyButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        icyTextField.placeholder = "四位验证码"
        icyTextField.keyboardType = UIKeyboardType.NumberPad
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func icyButtonPressed(sender: AnyObject) {
        let phoneNumber = delegate?.loginCodeCellNeedPhoneNumber()
        if let phone = phoneNumber {
            // 电话号码存在，请求发送
            disableIcyButton()
            let parameter = ["user_name": phone]
            if !isReset {
                LCYNetworking.sharedInstance.POST(LCYApi.UserAuthcode, parameters: parameter, success: {[weak self] (object) -> Void in
                    if object["result"] as! Bool {
                        self?.delegate?.loginCodeCellGetGode((object["code"] as! Int).description)
                    } else {
                        self?.delegate?.loginCodeCellFailCode(object["msg"] as! String)
                    }
                    return
                    }, failure: { (error) -> Void in
                        return
                })
            } else {
                LCYNetworking.sharedInstance.POST(LCYApi.UserResetPasswordAuthcode, parameters: parameter, success: { [weak self](object) -> Void in
                    if object["result"] as! Bool {
                        self?.delegate?.loginCodeCellGetGode((object["code"] as! Int).description)
                    } else {
                        self?.delegate?.loginCodeCellFailCode(object["msg"] as! String)
                    }
                }, failure: { (error) -> Void in
                    return
                })
            }
        } else {
            return
        }
    }
    
    private var timer: NSTimer?
    private func disableIcyButton() {
        icyButton.enabled = false
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerFired:", userInfo: nil, repeats: true)
    }
    
    private let totalCountDown = 20 // 倒数计时秒数
    private var countDown: Int?
    func timerFired(sender: NSTimer) {
        if countDown != nil {
            if countDown! <= 0 {
                sender.invalidate()
                countDown = nil
                icyButton.enabled = true
                icyButton.setTitle("发送验证码", forState: UIControlState.Normal)
                icyButton.setTitle("发送验证码", forState: UIControlState.Disabled)
            } else {
                countDown!--
                icyButton.setTitle("(\(countDown!))秒重发", forState: UIControlState.Disabled)
            }
        } else {
            countDown = totalCountDown
            icyButton.setTitle("(\(countDown!))秒重发", forState: UIControlState.Disabled)
        }
    }
}

protocol LoginCodeCellDelegate: class {
    func loginCodeCellNeedPhoneNumber() -> NSString?
    func loginCodeCellGetGode(code: String)
    func loginCodeCellInputCode(code: String)
    func loginCodeCellFailCode(masage: String)
}

extension LoginCodeCell: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        delegate?.loginCodeCellInputCode(newText)
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        delegate?.loginCodeCellInputCode(textField.text)
    }
}