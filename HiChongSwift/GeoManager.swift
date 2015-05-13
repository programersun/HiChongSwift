//
//  GeoManager.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/5.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData

class GeoManager {
    typealias reverseSuccess = ((region: Region?) -> ())?
    func reverse(location: CLLocation, completionHandler: reverseSuccess) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (places, error) -> Void in
            if places != nil {
                if let place = places.first as? CLPlacemark {
                    
                    let city = place.locality.stringByReplacingOccurrencesOfString("市", withString: "", options: NSStringCompareOptions(0), range: nil)
                    
                    println("city ===> \(city)")
                    
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let context = appDelegate.managedObjectContext!
                    let fetchRequset = NSFetchRequest()
                    let entity = NSEntityDescription.entityForName("Region", inManagedObjectContext: context)
                    fetchRequset.entity = entity
                    let predicate = NSPredicate(format: "region_name == %@", argumentArray:[city])
                    fetchRequset.predicate = predicate
                    var error: NSError? = nil
                    let result = context.executeFetchRequest(fetchRequset, error: &error)
                    if let entities = result {
                        if let myRegion = entities.first as? Region {
                            if let success = completionHandler {
                                success(region: myRegion)
                            }
                        } else {
                            if let success = completionHandler {
                                success(region: nil)
                            }
                        }
                    } else {
                        if let success = completionHandler {
                            success(region: nil)
                        }
                    }
                } else {
                    if let success = completionHandler {
                        success(region: nil)
                    }
                }
            } else {
                if let success = completionHandler {
                    success(region: nil)
                }
            }
        })
    }
    
    func distanceTo(#latitude: Double, longitude: Double, myLocation: CLLocation) -> CLLocationDistance {
        let destination = CLLocation(latitude: latitude, longitude: longitude)
        return destination.distanceFromLocation(myLocation)
    }
}
