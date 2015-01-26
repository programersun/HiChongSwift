//
//  FindAddImageCell.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/17.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class FindAddImageCell: UITableViewCell {
    
    weak var collectionDataSource: FindAddImageSource?
    
    @IBOutlet weak var icyCollectionView: UICollectionView!
    
    class func identifier() -> String {
        return "FindAddImageCellIdentifier"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.LCYThemeColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension FindAddImageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataSource = self.collectionDataSource {
            return 1 + dataSource.addImageCount()
        } else {
            return 1
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(FindAddImageCollectionCell.identifier, forIndexPath: indexPath) as FindAddImageCollectionCell
        if let dataSource = collectionDataSource {
            if indexPath.row < dataSource.addImageCount() {
                cell.icyImageView.contentMode = UIViewContentMode.ScaleAspectFill
                cell.icyImageView.image = dataSource.addImageAt(indexPath.row)
            } else {
                cell.icyImageView.contentMode = UIViewContentMode.Center
                cell.icyImageView.image = UIImage(named: "bigCamera")
            }
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let unwrapped = self.collectionDataSource {
            if indexPath.row == unwrapped.addImageCount() {
                unwrapped.addImageWillTakePicture()
            }
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = UIScreen.mainScreen().bounds.width / 4.0 - 11.0
        return CGSize(width: width, height: width)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
    }
}

protocol FindAddImageSource: class {
    func addImageCount() -> Int
    func addImageAt(index: Int) -> UIImage?
    func addImageWillTakePicture()
}

