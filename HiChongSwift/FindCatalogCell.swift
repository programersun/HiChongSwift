//
//  FindCatalogCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/17.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class FindCatalogCell: UITableViewCell {
    
    @IBOutlet weak var sepratorHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sepratorImageView: UIImageView!
    
    class func identifier() -> String {
        return "FindCatalogCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.LCYThemeColor()
        
        self.sepratorHeightConstraint.constant = 1.0 / UIScreen.mainScreen().scale
        self.sepratorImageView.image = LCYCommon.sharedInstance.artSepratorImage
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
