//
//  MoePetViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/24.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class MoePetViewController: UICollectionViewController {
    
    var editable: Bool = true
    
    var petId: String?
    
    private var detailInfo: LCYPetDetailBase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        collectionView?.backgroundColor = UIColor.LCYThemeColor()
        
        if let upetID = petId {
            let parameters = [
                "pet_id" : upetID
            ]
            LCYNetworking.sharedInstance.POST(LCYApi.PetGetDetail, parameters: parameters,
                success: { [weak self] (object) -> Void in
                    let info = LCYPetDetailBase.modelObjectWithDictionary(object)
                    if info.result {
                        self?.detailInfo = info
                        self?.collectionView?.reloadData()
                    } else {
                        self?.alert("获取宠物信息失败")
                    }
                    return
                },
                failure: { [weak self] (error) -> Void in
                    self?.alert("未能获取宠物信息，请检查网络状态")
                    return
            })
        } else {
            alert("未能获取宠物信息")
        }
        
        navigationItem.title = "萌宠信息"
        
        if editable {
            addRightButton("编辑", action: "editButtonPressed:")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    // MARK: - Actions
    func editButtonPressed(sender: AnyObject) {
        if detailInfo != nil {
            performSegueWithIdentifier("showEdit", sender: nil)
        } else {
            alert("未能获取到宠物信息")
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "showEdit":
                let destination = segue.destinationViewController as AddEditPetViewController
                destination.viewControllerType = .Edit
                destination.startInfo = detailInfo
            default:
                break
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        if detailInfo != nil {
            return 1
        } else {
            return 0
        }
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        if let detail = detailInfo {
            return detail.petImages.count + 1
        } else {
            return 0
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("camera", forIndexPath: indexPath) as UICollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MoePetImageCell", forIndexPath: indexPath) as MoePetImageCell
            if let info = detailInfo?.petImages[indexPath.row - 1] as? LCYPetDetailPetImages {
                cell.imageView.setImageWithURL(NSURL(string: info.cutImg.toAbsolutePath()))
            }
            return cell
        }
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let reView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "identifier", forIndexPath: indexPath) as MoePetHeaderReusable
        if let detail = detailInfo {
            reView.avatarImagePath = detail.petInfo.headImage.toAbsolutePath()
            reView.detailText = " \(detail.petInfo.age.toAge()) \(detail.petInfo.cateName) "
            reView.gender = detail.petInfo.petSex == "0" ? .Male : .Female
            reView.nameText = detail.petInfo.petName
            reView.statusLable(breeding: detail.petInfo.fHybridization == "1", adopt: detail.petInfo.fAdopt == "1", entrust: detail.petInfo.isEntrust == "1")
            reView.sign = detail.petInfo.sign
        }
        return reView
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}

extension MoePetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = UIScreen.mainScreen().bounds.width
        let sideWidth = screenWidth / 3.0 - 10.0
        return CGSize(width: sideWidth, height: sideWidth)
    }
}
