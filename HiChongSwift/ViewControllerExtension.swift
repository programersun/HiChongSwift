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
}
