//
//  SquareDetailMiddleCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/12.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareDetailMiddleCell: UITableViewCell {
    
    @IBOutlet weak private var icyMakeImageView: UIImageView!
    
    @IBOutlet weak var icyLabel: UILabel!
    
    enum SquareDetailMiddleCellType: Int {
        case Location = 0
        case Phone
        case Comment
    }
    
    var cellType: SquareDetailMiddleCellType?{
        didSet{
            if let unwrapped = cellType {
                switch unwrapped {
                case .Location:
                    self.icyMakeImageView.image = UIImage(named: "sqDetailGeoMark")
                case .Phone:
                    self.icyMakeImageView.image = UIImage(named: "sqDetailPhone")
                case .Comment:
                    self.icyMakeImageView.image = UIImage(named: "sqDetailComment")
                }
            }
        }
    }
    
    class func identifier() -> String {
        return "SquareDetailMiddleCellIdentifier"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.icyLabel.textColor = UIColor.LCYThemeDarkText()
        self.cellType = SquareDetailMiddleCellType.Location
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
