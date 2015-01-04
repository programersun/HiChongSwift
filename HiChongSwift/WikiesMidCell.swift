//
//  WikiesMidCell.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/4.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class WikiesMidCell: UITableViewCell {
    
    @IBOutlet weak var icySegmentedControl: UISegmentedControl!
    class func identifier() -> String {
        return "WikiesMidCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        icySegmentedControl.setBackgroundImage(UIImage(named: "sqSegmentNormal"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        icySegmentedControl.setBackgroundImage(UIImage(named: "sqSegmentSelected"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        icySegmentedControl.setDividerImage(UIImage(named: "sqSegmentNormal"), forLeftSegmentState: UIControlState.Normal, rightSegmentState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        icySegmentedControl.backgroundColor = UIColor(patternImage: UIImage(named: "segmentBackground")!)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
