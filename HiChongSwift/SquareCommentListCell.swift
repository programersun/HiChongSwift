//
//  SquareCommentListCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareCommentListCell: UITableViewCell {
    
    @IBOutlet private weak var icyimageView: UIImageView!
    
    /// 图片路径
    var imagePath: String? {
        didSet {
            if let path = imagePath {
                icyimageView.setImageWithURL(NSURL(string: path))
            }
        }
    }
    
    @IBOutlet weak var icyNameLabel: UILabel!
    @IBOutlet weak var icyContentLabel: UILabel!
    
    @IBOutlet private var icyStars: [UIImageView]!
    
    var icyStar: Float = -0.5 {
        didSet {
            if icyStar != oldValue {
                for chanImage in self.icyStars {
                    if Float(chanImage.tag) <= icyStar {
                        chanImage.image = UIImage(named: "sqHeartFull")
                    } else if (Float(chanImage.tag) - 0.5) <= icyStar {
                        chanImage.image = UIImage(named: "sqHeartHalf")
                    } else {
                        chanImage.image = UIImage(named: "sqHeartNone")
                    }
                }
            }
        }
    }
    
    enum squareCommentGender: Int {
        case male
        case female
        case unknown
    }
    
    var icyGender: squareCommentGender? {
        didSet {
            if let unwrapped = icyGender {
                switch unwrapped {
                case .male:
                    self.icyGenderImageView.image = UIImage(named: "sqMale")
                case .female:
                    self.icyGenderImageView.image = UIImage(named: "sqFemale")
                case .unknown:
                    self.icyGenderImageView.image = nil
                }
            }
        }
    }
    
    @IBOutlet weak private var icyGenderImageView: UIImageView!
    class func identifier() -> String {
        return "SquareCommentListCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.icyNameLabel.textColor = UIColor.LCYThemeDarkText()
        self.icyimageView.roundCorner()
        self.backgroundColor = UIColor.LCYThemeColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
