//
//  FindViewCell.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/30.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class FindViewCell: UITableViewCell {
    
    class var identifier: String {
        return "FindViewCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet private weak var icyImageView: UIImageView!
    var icyImagePath: String? {
        didSet {
            if let path = icyImagePath {
                icyImageView.setImageWithURL(NSURL(string: path))
            } else {
                icyImageView.image = nil
            }
        }
    }
    @IBOutlet weak var icyLabel: UILabel!
    
    // 显示数字
    @IBOutlet private weak var badgeView: UIView!
    @IBOutlet private weak var badgeNumberLabel: UILabel!
    var badgeNumber: Int? {
        didSet {
            if let number = badgeNumber {
                if number != 0{
                    badgeView.hidden = false
                    badgeNumberLabel.text = "\(number)"
                } else {
                    badgeView.hidden = true
                }
            } else {
                badgeView.hidden = true
            }
        }
    }
    
}
