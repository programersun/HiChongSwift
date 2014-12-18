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
    
    class func identifier() -> String {
        return "LoginCodeCellIdentifier"
    }

    @IBOutlet private weak var icyTextField: UITextField!
    
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
        disableIcyButton()
    }
    
    private var timer: NSTimer?
    private func disableIcyButton() {
        icyButton.enabled = false
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerFired:", userInfo: nil, repeats: true)
    }

    private let totalCountDown = 10 // 倒数计时秒数
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
