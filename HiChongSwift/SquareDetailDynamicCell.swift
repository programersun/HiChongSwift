//
//  SquareDetailDynamicCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/12.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareDetailDynamicCell: UITableViewCell {
    
    @IBOutlet weak var icyLabel: UILabel!
    class func identifier() -> String {
        return "SquareDetailDynamicCellIdentifier"
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

}
