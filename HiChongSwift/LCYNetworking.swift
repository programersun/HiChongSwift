//
//  LCYNetworking.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/4.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//


enum LCYApi: String {
    case TwitterAdd                 = "Twitter/twitter_add"
    case TwitterList                = "Twitter/twitter_list"
    case TwitterKeeperInfo          = "Twitter/keeper_info"
    case twitterPersonal            = "Twitter/twitter_personal"
    case TwitterStar                = "Twitter/twitter_star"
    case TwitterCommentList         = "Twitter/twitter_comment_list"
    case TwitterCommentAdd          = "Twitter/twitter_comment_add"
    case TwitterStarDel             = "Twitter/twitter_star_del"
    
    case SquareGetSquareCategory    = "Square/getSquareCategory" /// Deprecated
    case SquareHome                 = "Square/home"
    case SquaregetSquareList        = "Square/getSquareList"
    case SquareMerchantInfo         = "Square/merchant_info"
    case SquareCommentAdd           = "Square/comment_add"
    case SquareCommentList          = "Square/comment_list"
    
    case UserLogin                  = "User/login"
    case UserAuthcode               = "User/register_authcode"
    case UserRegister               = "User/register"
    case UserGetInfo                = "User/getUserInfoByID"
    case UserModifySingle           = "User/modifySingleProperty"
    case UserModifyLocation         = "User/modifyLocation"
    case UserModifyInfo             = "User/modifyInfo"
    case UserChangeLocation         = "User/changeLocation"
    case UserAttention              = "User/attention"
    case UserFansList               = "User/fans_list"
    case UserFriendList             = "User/friend_list"
    case UserSearchFriend           = "User/search_friend"
    case UserSearchFriend2          = "User/search_friend2"
    case UserResetPasswordAuthcode  = "User/reset_password_authcode"
    case UserSetPassword            = "User/setPassword"
    case UserModifyBackgroundImage  = "User/modifyBackgroundImage"
    case UserModifyImage            = "User/modifyImage"
    
    case PetGetDetail               = "Pet/GetPetDetailByID"
    case PetAllType                 = "PetStyle/searchAllTypePets"
    case PetSubType                 = "PetStyle/searchDetailByID"
    case PetAdd                     = "Pet/petAdd"
    case PetUpdatePetInfo           = "Pet/updatePetInfo"
    case PetUploadPetImage          = "Pet/UploadPetImage"
    
    case WikiToday                  = "Ency/getTodayEncy"
    case WikiIsCollect              = "Ency/is_collect"
    case WikiCollect                = "Ency/setCollect"
    case WikiCollectList            = "Ency/getCollectArticle"
    case WikiMore                   = "Ency/searchEncy"
    case WikiGetAD                  = "/Ency/getAd"
}

enum LCYMimeType: String {
    case PNG                        = "image/png"
    case JPEG                       = "image/jpeg"
}

class LCYNetworking {
    private let hostURL = "http://123.57.7.88/admin/index.php/Api/"
    private let commonURL = "http://123.57.7.88/admin/index.php/Common/Upload/ios"
    private let ArticleHTMLComponent = "Ency/ency_article/ency_id/"
    private let WikiHtmlComponent = "Ency/category_article/cate_id/"
    
    /**
    百度地图ak，由开发者 icylydia 提供
    */
    private let BaiduAK = "0G8SXbO2PwwGRLTzsIMj0dxi"
    
    /**
    大众点评，由开发者 icylydia 提供
    */
    private let DianpingHost = "http://api.dianping.com/v1/business/find_businesses"
    private let DianpingAppKey = "0900420225"
    private let DianpingAppSecret = "c3385423913745e992079187dc08d33d"
    
    private enum RequestType {
        case GET
        case POST
    }
    
    class var sharedInstance: LCYNetworking {
        struct Singleton {
            static let instance = LCYNetworking()
        }
        return Singleton.instance
    }
    
    func Dianping(parameters: [String: String], success: ((object: NSDictionary) -> ())?, failure: ((error: NSError) -> ())?) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        var mutpara = parameters
        mutpara.extend(["platform": "2"])
        
        let keys = sorted(mutpara.keys)
        
        let signStringA = reduce(keys, DianpingAppKey) { (prefix, element) -> String in
            prefix + element + mutpara[element]!
        }
        let signStringB = signStringA + DianpingAppSecret
        
        let sign = signStringB.SHA_1()
        
        mutpara.extend(["appkey": DianpingAppKey, "sign": sign])
        
        println("request 大众点评 with parameters: \(mutpara)")
        
