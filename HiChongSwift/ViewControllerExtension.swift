//
//  ViewControllerExtension.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/11.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

extension UIViewController{
    
    func showHUDWithTips(tips: String) {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = tips
    }
    
    func showHUD() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    }
    
    func hideHUD() {
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    func screenWidth() -> CGFloat {
        return UIScreen.mainScreen().bounds.width
    }
    
    func addRightButton(buttonTitle: String, action: Selector) {
        let doneButton = UIButton(frame: CGRect(origin: CGPointZero, size: LCYCommon.sharedInstance.rightButtonSize))
        doneButton.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        doneButton.backgroundColor = UIColor.LCYThemeDarkText()
        let doneString = NSAttributedString(string: buttonTitle, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(12.0)])
        doneButton.setAttributedTitle(doneString, forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        doneButton.layer.cornerRadius = 4.0
        let rightItem = UIBarButtonItem(customView: doneButton)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func alert(message: String) {
        let alert = UIAlertView(title: nil, message: message, delegate: nil, cancelButtonTitle: "确定")
        alert.show()
    }
    
    func alertWithDelegate(message: String, tag: Int, delegate: UIAlertViewDelegate?) {
        let alert = UIAlertView(title: nil, message: message, delegate: delegate, cancelButtonTitle: "确定")
        alert.tag = tag
        alert.show()
    }
}
