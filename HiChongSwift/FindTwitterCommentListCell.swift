//
//  FindTwitterCommentListCell.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/14.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class FindTwitterCommentListCell: UITableViewCell {
    
    @IBOutlet weak var icyLabel: UILabel!
    class var identifier: String {
        get {
            return "FindTwitterCommentListCellIdentifier"
        }
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
