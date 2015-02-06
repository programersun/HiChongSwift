//
//  FindTwitterListCell.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/19.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

let twitterFontSize = CGFloat(12.0)

class FindTwitterListCell: UITableViewCell {
    
//    var delegate: FindTwitterListCellDelegate?
    
    // MARK: - Outlets
    
    /// 主人昵称
    @IBOutlet weak var keeperNameLabel: UILabel!
    /// 主人头像
    @IBOutlet private weak var keeperAvatarImageView: UIImageView!
    var keeperAvatarPath: String? {
        didSet {
            if let path = keeperAvatarPath {
                keeperAvatarImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "placeholderLogo"))
            } else {
                keeperAvatarImageView.image = nil
            }
        }
    }
    /// 发送的内容
    @IBOutlet weak var icyContentLabel: UILabel!
    @IBOutlet private weak var icyContentBlockHeight: NSLayoutConstraint!
    var icyContent: String? {
        didSet {
            if let content = icyContent {
                icyContentLabel.text = content
                var textHeight = content.boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.width - 16.0, 20000.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(twitterFontSize)], context: nil).height
                if textHeight > 86.0 && !expand {
                    textHeight = 86.0
                    textHeight += 16.0
                    icyContentLabel.numberOfLines = 6
                    fullButton.hidden = false
                } else {
                    fullButton.hidden = true
                    icyContentLabel.numberOfLines = 0
                }
                icyContentBlockHeight.constant = textHeight + 68.0
            } else {
                icyContentLabel.text = nil
                icyContentBlockHeight.constant = 68.0
            }
        }
    }
    @IBOutlet private weak var fullButton: UIButton!
    @IBAction func fullButtonPressed(sender: AnyObject) {
        delegate?.findCilcleListCellExpand(indexPath)
    }
    var expand: Bool = false
    
    /// 中间的图片
    @IBOutlet private weak var headerBlockView: UIView!
    @IBOutlet weak var icyImageBlockHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var middleSizedImages: [UIImageView]!
    @IBOutlet private weak var onlyOneImageView: UIImageView!
    @IBOutlet weak var singleImageWidthConstraint: NSLayoutConstraint!
    let placeHolderColor = UIColor(white: 0.9, alpha: 1.0)
    var twitterImages: [TwitterListImages]? {
        didSet {
            // 清除背景颜色
            onlyOneImageView.backgroundColor = UIColor.clearColor()
            for mid in middleSizedImages {
                mid.backgroundColor = UIColor.clearColor()
            }
            // 设置图片
            if let images = twitterImages {
                onlyOneImageView.image = nil
                if images.count == 0 {
                    icyImageBlockHeightConstraint.constant = 0.0
                    for one in middleSizedImages {
                        one.image = nil
                    }
                } else if images.count == 1 {
                    if images[0].cutWidth.bridgeToObjectiveC().floatValue > images[0].cutHeight.bridgeToObjectiveC().floatValue {
                        singleImageWidthConstraint.constant = UIScreen.mainScreen().bounds.width / 3.0 * 2.0
                        icyImageBlockHeightConstraint.constant = CGFloat((images[0].cutHeight as NSString).floatValue) / CGFloat((images[0].cutWidth as NSString).floatValue) * CGFloat(UIScreen.mainScreen().bounds.width * 2.0 / 3.0)
                    } else {
                        icyImageBlockHeightConstraint.constant = UIScreen.mainScreen().bounds.width / 3.0 * 2.0
                        singleImageWidthConstraint.constant = (UIScreen.mainScreen().bounds.width / 3.0 * 2.0) / CGFloat(images[0].cutHeight.bridgeToObjectiveC().floatValue) * CGFloat(images[0].cutWidth.bridgeToObjectiveC().floatValue)
                    }
                    for one in middleSizedImages {
                        one.image = nil
                    }
                    if let url = NSURL(string: images[0].cutPath.toAbsolutePath()) {
                        onlyOneImageView.contentMode = .Center
                        onlyOneImageView.backgroundColor = placeHolderColor
                        onlyOneImageView.setImageWithURLRequest(NSURLRequest(URL: url), placeholderImage: UIImage(named: "CirclePlaceHolderGray"), success: { [weak self](_, _, finalImage) -> Void in
                            self?.onlyOneImageView.image = finalImage
                            self?.onlyOneImageView.contentMode = .ScaleAspectFill
                            return
                            }, failure: { (_, _, _) -> Void in
                                return
                        })
                    } else {
                        onlyOneImageView.image = nil
                    }
                    //                    onlyOneImageView.setImageWithURL(NSURL(string: images[0].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                } else {
                    onlyOneImageView.image = nil
                    if images.count <= 3 {
                        // 2-3张
                        icyImageBlockHeightConstraint.constant = UIScreen.mainScreen().bounds.width / 3.0
                    } else if images.count <= 6 {
                        // 4-6张
                        icyImageBlockHeightConstraint.constant = UIScreen.mainScreen().bounds.width / 3.0 * 2.0
                    } else {
                        // 9张
                        icyImageBlockHeightConstraint.constant = UIScreen.mainScreen().bounds.width
                    }
                    for middle in middleSizedImages {
                        if middle.tag > images.count {
                            middle.image = nil
                        } else {
                            middle.contentMode = .Center
                            middle.backgroundColor = placeHolderColor
                            if let url = NSURL(string: images[middle.tag - 1].cutPath.toAbsolutePath()) {
                                middle.setImageWithURLRequest(NSURLRequest(URL: url), placeholderImage: UIImage(named: "CirclePlaceHolderGray"), success: { (_, _, finalImage) -> Void in
                                    middle.image = finalImage
                                    middle.contentMode = .ScaleAspectFill
                                    return
                                    }, failure: { (_, _, _) -> Void in
                                        return
                                })
                            } else {
                                middle.image = nil
                            }
                            //                            middle.setImageWithURL(NSURL(string: images[middle.tag - 1].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                        }
                    }
                }
            } else {
                // 正常情况程序不会执行这一段
                println("no images")
                icyImageBlockHeightConstraint.constant = 0.0
                for one in middleSizedImages {
                    one.image = nil
                }
            }
        }
    }
    // 点赞的人
    @IBOutlet private weak var icyCollectionView: UICollectionView!
    var starPeople: [TwitterListStarList]?{
        didSet {
            icyCollectionView.reloadData()
        }
    }
    // 宠物头像
    @IBOutlet weak var petAvatarImageView: UIImageView!
    var petAvatarPath: String? {
        didSet {
            if let path = petAvatarPath {
                petAvatarImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "placeholderLogo"))
            } else {
                petAvatarImageView.image = nil
            }
        }
    }
    
    /// 宠物昵称
    @IBOutlet weak var petNicknameLabel: UILabel!
    /// 宠物类型
    @IBOutlet weak var petCateNameLabel: UILabel!
    
    /// 点赞数量
    @IBOutlet weak var upNumberLabel: UILabel!
    /// 评论数量
    @IBOutlet weak var commentNumberLabel: UILabel!
    
    // 宠物性别
    @IBOutlet private weak var petCateBackView: UIView!
    enum PetSex: String {
        case Male = "0"
        case Female = "1"
    }
    var petSex: PetSex? {
        didSet {
            if let petSex = petSex {
                switch petSex {
                case .Male:
                    petCateBackView.backgroundColor = UIColor.LCYThemeDarkText()
                case .Female:
                    petCateBackView.backgroundColor = UIColor.LCYThemeOrange()
                }
            } else {
                petCateBackView.backgroundColor = UIColor.lightGrayColor()
            }
        }
    }
    
    /// 用户是否点过赞
    @IBOutlet private weak var starButton: UIButton!
    var stared: Bool = false {
        didSet {
            if stared {
                starButton.setImage(UIImage(named: "twiZanFill"), forState: UIControlState.Normal)
            } else {
                starButton.setImage(UIImage(named: "twiZan"), forState: UIControlState.Normal)
            }
        }
    }
    
    // 用户性别
    @IBOutlet private weak var genderImageView: UIImageView!
    var keeperSex: PetSex? {
        didSet {
            if let petSex = petSex {
                switch petSex {
                case .Male:
                    genderImageView.image = UIImage(named: "sqFemale")
                case .Female:
                    genderImageView.image = UIImage(named: "sqMale")
                }
            } else {
                genderImageView.image = nil
            }
        }
    }
    
    @IBOutlet private weak var careButton: UIButton!
    var cared: Bool = false {
        didSet {
            if cared {
                careButton.setImage(UIImage(named: "twiAddCareNone"), forState: UIControlState.Normal)
            } else {
                careButton.setImage(UIImage(named: "twiAddCare"), forState: UIControlState.Normal)
            }
        }
    }
    
    
    @IBOutlet private weak var sepratorImageView: UIImageView!
    @IBOutlet private weak var sepractorHeightConstraint: NSLayoutConstraint!
    
    /// 代理，用于传递事件
    weak var delegate: FindCircleListCellDelegate?
    var indexPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    @IBAction func starButtonPressed(sender: AnyObject) {
        delegate?.findCircleListCellStar(indexPath)
    }
    @IBAction func commentButtonPressed(sender: AnyObject) {
        delegate?.findCircleListCellComment(indexPath)
    }
    @IBAction func headBlockTouched(sender: AnyObject) {
        delegate?.findCircleListCellTitleClicked(indexPath)
    }
    @IBAction func careButtonPressed(sender: AnyObject) {
        delegate?.findCircleListCellCare(indexPath)
    }
    
    /// 发布时间
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    // MARK: - Actions
    class var identifier: String {
        return "FindTwitterListCellIdentifier"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        keeperAvatarImageView.roundCorner()
        
        headerBlockView.bringSubviewToFront(onlyOneImageView)
        
        sepractorHeightConstraint.constant = 1.0 / UIScreen.mainScreen().scale
        sepratorImageView.image = LCYCommon.sharedInstance.circleSepratorImage
        
        //        let placeHolderColor = UIColor(white: 0.95, alpha: 1.0)
        //        onlyOneImageView.backgroundColor = placeHolderColor
        //        for mid in middleSizedImages {
        //            mid.backgroundColor = placeHolderColor
        //        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension FindTwitterListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return starPeople?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(FindAddImageCollectionCell.identifier, forIndexPath: indexPath) as FindAddImageCollectionCell
        if let data = starPeople?[indexPath.row] {
            //            cell.icyImageView.setImageWithURL(NSURL(string: data.headImage.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
            cell.icyImageView.contentMode = .Center
            if let url = NSURL(string: data.headImage.toAbsolutePath()) {
                cell.icyImageView.setImageWithURLRequest(NSURLRequest(URL: url), placeholderImage: UIImage(named: "CirclePlaceHolderGray"), success: { (_, _, finalImage) -> Void in
                    cell.icyImageView.image = finalImage
                    cell.icyImageView.contentMode = .ScaleAspectFill
                    return
                    }, failure: { (_, _, _) -> Void in
                        return
                })
            } else {
                cell.icyImageView.image = nil
            }
        } else {
            cell.icyImageView.image = nil
        }
        return cell
    }
}
