//
//  ICYMultiImagePicker.swift
//  MultiImageTest
//
//  Created by eagle on 15/1/23.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import UIKit
import AssetsLibrary

class ICYMultiImagePicker: UIViewController {
    
    /// 最多能选择多少张图片
    var maxSelectNumber = 9
    
    var delegate: ICYMultiImagePickerDelegate?
    
    class CYAsset {
        var asset: ALAsset
        var selected: Bool
        init(asset: ALAsset) {
            self.asset = asset
            selected = false
        }
    }
    
    private weak var numberView: ICYMultiImageGreenCircle?
    private weak var doneButtonItem: UIBarButtonItem?
    private var selectedAsset: [ALAsset] = [ALAsset]() {
        didSet {
            println("result array count is now (\(selectedAsset.count))")
            numberView?.number = selectedAsset.count
            if selectedAsset.count == 0 {
                doneButtonItem?.enabled = false
            } else {
                doneButtonItem?.enabled = true
            }
        }
    }
    
    private var icyNavigation: UINavigationController?
    private var icyCollectionView: UICollectionView?
    private var assetsLibrary = ALAssetsLibrary()
    private var assetsGroup: ALAssetsGroup? {
        didSet {
            if let group = assetsGroup {
                assetsResult = [CYAsset]()
                group.enumerateAssetsUsingBlock({ [weak self](result, _, _) -> Void in
                    if result != nil {
                        let asset = CYAsset(asset: result)
                        self?.assetsResult?.append(asset)
                    } else {
                        self?.icyCollectionView?.reloadData()
                    }
                    return
                })
            }
        }
    }
    private var assetsResult: [CYAsset]?
    
    override init() {
        super.init(nibName: nil, bundle: nil)
        let layout = UICollectionViewFlowLayout()
        icyCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        icyCollectionView?.backgroundColor = UIColor.purpleColor()
        icyCollectionView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        let collectionTop = NSLayoutConstraint(item: icyCollectionView!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
        let collectionBottom = NSLayoutConstraint(item: icyCollectionView!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        let collectionLeading = NSLayoutConstraint(item: icyCollectionView!, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0)
        let collectionTrailing = NSLayoutConstraint(item: icyCollectionView!, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0)
        view.addSubview(icyCollectionView!)
        view.addConstraints([collectionTop, collectionBottom, collectionLeading, collectionTrailing])
        
        icyCollectionView?.registerClass(ICYMultiImageCollectionCell.classForCoder(), forCellWithReuseIdentifier: ICYMultiImageCollectionCell.identifier)
        
        icyCollectionView?.delegate = self
        icyCollectionView?.dataSource = self
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancelButtonPressed:")
        
        assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupSavedPhotos, usingBlock: { [weak self](myGroup, _) -> Void in
            if myGroup != nil {
                // 成功获取用户相册
                self?.assetsGroup = myGroup
            }
            return
        }) { [weak self](_) -> Void in
            // 获取失败
            let alert = UIAlertView(title: nil, message: NSLocalizedString("Can't find photo information", comment: "未能获取您的照片信息"), delegate: self, cancelButtonTitle: "确定")
            alert.delegate = self
            alert.show()
            return
        }
        
        let flex = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: "")
        let numberView = ICYMultiImageGreenCircle(frame: CGRect(origin: CGPointZero, size: CGSize(width: 44.0, height: 44.0)))
        numberView.number = 0
        self.numberView = numberView
        let greenCircle = UIBarButtonItem(customView: numberView)
        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneButtonPressed:")
        done.enabled = false
        doneButtonItem = done
        done.tintColor = ICYMultiImageDoneButtonColor
        setToolbarItems([flex, greenCircle, done], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func show() {
        if icyNavigation == nil {
//            icyNavigation = UINavigationController(rootViewController: self)
            icyNavigation = UINavigationController(navigationBarClass: UINavigationBar.classForCoder(), toolbarClass: UIToolbar.classForCoder())
            icyNavigation?.setToolbarHidden(false, animated: false)
            icyNavigation?.setViewControllers([self], animated: false)
            UIApplication.sharedApplication().delegate?.window??.rootViewController?.presentViewController(icyNavigation!, animated: false, completion: nil)
        }
    }
    func hide() {
        icyNavigation?.dismissViewControllerAnimated(false, completion: nil)
        icyNavigation = nil
    }
    
    /// 不要主动调用这个方法
    func doneButtonPressed(sender: AnyObject) {
        if selectedAsset.count > 0 {
            let myImages = selectedAsset.map({
                (asset) -> UIImage in
                let representtation = asset.defaultRepresentation()
                let myImage = UIImage(CGImage: representtation.fullResolutionImage().takeUnretainedValue())!
                return myImage
            })
            delegate?.ICYMultiImagePickerDidSelectImages(myImages)
        }
        hide()
    }
    
    /// 不要主动调用这个方法
    func cancelButtonPressed(sender: AnyObject) {
        hide()
    }
    
    // FIXME: 最终版需要去掉哦
    deinit {
        println("picker deinit called ------")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ICYMultiImagePicker: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if assetsResult != nil {
            return 1
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = assetsResult {
            return data.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ICYMultiImageCollectionCell.identifier, forIndexPath: indexPath) as ICYMultiImageCollectionCell
        cell.indexPath = indexPath
        cell.delegate = self
        if let data = assetsResult?[indexPath.row]{
            cell.mainImageView?.image = UIImage(CGImage: data.asset.thumbnail().takeUnretainedValue())
            cell.cySelected = data.selected
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = UIScreen.mainScreen().bounds.width / 4.0 - 10.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        if var data = assetsResult?[indexPath.row] {
//            data.selected = !data.selected
//            collectionView.reloadItemsAtIndexPaths([indexPath])
//        }
    }
}

extension ICYMultiImagePicker: ICYMultiImageCellDelegate {
    func cellCheckMarkButtonPressed(index: NSIndexPath) {
        if var data = assetsResult?[index.row] {
            data.selected = !data.selected
            if data.selected {
                if selectedAsset.count >= maxSelectNumber {
                    let alertView = UIAlertView(title: nil, message: "您最多只能选择\(maxSelectNumber)张图片", delegate: nil, cancelButtonTitle: "确定")
                    alertView.show()
                    return
                }
                // 添加到结果数组
                selectedAsset.append(data.asset)
            } else {
                selectedAsset = selectedAsset.filter({ $0 != data.asset })
            }
            icyCollectionView?.reloadItemsAtIndexPaths([index])
        }
    }
}

protocol ICYMultiImagePickerDelegate: class {
    func ICYMultiImagePickerDidSelectImages(images: [UIImage])
}
