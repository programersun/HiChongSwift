//
//  SquareAddStarCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareAddStarCell: UITableViewCell {
    
    @IBOutlet weak var testImage: UIImageView!
    
    @IBOutlet var heartImageViews: [UIImageView]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    var imageWidth: CGFloat = 0.0 {
        didSet {
            let res = imageWidth / 28.0
            let ces = res - (res % 0.5)
            self.scoreLabel.text = "\(ces)"
            
            for chanImage in self.heartImageViews {
                if CGFloat(chanImage.tag) <= ces {
                    chanImage.image = UIImage(named: "bigHeartFull")
                } else if (CGFloat(chanImage.tag) - 0.5) <= ces {
                    chanImage.image = UIImage(named: "bigHeartHalf")
                } else {
                    chanImage.image = UIImage(named: "bigHeartEmpty")
                }
            }
        }
    }
    
    class func identifier() -> String {
        return "SquareAddStarCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.scoreLabel.textColor = UIColor.LCYThemeDarkText()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
