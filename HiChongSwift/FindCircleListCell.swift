//
//  FindCircleListCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/16.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class FindCircleListCell: UITableViewCell {
    
    @IBOutlet private weak var sepratorImageView: UIImageView!
    @IBOutlet private weak var sepratorHeightConstraint: NSLayoutConstraint!
    class func identifier() -> String {
        return "FindCircleListCellIdentifier"
    }
    
    @IBOutlet private weak var icyCollectionView: UICollectionView!
    var upNumber: Int = 0 {
        didSet {
            self.icyCollectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.LCYThemeColor()
        
        self.sepratorHeightConstraint.constant = 1.0 / UIScreen.mainScreen().scale
        self.sepratorImageView.image = UIImage(named: "artSeprator")?.resizableImageWithCapInsets(UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension FindCircleListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upNumber
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("identifier", forIndexPath: indexPath) as UICollectionViewCell
        return cell
    }
}
