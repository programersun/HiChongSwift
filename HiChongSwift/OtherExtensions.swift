//
//  OtherExtensions.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import Foundation

extension UIImageView {
    func roundCorner() {
        let radius = min(self.bounds.width, self.bounds.height) / 2.0
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
}
