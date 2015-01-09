//
//  FindCircleAddTextCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/16.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class FindCircleAddTextCell: UITableViewCell {
    
    @IBOutlet weak var icyTextView: UITextView!
    
    class func identifier() -> String {
        return "FindCircleAddTextCellIdentifier"
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
