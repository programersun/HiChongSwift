//
//  SquareAdCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/9.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareAdCell: UITableViewCell {
    
    @IBOutlet weak var icyScrollView: UIScrollView!
    
    class func identifier() -> String {
        return "SquareAdCellIdentifier"
    }
    
    var adImages: [String]? {
        didSet {
            if oldValue == nil {
                // 确保只能设置一次
                if let images = adImages {
                    let screenWidth = UIScreen.mainScreen().bounds.width
                    let imageCount = images.count
                    let contentView = UIView(frame: CGRectMake(0, 0, screenWidth * CGFloat(imageCount), screenWidth / 2.0))
                    var imageViews = [UIImageView]()
                    var index = 0
                    for one in images {
                        let imageView = UIImageView(frame: CGRectMake(screenWidth * CGFloat(index), 0, screenWidth, screenWidth / 2.0))
                        imageView.setImageWithURL(NSURL(string: one))
                        index++
                        contentView.addSubview(imageView)
                    }
                    icyScrollView.addSubview(contentView)
                    icyScrollView.contentSize = contentView.bounds.size
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //        let screenWidth = UIScreen.mainScreen().bounds.width
        //        let contentView = UIView(frame: CGRectMake(0, 0, screenWidth * 3, screenWidth / 2.0))
        //        let blue = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenWidth / 2.0))
        //        let yellow = UIImageView(frame: CGRectMake(screenWidth, 0, screenWidth, screenWidth / 2.0))
        //        let green = UIImageView(frame: CGRectMake(screenWidth * 2, 0, screenWidth, screenWidth / 2.0))
        //
        //        blue.setImageWithURL(NSURL(string: "http://chuantu.biz/t/56/1418116412x-1922738975.png"))
        //        yellow.setImageWithURL(NSURL(string: "http://chuantu.biz/t/56/1418116514x1822611165.png"))
        //        green.setImageWithURL(NSURL(string: "http://chuantu.biz/t/56/1418116485x1822611165.png"))
        //
        //        contentView.addSubview(blue)
        //        contentView.addSubview(yellow)
        //        contentView.addSubview(green)
        //
        //        self.icyScrollView.addSubview(contentView)
        //        self.icyScrollView.contentSize = contentView.bounds.size
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
