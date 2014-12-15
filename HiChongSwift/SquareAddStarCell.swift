//
//  SquareAddStarCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareAddStarCell: UITableViewCell {
    
    class func identifier() -> String {
        return "SquareAddStarCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        println("change to \(sender.value)")
    }
}
