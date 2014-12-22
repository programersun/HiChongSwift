//
//  Region.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/22.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import Foundation
import CoreData

@objc(Region)

class Region: NSManagedObject {

    @NSManaged var agency_id: NSNumber
    @NSManaged var parent_id: NSNumber
    @NSManaged var region_id: NSNumber
    @NSManaged var region_name: String
    @NSManaged var region_type: NSNumber

}
