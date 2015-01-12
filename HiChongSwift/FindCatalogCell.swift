//
//  FindCatalogCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/17.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

enum icyGender {
    case Male
    case Female
    case Unknown
}

class FindCatalogCell: UITableViewCell {
    
    @IBOutlet weak var sepratorHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sepratorImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var signLabel: UILabel!
    
    @IBOutlet private weak var genderImageView: UIImageView!
    var gender: icyGender = .Male {
        didSet {
            switch gender {
            case .Male:
                genderImageView.image = UIImage(named: "sqMale")
            case .Female:
                genderImageView.image = UIImage(named: "sqFemale")
            case .Unknown:
                genderImageView.image = nil
            }
        }
    }
    
    @IBOutlet private weak var petCountLabel: UILabel!
    var petCount: String? {
        didSet {
            if let text = petCount {
                petCountLabel.text = "宠物：\(text)"
            }
        }
    }
    
    @IBOutlet private weak var icyImageView: UIImageView!
    var icyImagePath: String? {
        didSet {
            if let path = icyImagePath {
                icyImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "placeholderLogo"))
            }
        }
    }
    
    class func identifier() -> String {
        return "FindCatalogCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.LCYThemeColor()
        
        self.sepratorHeightConstraint.constant = 1.0 / UIScreen.mainScreen().scale
        self.sepratorImageView.image = LCYCommon.sharedInstance.artSepratorImage
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
