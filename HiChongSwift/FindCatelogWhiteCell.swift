//
//  FindCatelogWhiteCell.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/27.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class FindCatelogWhiteCell: UITableViewCell {
    
    // 头像
    @IBOutlet private weak var keeperAvatarImageView: UIImageView!
    var keeperAvatarPath: String? {
        didSet {
            if let path = keeperAvatarPath {
                keeperAvatarImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "placeholderLogo"))
            } else {
                keeperAvatarImageView.image = nil
            }
        }
    }
    
    // 性别
    @IBOutlet private weak var genderImageView: UIImageView!
    enum cateGender: String {
        case Male       = "0"
        case Female     = "1"
        case Unknown    = "-1"
        init(pValue: String) {
            if pValue == "0" {
                self = .Male
            } else if pValue == "1" {
                self = .Female
            } else {
                self = .Unknown
            }
        }
    }
    var keeperGender: cateGender = .Unknown {
        didSet {
            switch keeperGender {
            case .Male:
                genderImageView.image = UIImage(named: "sqMale")
            case .Female:
                genderImageView.image = UIImage(named: "sqFemale")
            case .Unknown:
                genderImageView.image = nil
            }
        }
    }
    
    // 昵称
    @IBOutlet weak var userNameLabel: UILabel!
    
    // 距离
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    // 宠物
    @IBOutlet private var petImageViews: [UIImageView]!
    var petImagePaths: [String]? {
        didSet {
            if let images = petImagePaths {
                for i_imageView in petImageViews {
                    if images.count >= i_imageView.tag {
                        i_imageView.setImageWithURL(NSURL(string: images[i_imageView.tag - 1]), placeholderImage: UIImage(named: "placeholderLogo"))
                    } else {
                        i_imageView.image = nil
                    }
                }
            } else {
                for oneImage in petImageViews {
                    oneImage.image = nil
                }
            }
        }
    }
    
    
    @IBOutlet private weak var sepratorHeight: NSLayoutConstraint!
    
    @IBOutlet private weak var sepratorImageView: UIImageView!
    
    
    class var identifier: String {
        return "FindCatelogWhiteCellIdentifier"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        keeperAvatarImageView.roundCorner()
        sepratorHeight.constant = 1.0 / UIScreen.mainScreen().scale
        
        sepratorImageView.image = LCYCommon.sharedInstance.circleSepratorImage
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
