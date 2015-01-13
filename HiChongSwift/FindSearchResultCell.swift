//
//  FindSearchResultCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/17.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit
import CoreLocation

class FindSearchResultCell: UITableViewCell {
    
    @IBOutlet weak var sepratorHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var sepratorImageView: UIImageView!
    
    @IBOutlet private weak var icyAvatarView: UIImageView!
    var icyImagePath: String? {
        didSet {
            if let path = icyImagePath {
                icyAvatarView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "placeholderLogo"))
            }
        }
    }
    
    @IBOutlet private weak var icyGenderImageView: UIImageView!
    var currentGender: icyGender = .Male{
        didSet {
            switch currentGender {
            case .Male:
                icyGenderImageView.image = UIImage(named: "sqMale")
            case .Female:
                icyGenderImageView.image = UIImage(named: "sqFemale")
            case .Unknown:
                icyGenderImageView.image = nil
            }
        }
    }
    
    @IBOutlet weak var icyNickLabel: UILabel!
    
    @IBOutlet weak var icyPetCountLabel: UILabel!
    
    @IBOutlet private weak var icyDistanceLabel: UILabel!
    var location: (latitude: String, longitude: String, myLocation: CLLocation?) = ("0", "0", nil) {
        didSet {
            let dLat: CLLocationDegrees = location.latitude.bridgeToObjectiveC().doubleValue
            let dLon: CLLocationDegrees = location.longitude.bridgeToObjectiveC().doubleValue
            
            if abs(dLat) > 0.001 && abs(dLon) > 0.001 {
                // 真实数据，计算坐标
                if let myLocation = location.myLocation {
                    let geoManager = GeoManager()
                    icyDistanceLabel.text = geoManager.distanceTo(latitude: dLat, longitude: dLon, myLocation: myLocation).toKM()
                } else {
                    icyDistanceLabel.text = ""
                }
            } else {
                // 默认数据，清空显示
                icyDistanceLabel.text = ""
            }
        }
    }
    
    
    @IBOutlet weak var icyTipLabel: UILabel!
    class func identifier() -> String {
        return "FindSearchResultCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.sepratorHeightConstraint.constant = 1.0 / UIScreen.mainScreen().scale
        self.sepratorImageView.image = LCYCommon.sharedInstance.artSepratorImage
        self.backgroundColor = UIColor.LCYThemeColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
