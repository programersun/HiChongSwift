//
//  ZXY_UserConstantFile.swift
//  HiChongSwift
//
//  Created by 宇周 on 15/3/6.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import Foundation
import UIKit
class ZXY_UserConstantFile
{
    class var cityIDForSqure : String?
    {
        get{
            var currentCityID : String? = NSUserDefaults.standardUserDefaults().valueForKey("zxy_location") as? String
            return currentCityID
        }
        
        set
        {
            if (newValue != nil)
            {
                NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "zxy_location")
            }
        }
    }
    
    class var cityNameForSqure : String?
        {
        get{
            var currentCityName : String? = NSUserDefaults.standardUserDefaults().valueForKey("zxy_name") as? String
            return currentCityName
        }
        
        set
    {
        if (newValue != nil)
        {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "zxy_name")
        }
        }
    }
}