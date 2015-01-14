//
//  OtherExtensions.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import Foundation

private let hostURLPrefix = "http://123.57.7.88/admin/"

extension UIImageView {
    func roundCorner() {
        let radius = min(self.bounds.width, self.bounds.height) / 2.0
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
}

extension UITableView {
    func hideExtraSeprator() {
        let emptyView = UIView(frame: CGRectZero)
        self.tableFooterView = emptyView
    }
}

extension Int {
    func toAge() -> String {
        return "\(self)".toAge()
    }
}

extension String {
    /**
    图片相对路径转换为绝对路径
    
    :returns: 绝对路径
    */
    func toAbsolutePath() -> String {
        return hostURLPrefix + self
    }
    
    func toAge() -> String {
        switch self {
        case "0":
            return "小于1岁"
        case "11":
            return "大于10岁"
        default:
            return "\(self)岁"
        }
    }
    
    func bridgeToObjectiveC() -> NSString {
        return self as NSString
    }
    
    func toTwitterDeltaTime() -> String {
        let current = NSDate()
        let strDate = NSDate(timeIntervalSince1970: self.bridgeToObjectiveC().doubleValue)
        
        let delta = current.timeIntervalSinceDate(strDate)
        if delta <= 60 {
            return "刚刚"
        } else if delta < 3600 {
            return "\(Int(delta/60.0))分钟前"
        } else if delta < 86400 {
            return "\(Int(delta/3600.0))小时前"
        } else {
            return "\(Int(delta/86400.0))天前"
        }
    }
    
    func toTwitterCalendar() -> NSAttributedString {
        let strDate = NSDate(timeIntervalSince1970: self.bridgeToObjectiveC().doubleValue)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMdd"
        let dateString = dateFormatter.stringFromDate(strDate)
        let month = dateString.substringToIndex(advance(dateString.startIndex, 2))
        let day = dateString.substringFromIndex(advance(dateString.startIndex, 2))
        
        let map = [
            "01": "一月",
            "02": "二月",
            "03": "三月",
            "04": "四月",
            "05": "五月",
            "06": "六月",
            "07": "七月",
            "08": "八月",
            "09": "九月",
            "10": "十月",
            "11": "十一月",
            "12": "十二月",
        ]
        let monthString = map[month] ?? ""
        
        var aString = NSMutableAttributedString(string: "\(day)日\(monthString)")
        aString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(17.0), range: NSRange(location: 0, length: 2))
        let range = (aString.string as NSString).rangeOfString(monthString)
        aString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(10.0), range: range)
        return aString
    }
}

extension Double {
    func format(f: String) -> String {
        return NSString(format: "%\(f)f", self)
    }
    
    func toKM() -> String {
        let dot2format = ".1"
        if self < 100.0 {
            return "不到100m"
        } else {
            return "\((self / 1000.0).format(dot2format))km"
        }
    }
}

extension Dictionary{
    mutating func extend(content: Dictionary) {
        for (key, value) in content {
            self.updateValue(value, forKey: key)
        }
    }
}

extension String {
    func SHA_1() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02X", byte)
        }
        return output
    }
}
