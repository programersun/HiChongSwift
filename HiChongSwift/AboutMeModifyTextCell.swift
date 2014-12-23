//
//  AboutMeModifyTextCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/23.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class AboutMeModifyTextCell: UITableViewCell {
    
    @IBOutlet weak var icyTextField: UITextField!
    
    class func identifier() -> String {
        return "AboutMeModifyTextCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
