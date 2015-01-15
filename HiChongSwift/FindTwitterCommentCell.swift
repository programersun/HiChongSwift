//
//  FindTwitterCommentCell.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/13.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class FindTwitterCommentCell: UITableViewCell {
    
    @IBOutlet weak var sepratorImageView: UIImageView!
    @IBOutlet private weak var sepratorHeightConstraint: NSLayoutConstraint!
    
    class var identifier: String {
        get {
            return "FindTwitterCommentCellIdentifier"
        }
    }
    
    @IBOutlet weak var icyTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.sepratorHeightConstraint.constant = 1.0 / UIScreen.mainScreen().scale
        self.sepratorImageView.image = LCYCommon.sharedInstance.graySepratorImage
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
