//
//  AboutMeSwitchCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/23.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class AboutMeSwitchCell: UITableViewCell {
    
    var switchOn: Bool = true {
        didSet {
            icySwitch.on = switchOn
        }
    }
    
    var indexPath: NSIndexPath?
    weak var delegate: AboutMeSwitchCellDelegate?
    
    @IBAction private func switchStatusChanged(sender: UISwitch) {
        if let indexPath = indexPath {
            delegate?.switchStatusChanged(indexPath, isOn: sender.on)
        }
    }
    
    @IBOutlet weak var icyMajorLabel: UILabel!
    @IBOutlet private weak var icyMinorLabel: UILabel!
    @IBOutlet private weak var icySwitch: UISwitch!
    
    var minorText: String? {
        didSet{
            if let text = minorText {
                if text == "" {
                    icyMinorLabel.textColor = UIColor.lightGrayColor()
                    icyMinorLabel.text = "未填写"
                } else {
                    icyMinorLabel.textColor = UIColor.darkTextColor()
                    icyMinorLabel.text = text
                }
            } else {
                icyMinorLabel.textColor = UIColor.lightGrayColor()
                icyMinorLabel.text = "未填写"
            }
        }
    }
    
    class func identifier() -> String {
        return "AboutMeSwitchCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        icyMajorLabel.textColor = UIColor.LCYThemeDarkText()
        icyMinorLabel.textColor = UIColor.lightGrayColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol AboutMeSwitchCellDelegate: class {
    func switchStatusChanged(indexPath: NSIndexPath, isOn: Bool)
}
