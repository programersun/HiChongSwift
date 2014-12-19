//
//  LCYCommon.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import Foundation

class LCYCommon {
    private enum UserDefaultKeys: String {
        case kWelcomeGuideSkip = "kWelcomeGuideSkip"
        case kUserLogin = "kUserLogin"
        case kUserName = "kUserName"
    }
    
    class var sharedInstance: LCYCommon {
        struct Singleton {
            static let instance = LCYCommon()
        }
        return Singleton.instance
    }

    let rightButtonSize = CGSize(width: 50.0, height: 24.0)
    
    var artSepratorImage: UIImage? {
        get {
            return UIImage(named: "artSeprator")?.resizableImageWithCapInsets(UIEdgeInsets(top: 0.0, left: 60.0, bottom: 0.0, right: 60.0))
        }
    }
    

    /* 通过查看welcomeGuide的值判断是否需要展示引导图
    // 返回true表示不需要展示
    // 返回false表示需要展示
    // 通过设置welcomeGuide的值可以修改此状态
    /// */
     var welcomeGuide: Bool {
        get {
            let userDefault = NSUserDefaults.standardUserDefaults()

            if let unwrapped: AnyObject = userDefault.objectForKey(UserDefaultKeys.kWelcomeGuideSkip.rawValue) {
                if (unwrapped.boolValue != nil) && (unwrapped.boolValue!) {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        }
        set {
            let userDefault = NSUserDefaults.standardUserDefaults()
            if newValue {
                userDefault.setBool(newValue, forKey: UserDefaultKeys.kWelcomeGuideSkip.rawValue)
                userDefault.synchronize()
            }
        }
    }
    
    /// 用户登录后会返回true
    var userLogin: Bool {
        get {
            let userDefault = NSUserDefaults.standardUserDefaults()
            if let unwrapped: AnyObject = userDefault.objectForKey(UserDefaultKeys.kUserLogin.rawValue) {
                if unwrapped.boolValue! {
                    if let userName: AnyObject = userDefault.objectForKey(UserDefaultKeys.kUserName.rawValue) {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            } else {
                return false
            }
        }
    }
    
    func login(userName: String) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(userName, forKey: UserDefaultKeys.kUserName.rawValue)
        userDefault.setBool(true, forKey: UserDefaultKeys.kUserLogin.rawValue)
        userDefault.synchronize()
    }
}