        manager.GET(DianpingHost, parameters: mutpara, success: { (operation, object) -> Void in
            println("success in dianping ====> \(operation.responseString)")
            if let unwrappedSuccess = success {
                unwrappedSuccess(object: object as NSDictionary)
            }
        }) { (operation, error) -> Void in
            println("error \(error)")
            println("\(operation.responseString)")
            if let unwrappedFailure = failure {
                unwrappedFailure(error: error)
            }
        }
    }
    
    func POSTAndGET(Api: LCYApi, GETParameters: [String: String]?, POSTParameters: NSDictionary!, success: ((object: NSDictionary) -> Void)?, failure: ((error: NSError!)->Void)?) {
        var URLString = Api.rawValue
        if let get = GETParameters {
            URLString += "?"
            URLString += reduce(get.keys, "", {
                $0 + $1 + "=" + get[$1]! + "&"
            })
            requestWith(.POST, Api: URLString, parameters: POSTParameters, success: success, failure: failure)
        } else {
            if let unwrapped = failure {
                unwrapped(error: NSError())
            }
        }
    }
    func POST(Api: LCYApi, parameters: NSDictionary!, success: ((object: NSDictionary) -> Void)?, failure: ((error: NSError!)->Void)?) {
        requestWith(.POST, Api: Api.rawValue, parameters: parameters, success: success, failure: failure)
    }
    
    func GET(Api: LCYApi, parameters: NSDictionary!, success: ((object: NSDictionary) -> Void)?, failure: ((error: NSError!)->Void)?) {
        requestWith(.GET, Api: Api.rawValue, parameters: parameters, success: success, failure: failure)
    }
    
    func POSTNONEJSON(Api: LCYApi, parameters: NSDictionary!, success: ((responseString: String) -> Void)?, failure: ((error: NSError!)->Void)?) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html", "text/plain")
        let absoluteURL = hostURL + Api.rawValue
        manager.POST(absoluteURL, parameters: parameters, success: { (operation, object) -> Void in
            println("success in \"\(Api.rawValue)\" ====> \(operation.responseString)")
            if let unwrappedSuccess = success {
                unwrappedSuccess(responseString: operation.responseString)
            }
            }) { (operation, error) -> Void in
                println("error \(error)")
                println("\(operation.responseString)")
                if let unwrappedFailure = failure {
                    unwrappedFailure(error: error)
                }
        }
    }
    
    private func requestWith(type: RequestType, Api: String, parameters: NSDictionary!, success: ((object: NSDictionary) -> Void)?, failure: ((error: NSError!)->Void)?) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html", "text/plain")
        let absoluteURL = hostURL + Api
        println("Request: \(absoluteURL)\nwith Parameters: \(parameters)")
        switch type {
        case .GET:
            manager.GET(absoluteURL, parameters: parameters, success: { (operation, object) -> Void in
                println("success in \"\(Api)\" ====> \(operation.responseString)")
                if let unwrappedSuccess = success {
                    unwrappedSuccess(object: object as NSDictionary)
                }
                }) { (operation, error) -> Void in
                    println("error \(error)")
                    if let unwrappedFailure = failure {
                        unwrappedFailure(error: error)
                    }
            }
        case .POST:
            manager.POST(absoluteURL, parameters: parameters, success: { (operation, object) -> Void in
                println("success in \"\(Api)\" ====> \(operation.responseString)")
                if let unwrappedSuccess = success {
                    unwrappedSuccess(object: object as NSDictionary)
                }
                }) { (operation, error) -> Void in
                    println("error \(error)")
                    println("\(operation.responseString)")
                    if let unwrappedFailure = failure {
                        unwrappedFailure(error: error)
                    }
            }
        }
    }
    
    func POSTFile(Api: LCYApi, parameters: NSDictionary!, fileKey: String!, fileData: NSData!, fileName: String!, mimeType: LCYMimeType, success: ((object: NSDictionary) -> Void)?, failure: ((error: NSError) -> Void)?) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html", "text/plain")
        let absoluteURL = hostURL + Api.rawValue
        manager.POST(absoluteURL, parameters: parameters, constructingBodyWithBlock: { (formData: AFMultipartFormData!) -> Void in
            formData.appendPartWithFileData(fileData, name: fileKey, fileName: fileName, mimeType: mimeType.rawValue)
            return
            }, success: { (operation, object) -> Void in
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
    
    func POSTMultipleFile(Api: LCYApi, parameters: NSDictionary!, fileKey: String!, fileData: [NSData]!, success: ((object: NSDictionary) -> Void)?, failure: ((error: NSError) -> Void)?) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html", "text/plain")
        let absoluteURL = hostURL + Api.rawValue
        println("posting file, please wait!")
        manager.POST(absoluteURL, parameters: parameters, constructingBodyWithBlock: { (formData: AFMultipartFormData!) -> Void in
            for data in fileData {
                formData.appendPartWithFileData(data, name: fileKey, fileName: "\(data.hash).jpg", mimeType: LCYMimeType.JPEG.rawValue)
            }
            return
            }, success: { (operation, object) -> Void in
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
    
    func POSTCommonFile(fileKey: String!, fileData: NSData!, fileName: String!, mimeType: LCYMimeType, success: ((object: NSDictionary) -> Void)?, failure: ((error: NSError) -> Void)?) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html", "text/plain")
        let absoluteURL = commonURL
        manager.POST(absoluteURL, parameters: nil, constructingBodyWithBlock: { (formData: AFMultipartFormData!) -> Void in
            formData.appendPartWithFileData(fileData, name: fileKey, fileName: fileName, mimeType: mimeType.rawValue)
            return
            }, success: { (operation, object) -> Void in
                println("success in upload ====> \(operation.responseString)")
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
    
    func WikiHTMLAddress(cateID: String) -> String {
        return "\(hostURL)\(ArticleHTMLComponent)\(cateID)"
    }
    
    func WikiDetailHTMLAddress(cateID: String) -> String {
        return "\(hostURL)\(WikiHtmlComponent)\(cateID)"
    }
}