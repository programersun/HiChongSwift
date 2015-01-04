//
//  WikiesHeadCell.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/4.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class WikiesHeadCell: UITableViewCell {
    
    class func identifier() -> String {
        return "WikiesHeadCellIdentifier"
    }

    @IBOutlet private weak var lineHeight: NSLayoutConstraint!
    @IBOutlet private weak var icyImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lineHeight.constant = 1.0 / UIScreen.mainScreen().scale
        icyImageView.roundCorner()
        icyImageView.layer.borderWidth = 1.0 / UIScreen.mainScreen().scale
        icyImageView.layer.borderColor = UIColor.LCYThemeDarkText().CGColor
        
        backgroundColor = UIColor.LCYThemeColor()
    }
    
    /// 图片路径
    var imagePath: String? {
        didSet {
            if let path = imagePath {
                icyImageView.setImageWithURL(NSURL(string: path))
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
