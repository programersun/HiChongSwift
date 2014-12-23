//
//  MoePetHeaderReusable.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/24.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class MoePetHeaderReusable: UICollectionReusableView {
    
    enum MoePetGender {
        case Male
        case Female
    }
    
    @IBOutlet private weak var signBackgroundView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    @IBOutlet private weak var detailLabel: UILabel!
    
    @IBOutlet private weak var genderImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private var statusImageViews: [UIImageView]!
    
    @IBOutlet private weak var signLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.roundCorner()
        avatarImageView.layer.borderColor = UIColor.LCYTableLightBlue().CGColor
        avatarImageView.layer.borderWidth = 2.0
        
        detailLabel.backgroundColor = UIColor.LCYTableLightBlue()
        detailLabel.layer.cornerRadius = 4.0
        detailLabel.layer.masksToBounds = true
        detailLabel.textColor = UIColor.LCYThemeDarkText()
        
        signBackgroundView.backgroundColor = UIColor.LCYTableLightBlue()
        signLabel.textColor = UIColor.LCYThemeDarkText()
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
    
    var gender: MoePetGender = .Male {
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
                    breedingImageView.image = UIImage(named: "petBredding")
                    break
                }
            }
            index++
        }
        if adopt {
            for breedingImageView in statusImageViews {
                if breedingImageView.tag == index {
                    breedingImageView.image = UIImage(named: "petAdopt")
                    break
                }
            }
            index++
        }
        if entrust {
            for breedingImageView in statusImageViews {
                if breedingImageView.tag == index {
                    breedingImageView.image = UIImage(named: "petEntrust")
                    break
                }
            }
        }
    }
    
    var sign: String? {
        didSet {
            signLabel.text = sign
        }
    }
}
