//
//  SquareAdCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/9.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareAdCell: UITableViewCell {
    
    weak var delegate: SquareAdCellDelegate?
    
    private var currentPage = 0
    
    private var timer: NSTimer?
    
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
        
        timer = NSTimer.scheduledTimerWithTimeInterval(4.5, target: self, selector: "timerFired:", userInfo: nil, repeats: true)
        timer?.fire()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "scrollTapped:")
        icyScrollView.addGestureRecognizer(tapGesture)
    }
    
    func timerFired(sender: AnyObject) {
        if let myImage = adImages {
            currentPage++
            if currentPage >= myImage.count {
                currentPage = 0
            }
            let offsetX = CGFloat(currentPage) * UIScreen.mainScreen().bounds.width + 1.0
            icyScrollView.setContentOffset(CGPointMake(offsetX, 0.0), animated: true)
        }
    }
    
    func scrollTapped(sender: AnyObject) {
        if let images = adImages {
            if images.count > 0 {
                delegate?.squareAdCellClickAd(currentPage)
            }
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

extension SquareAdCell: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = Int((scrollView.contentOffset.x + 1.0) / UIScreen.mainScreen().bounds.width)
        currentPage = page
    }
}

protocol SquareAdCellDelegate: class {
    func squareAdCellClickAd(index: Int)
}
