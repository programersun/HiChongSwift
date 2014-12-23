//
//  ColorExtension.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/9.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

extension UIColor {
    /**
    TabBar的背景色
    
    :returns: 颜色值UIColor
    */
    class func LCYTabBarBarTintColor() -> UIColor {
        return UIColor(white: 80.0/255.0, alpha: 1.0)
    }
    
    /**
    嗨宠主题浅蓝色
    
    :returns: 颜色值UIColor
    */
    class func LCYThemeColor() -> UIColor {
        return UIColor(red: 142.0/255.0, green: 197.0/255.0, blue: 223.0/255.0, alpha: 1.0)
    }
    
    /**
    嗨宠主题文字颜色（深蓝）
    
    :returns: 颜色值UIColor
    */
    class func LCYThemeDarkText() -> UIColor {
        return UIColor(red: 88.0/255.0, green: 158.0/255.0, blue: 190.0/255.0, alpha: 1.0)
    }
    
    /**
    嗨宠主题橘红色
    
    :returns: 颜色值UIColor
    */
    class func LCYThemeOrange() -> UIColor {
        return UIColor(red: 254.0/255.0, green: 148.0/255.0, blue: 127.0/255.0, alpha: 1.0)
    }
    
    /**
    列表区分颜色（浅蓝）
    
    :returns: 颜色值UIColor
    */
    class func LCYTableLightBlue() -> UIColor {
        return UIColor(red: 228.0/255.0, green: 247.0/255.0, blue: 254.0/255.0, alpha: 1.0)
    }
    
    /**
    列表区分颜色（浅灰）
    
    :returns: 颜色值UIColor
    */
    class func LCYTableLightGray() -> UIColor {
        return UIColor(white: 236.0/255.0, alpha: 1.0)
    }
}
