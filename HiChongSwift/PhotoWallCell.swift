//
//  PhotoWallCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/4.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

let PhotoWallCellIdentifier = "PhotoWallCellIdentifier"

class PhotoWallCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        let radius = self.avatarImageView.bounds.size.width / 2.0
        self.avatarImageView.layer.masksToBounds = true
        self.avatarImageView.layer.cornerRadius = radius
    }
}
