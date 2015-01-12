//
//  WikiAdCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/25.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class WikiAdCell: UITableViewCell {
    
    @IBOutlet weak var icyScrollView: UIScrollView!
    
    var adImages: [String]? {
        didSet {
            if oldValue == nil {
                // 确保只能设置一次
                if let images = adImages {
                    let screenWidth = UIScreen.mainScreen().bounds.width
                    let imageCount = images.count
                    let contentView = UIView(frame: CGRectMake(0, 0, screenWidth * CGFloat(imageCount), screenWidth / WikiAdvertisementRatio))
                    var imageViews = [UIImageView]()
                    var index = 0
                    for one in images {
                        let imageView = UIImageView(frame: CGRectMake(screenWidth * CGFloat(index), 0, screenWidth, screenWidth / WikiAdvertisementRatio))
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
    
    class func identifier() -> String {
        return "WikiAdCellIdentifier"
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
