//
//  FindPersonalCell.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class FindPersonalCell: UITableViewCell {
    
    @IBOutlet weak var petNickLabel: UILabel!
    
    @IBOutlet weak var icyContentLabel: UILabel!
    
    @IBOutlet private var icyImageViews: [UIImageView]!
    
    var icyImages: [TwitterPersonalImages]? {
        didSet {
            if let images = icyImages {
                for aView in icyImageViews {
                    aView.image = nil
                }
                if images.count == 1 {
                    for aView in icyImageViews {
                        if aView.tag == 1 {
                            aView.setImageWithURL(NSURL(string: images[0].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                        }
                    }
                } else if images.count == 2 {
                    for aView in icyImageViews {
                        if aView.tag == 2 {
                            aView.setImageWithURL(NSURL(string: images[0].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                        }
                        if aView.tag == 3 {
                            aView.setImageWithURL(NSURL(string: images[1].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                        }
                    }
                } else if images.count == 3 {
                    for aView in icyImageViews {
                        if aView.tag == 4 {
                            aView.setImageWithURL(NSURL(string: images[0].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                        }
                        if aView.tag == 5 {
                            aView.setImageWithURL(NSURL(string: images[1].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                        }
                        if aView.tag == 6 {
                            aView.setImageWithURL(NSURL(string: images[2].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                        }
                    }
                } else if images.count >= 4 {
                    for aView in icyImageViews {
                        if aView.tag == 4 {
                            aView.setImageWithURL(NSURL(string: images[0].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                        }
                        if aView.tag == 5 {
                            aView.setImageWithURL(NSURL(string: images[1].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                        }
                        if aView.tag == 6 {
                            aView.setImageWithURL(NSURL(string: images[2].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                        }
                        if aView.tag == 7 {
                            aView.setImageWithURL(NSURL(string: images[3].cutPath.toAbsolutePath()), placeholderImage: UIImage(named: "placeholderLogo"))
                        }
                    }
                }
            } else {
                for aView in icyImageViews {
                    aView.image = nil
                }
            }
        }
    }
    
    class var identifier: String {
        get {
            return "FindPersonalCellIdentifier"
        }
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
