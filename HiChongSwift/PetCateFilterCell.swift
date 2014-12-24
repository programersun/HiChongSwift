//
//  PetCateFilterCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/24.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class PetCateFilterCell: UITableViewCell {
    
    @IBOutlet weak var icyImageView: UIImageView!
    
    @IBOutlet weak var icyTextLabel: UILabel!
    class func identifier() -> String {
        return "PetCateFilterCellIdentifier"
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
