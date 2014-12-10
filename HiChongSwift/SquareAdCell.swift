//
//  SquareAdCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/9.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

let SquareAdCellIdentifier = "SquareAdCellIdentifier"

class SquareAdCell: UITableViewCell {
    
    @IBOutlet weak var icyScrollView: UIScrollView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let contentView = UIView(frame: CGRectMake(0, 0, screenWidth * 3, screenWidth / 2.0))
        let blue = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenWidth / 2.0))
        let yellow = UIImageView(frame: CGRectMake(screenWidth, 0, screenWidth, screenWidth / 2.0))
        let green = UIImageView(frame: CGRectMake(screenWidth * 2, 0, screenWidth, screenWidth / 2.0))
        
        blue.setImageWithURL(NSURL(string: "http://chuantu.biz/t/56/1418116412x-1922738975.png"))
        yellow.setImageWithURL(NSURL(string: "http://chuantu.biz/t/56/1418116514x1822611165.png"))
        green.setImageWithURL(NSURL(string: "http://chuantu.biz/t/56/1418116485x1822611165.png"))
        
        contentView.addSubview(blue)
        contentView.addSubview(yellow)
        contentView.addSubview(green)
        
        self.icyScrollView.addSubview(contentView)
        self.icyScrollView.contentSize = contentView.bounds.size
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
