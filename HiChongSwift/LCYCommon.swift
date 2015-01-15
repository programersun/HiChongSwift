//
//  LCYCommon.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import Foundation
import CoreLocation

class LCYCommon: NSObject {
    private enum UserDefaultKeys: String {
        case kWelcomeGuideSkip = "kWelcomeGuideSkip"
        case kUserLogin = "kUserLogin"
        case kUserName = "kUserName"
        case kUserPhone = "kUserPhone"
        
        /// 纪录所在城市id
        case kRegionID = "kRegionID"
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
    
    var circleSepratorImage: UIImage? {
        return UIImage(named: "circleSeprator")?.resizableImageWithCapInsets(UIEdgeInsets(top: 0.0, left: 60.0, bottom: 0.0, right: 60.0))
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
    
    /**
    登录账号
    
    :param: userName 账户名（id，不是电话号码哦）
    */
    func login(userName: String, phoneNumber: String?) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(userName, forKey: UserDefaultKeys.kUserName.rawValue)
        userDefault.setObject(phoneNumber, forKey: UserDefaultKeys.kUserPhone.rawValue)
        userDefault.setBool(true, forKey: UserDefaultKeys.kUserLogin.rawValue)
        userDefault.synchronize()
    }
    
    /// 用户名（需要先验证用户是否已经登录）
    var userName: String? {
        get {
            let userDefault = NSUserDefaults.standardUserDefaults()
            let name = userDefault.objectForKey(UserDefaultKeys.kUserName.rawValue) as String?
            return name
        }
    }
    
    var userPhone: String? {
        get {
            let userDefault = NSUserDefaults.standardUserDefaults()
            let phone = userDefault.objectForKey(UserDefaultKeys.kUserPhone.rawValue) as String?
            return phone
        }
    }
    
    /**
    登出账号并且切换界面
    */
    func logout() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setBool(false, forKey: UserDefaultKeys.kUserLogin.rawValue)
        userDefault.synchronize()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as UIViewController
        appDelegate.window?.rootViewController = loginVC
    }
    
    typealias locationSuccess = (location: CLLocation) -> Void
    typealias locationFail = () -> Void
    private var locationSuccessBlock: locationSuccess?
    private var locationFailBlock: locationFail?
    private var location: CLLocation?
    private var locationManager: CLLocationManager?
    private var successCalled: Bool = false
    func getLocation(success: locationSuccess? , fail: locationFail?) {
        successCalled = false
        if let myLocation = location {
            if let usuccess = success {
                usuccess(location: myLocation)
            }
            return
        }
        locationSuccessBlock = success
        locationFailBlock = fail
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            if locationManager!.respondsToSelector("requestWhenInUseAuthorization") {
                locationManager!.requestWhenInUseAuthorization()
            }
            locationManager!.startUpdatingLocation()
        } else {
            if let ufail = fail {
                ufail()
            }
        }
    }
    
    var regionID: String? {
        get {
            let userDefault = NSUserDefaults.standardUserDefaults()
            let regionID = userDefault.objectForKey(UserDefaultKeys.kRegionID.rawValue) as String?
            return regionID
        }
        set {
            let userDefault = NSUserDefaults.standardUserDefaults()
            userDefault.setObject(newValue, forKey: UserDefaultKeys.kRegionID.rawValue)
        }
    }
}

extension LCYCommon: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = (locations.first as? CLLocation) {
            manager.stopUpdatingLocation()
            if let usuccess = locationSuccessBlock {
                if !successCalled {
                    successCalled = true
                    usuccess(location: location)
                }
            }
//            self.location = location.coordinate
        } else {
            if let ufail = locationFailBlock {
                ufail()
            }
        }
    }
}
