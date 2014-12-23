//
//  AboutMeHeaderCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/23.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class AboutMeHeaderCell: UITableViewCell {
    
    @IBOutlet private weak var sepratorHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var sepratorImageView: UIImageView!
    @IBOutlet private weak var avatarFrameImageView: UIImageView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    class func identifier() -> String {
        return "AboutMeHeaderCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sepratorHeightConstraint.constant = 1.0 / UIScreen.mainScreen().scale
        sepratorImageView.backgroundColor = UIColor.LCYThemeDarkText()
        avatarFrameImageView.roundCorner()
        avatarFrameImageView.layer.borderWidth = 1.0 / UIScreen.mainScreen().scale
        avatarFrameImageView.layer.borderColor = UIColor.LCYThemeDarkText().CGColor
        avatarFrameImageView.backgroundColor = UIColor.LCYThemeColor()
        avatarImageView.roundCorner()
        backgroundColor = UIColor.LCYThemeColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var avatarImagePath: String? {
        didSet {
            if let urlPath = avatarImagePath {
                avatarImageView.setImageWithURL(NSURL(string: urlPath))
            } else {
                avatarImageView.image = nil
            }
        }
    }

}
