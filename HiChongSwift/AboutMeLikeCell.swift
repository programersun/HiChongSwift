//
//  AboutMeLikeCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/23.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class AboutMeLikeCell: UITableViewCell {
    
    @IBOutlet private weak var bottomLeft: UIView!
    @IBOutlet private weak var bottomMiddle: UIView!
    @IBOutlet private weak var bottomRight: UIView!
    @IBOutlet private var bottomLineHeightConstraints: [NSLayoutConstraint]!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var fansLabel: UILabel!
    @IBOutlet weak var careLabel: UILabel!
    
    @IBOutlet private var textLabels: [UILabel]!
    
    @IBOutlet var containerView: [UIView]!
    class func identifier() -> String {
        return "AboutMeLikeCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code'
        bottomLeft.backgroundColor = UIColor.LCYTableLightBlue()
        bottomMiddle.backgroundColor = UIColor.LCYThemeOrange()
        bottomRight.backgroundColor = UIColor.LCYThemeDarkText()
        
        for constraint in bottomLineHeightConstraints {
            constraint.constant = 2.0
        }
        
        for label in textLabels {
            label.textColor = UIColor.LCYThemeDarkText()
        }
        
        for oneView in containerView {
            oneView.backgroundColor = UIColor.LCYThemeColor()
        }
        backgroundColor = UIColor.LCYThemeColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
