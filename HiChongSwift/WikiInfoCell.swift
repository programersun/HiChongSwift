//
//  WikiInfoCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/25.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class WikiInfoCell: UITableViewCell {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var icyTitleLabel: UILabel!
    @IBOutlet private weak var icyKeywordLabel: UILabel!
    @IBOutlet private weak var yueduLabel: UILabel!
    @IBOutlet private weak var shoucangLabel: UILabel!
    @IBOutlet private weak var numberReadLabel: UILabel!
    @IBOutlet private weak var numberCollectLabel: UILabel!
    
    /// 题目
    var icyTitle: String? {
        didSet {
            icyTitleLabel.text = icyTitle
        }
    }
    /// 关键字
    var keyWord: String? {
        didSet {
            icyKeywordLabel.text = keyWord
        }
    }
    /// 阅读数
    var readCount: String? {
        didSet {
            numberReadLabel.text = readCount
        }
    }
    /// 收藏数
    var collectCount: String? {
        didSet {
            numberCollectLabel.text = collectCount
        }
    }
    /// 图片路径
    var imagePath: String? {
        didSet {
            if let path = imagePath {
                avatarImageView.setImageWithURL(NSURL(string: path))
            }
        }
    }
    
    class func identifier() -> String {
        return "WikiInfoCellIdentifier"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImageView.roundCorner()
        icyTitleLabel.textColor = UIColor.LCYThemeOrange()
        yueduLabel.textColor = UIColor.LCYThemeOrange()
        icyKeywordLabel.textColor = UIColor.LCYThemeDarkText()
        shoucangLabel.textColor = UIColor.LCYThemeDarkText()
        
        numberReadLabel.layer.cornerRadius = 4.0
        numberReadLabel.layer.masksToBounds = true
        numberReadLabel.backgroundColor = UIColor.LCYThemeDarkText()
        
        numberCollectLabel.layer.cornerRadius = 4.0
        numberCollectLabel.layer.masksToBounds = true
        numberCollectLabel.backgroundColor = UIColor.LCYThemeOrange()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
