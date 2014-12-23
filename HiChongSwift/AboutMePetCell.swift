//
//  AboutMePetCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/23.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class AboutMePetCell: UITableViewCell {
    
    enum AboutMePetGender {
        case Male
        case Female
    }
    
    @IBOutlet private weak var sepratorHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var sepratorImageView: UIImageView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var detailLabel: UILabel!
    
    @IBOutlet private weak var genderImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private var statusImageViews: [UIImageView]!
    
    class func identifier() -> String {
        return "AboutMePetCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sepratorHeightConstraint.constant = 1.0 / UIScreen.mainScreen().scale
        sepratorImageView.image = LCYCommon.sharedInstance.artSepratorImage
        backgroundColor = UIColor.LCYThemeColor()
        avatarImageView.roundCorner()
        avatarImageView.layer.borderColor = UIColor.LCYTableLightBlue().CGColor
        avatarImageView.layer.borderWidth = 2.0
        
        detailLabel.backgroundColor = UIColor.LCYTableLightBlue()
        detailLabel.layer.cornerRadius = 4.0
        detailLabel.layer.masksToBounds = true
        detailLabel.textColor = UIColor.LCYThemeDarkText()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var avatarImagePath: String? {
        didSet {
            if let urlPath = avatarImagePath {
                avatarImageView.setImageWithURL(NSURL(string: urlPath))
            } else {
                avatarImageView.image = nil
            }
        }
    }
    
    var detailText: String? {
        didSet {
            detailLabel.text = detailText
        }
    }
    
    var gender: AboutMePetGender = .Male {
        didSet {
            if oldValue != gender {
                switch gender {
                case .Male:
                    genderImageView.image = UIImage(named: "sqMale")
                case .Female:
                    genderImageView.image = UIImage(named: "sqFemale")
                }
            }
        }
    }
    
    var nameText: String? {
        didSet {
            nameLabel.text = nameText
        }
    }
    
    func statusLable(#breeding: Bool, adopt: Bool, entrust: Bool) {
        for statusImageView in statusImageViews {
            statusImageView.image = nil
        }
        var index = 1
        if breeding {
            for breedingImageView in statusImageViews {
                if breedingImageView.tag == index {
                    breedingImageView.image = UIImage(named: "findSearch_03")
                    break
                }
            }
            index++
        }
        if adopt {
            for breedingImageView in statusImageViews {
                if breedingImageView.tag == index {
                    breedingImageView.image = UIImage(named: "findSearch_04")
                    break
                }
            }
            index++
        }
        if entrust {
            for breedingImageView in statusImageViews {
                if breedingImageView.tag == index {
                    breedingImageView.image = UIImage(named: "findSearch_05")
                    break
                }
            }
        }
    }
}
