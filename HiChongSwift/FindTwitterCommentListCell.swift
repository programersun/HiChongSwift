//
//  FindTwitterCommentListCell.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/14.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class FindTwitterCommentListCell: UITableViewCell {
    
    @IBOutlet weak var icyLabel: UILabel!
    @IBOutlet weak var icyNameLabel: UILabel!
    @IBOutlet weak var icyTimeLabel: UILabel!
    @IBOutlet private weak var icyImageView: UIImageView!
    @IBOutlet private weak var sepratorHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var sepratorView: UIImageView!
    var avatarPath: String? {
        didSet {
            if let path = avatarPath {
                icyImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "placeholderLogo"))
            } else {
                icyImageView.image = UIImage(named: "placeholderLogo")
            }
        }
    }
    
    class var identifier: String {
        get {
            return "FindTwitterCommentListCellIdentifier"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sepratorHeightConstraint.constant = 1.0 / UIScreen.mainScreen().scale
        sepratorView.image = LCYCommon.sharedInstance.graySepratorImage
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
