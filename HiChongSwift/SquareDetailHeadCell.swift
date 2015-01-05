//
//  SquareDetailHeadCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/12.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareDetailHeadCell: UITableViewCell {

    @IBOutlet private weak var icyImageView: UIImageView!
    
    class func identifier() -> String {
        return "SquareDetailHeadCellIdentifier"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.LCYThemeColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// 图片路径
    var imagePath: String? {
        didSet {
            if let path = imagePath {
                icyImageView.setImageWithURL(NSURL(string: path))
            }
        }
    }
    
    /**
    *  商家名称
    */
    @IBOutlet weak var icyTitleLabel: UILabel!
    
    /**
    *  分数显示
    */
    @IBOutlet private weak var starTextLabel: UILabel!
    @IBOutlet private var heartImageView: [UIImageView]!
    var icyScore: CGFloat? {
        didSet {
            if icyScore != oldValue {
                if let score = icyScore {
                    starTextLabel.text = "\(score)"
                }
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

    /**
    *  距离显示
    */
    @IBOutlet weak var distanceLabel: UILabel!
    
}
