//
//  FindCircleListCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/16.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

protocol FindCircleListCellDelegate: class {
    func findCircleListCellStar(indexPath: NSIndexPath)
    func findCircleListCellTitleClicked(indexPath: NSIndexPath)
    func findCircleListCellComment(indexPath: NSIndexPath)
}

class FindCircleListCell: UITableViewCell {
    
    weak var delegate: FindCircleListCellDelegate?
    var indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    // 点赞
    @IBAction func starButtonPressed(sender: UIButton) {
        if let delegate = delegate {
            delegate.findCircleListCellStar(indexPath)
        }
    }
    
    // 评论
    @IBAction func commentButtonPressed(sender: UIButton) {
        if let delegate = delegate {
            delegate.findCircleListCellComment(indexPath)
        }
    }
    
    @IBAction func titleLabelTapped(sender: AnyObject) {
        if let delegate = delegate {
            delegate.findCircleListCellTitleClicked(indexPath)
        }
    }
    
    // 多图配置 ⬇️
    @IBOutlet private weak var imageBlockHeight: NSLayoutConstraint!
    
    @IBOutlet private var smallImages: [UIImageView]!
    
    @IBOutlet private weak var onlyOneImageView: UIImageView!
    var twitterImages: [TwitterListImages]? {
        didSet {
            if let images = twitterImages {
                if images.count == 0 {
                    imageBlockHeight.constant = 0.0
                    onlyOneImageView.image = nil
                    for small in smallImages {
                        small.image = nil
                    }
                } else if images.count == 1 {
                    // 1张
                    imageBlockHeight.constant = CGFloat((images[0].imageHeight as NSString).floatValue) / CGFloat((images[0].imageWidth as NSString).floatValue) * CGFloat(242.0 * 0.667)
                    for small in smallImages {
                        small.image = nil
                    }
                    onlyOneImageView.setImageWithURL(NSURL(string: images[0].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                } else {
                    onlyOneImageView.image = nil
                    if images.count <= 3 {
                        // 2-3张
                        imageBlockHeight.constant = 86.0
                    } else if images.count <= 6 {
                        // 4-6张
                        imageBlockHeight.constant = 164.0
                    } else {
                        // 9张
                        imageBlockHeight.constant = 242.0
                    }
                    for small in smallImages {
                        if small.tag > images.count {
                            small.image = nil
                        } else {
                            small.setImageWithURL(NSURL(string: images[small.tag - 1].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                        }
                    }
                }
            } else {
                imageBlockHeight.constant = 0.0
                onlyOneImageView.image = nil
                for small in smallImages {
                    small.image = nil
                }
            }
        }
    }
    // 多图配置 ⬆️
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var petNicknameLabel: UILabel!
    
    @IBOutlet weak var keeperNicknameLabel: UILabel!
    
    @IBOutlet weak var icyContentLabel: UILabel!
    
    @IBOutlet private weak var keeperAvatarImageView: UIImageView!
    var keeperAvatarPath: String? {
        didSet {
            if let path = keeperAvatarPath {
                keeperAvatarImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "placeholderLogo"))
            }
        }
    }
    @IBOutlet private weak var petAvatarImageView: UIImageView!
    var petAvatarPath: String? {
        didSet {
            if let path = petAvatarPath {
                petAvatarImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "placeholderLogo"))
            }
        }
    }
    
    @IBOutlet private weak var sepratorImageView: UIImageView!
    @IBOutlet private weak var sepratorHeightConstraint: NSLayoutConstraint!
    
    class func identifier() -> String {
        return "FindCircleListCellIdentifier"
    }
    
    @IBOutlet private weak var icyCollectionView: UICollectionView!
//    var upNumber: Int = 0 {
//        didSet {
//            self.icyCollectionView.reloadData()
//        }
//    }
    var starPeople: [TwitterListStarList]?{
        didSet {
            icyCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.LCYThemeColor()
        
        self.sepratorHeightConstraint.constant = 1.0 / UIScreen.mainScreen().scale
        self.sepratorImageView.image = LCYCommon.sharedInstance.artSepratorImage
        
        petAvatarImageView.roundCorner()
        keeperAvatarImageView.roundCorner()
        
        petAvatarImageView.layer.borderWidth = 1.0 / UIScreen.mainScreen().scale
        petAvatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension FindCircleListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return starPeople?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(FindAddImageCollectionCell.identifier, forIndexPath: indexPath) as FindAddImageCollectionCell
        let data = starPeople![indexPath.row]
        cell.icyImageView.setImageWithURL(NSURL(string: data.headImage.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
        return cell
    }
}
