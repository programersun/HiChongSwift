//
//  LCYNetworking.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/4.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//


enum LCYApi : String {
    case SquareGetSquareCategory = "Square/getSquareCategory"
}

class LCYNetworking {
    private let hostURL = "http://123.57.7.88/admin/index.php/Api/"
    class var sharedInstance: LCYNetworking {
        struct Singleton {
            static let instance = LCYNetworking()
        }
        return Singleton.instance
    }
    
    func POST(Api: LCYApi, parameters: NSDictionary!, success: ((object: NSDictionary) -> Void)?, failure: ((error: NSError!)->Void)?) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html", "text/plain")
        let absoluteURL = hostURL + Api.rawValue
        manager.POST(absoluteURL, parameters: parameters, success: { (operation, object) -> Void in
            println("success in \"\(Api.rawValue)\" ====> \(operation.responseString)")
            if let unwrappedSuccess = success {
                unwrappedSuccess(object: object as NSDictionary)
            }
        }) { (operation, error) -> Void in
            println("error \(error)")
            if let unwrappedFailure = failure {
                unwrappedFailure(error: error)
            }
        }
    }
}