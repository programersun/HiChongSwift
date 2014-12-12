//
//  SquareListCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/12.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareListCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet private var heartImageView: [UIImageView]!
    
    var icyScore: CGFloat? {
        didSet {
            if icyScore != oldValue {
                for chanImage in self.heartImageView {
                    if CGFloat(chanImage.tag) <= icyScore {
                        chanImage.image = UIImage(named: "sqHeartFull")
                    } else if (CGFloat(chanImage.tag) - 0.5) <= icyScore {
                        chanImage.image = UIImage(named: "sqHeartHalf")
                    } else {
                        chanImage.image = UIImage(named: "sqHeartNone")
                    }
                }
            }
        }
    }
    
    class func identifier() -> String {
        return "SquareListCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLabel.textColor = UIColor.LCYThemeColor()
        self.detailLabel.textColor = UIColor.LCYThemeColor()
        self.distanceLabel.textColor = UIColor.LCYThemeColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
