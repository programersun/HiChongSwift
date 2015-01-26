//
//  ICYMultiImageCollectionCell.swift
//  MultiImageTest
//
//  Created by eagle on 15/1/23.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import UIKit

class ICYMultiImageCollectionCell: UICollectionViewCell {
    
    var indexPath = NSIndexPath(forItem: 0, inSection: 0)
    weak var delegate: ICYMultiImageCellDelegate?
    
    weak var mainImageView: UIImageView?
    
    private weak var checkMark: UIButton?
    
    var cySelected: Bool = false {
        didSet {
            if cySelected {
//                checkMark?.image = UIImage(named: ICYMultiImagePickerCheckMarkSelected)
                checkMark?.setImage(UIImage(named: ICYMultiImagePickerCheckMarkSelected), forState: UIControlState.Normal)
            } else {
//                checkMark?.image = UIImage(named: ICYMultiImagePickerCheckMarkUnSelected)
                checkMark?.setImage(UIImage(named: ICYMultiImagePickerCheckMarkUnSelected), forState: UIControlState.Normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let mainImageView = UIImageView(frame: CGRectZero)
        contentView.addSubview(mainImageView)
        mainImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        let mainImageTop = NSLayoutConstraint(item: mainImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
        let mainImageBottom = NSLayoutConstraint(item: mainImageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        let mainImageLeading = NSLayoutConstraint(item: mainImageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0)
        let mainImageTrailing = NSLayoutConstraint(item: mainImageView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0)
        
        contentView.addConstraints([mainImageTop, mainImageBottom, mainImageLeading, mainImageTrailing])
        self.mainImageView = mainImageView
        
        
        // 配置对勾
        let mark = UIButton()
        mark.addTarget(self, action: "markButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        mark.setImage(UIImage(named: ICYMultiImagePickerCheckMarkUnSelected), forState: UIControlState.Normal)
//        let mark = UIImageView(image: UIImage(named: ICYMultiImagePickerCheckMarkUnSelected))
        mark.setTranslatesAutoresizingMaskIntoConstraints(false)
        let markRight = NSLayoutConstraint(item: mark, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -8.0)
        let markBottom = NSLayoutConstraint(item: mark, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -8.0)
        contentView.addSubview(mark)
        contentView.addConstraints([markRight, markBottom])
        checkMark = mark
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class var identifier: String {
        return "ICYMultiImageCollectionCellIdentifier"
    }
    
    deinit {
//        println("cell deinit")
    }
    
    func markButtonPressed(sender: AnyObject) {
        delegate?.cellCheckMarkButtonPressed(indexPath)
    }
}

protocol ICYMultiImageCellDelegate: class {
    func cellCheckMarkButtonPressed(index: NSIndexPath)
}
