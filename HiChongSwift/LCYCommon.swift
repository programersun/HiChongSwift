//
//  LCYCommon.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import Foundation

class LCYCommon {
    class var sharedInstance: LCYCommon {
        struct Singleton {
            static let instance = LCYCommon()
        }
        return Singleton.instance
    }

    let rightButtonSize = CGSize(width: 50.0, height: 24.0)
    
}