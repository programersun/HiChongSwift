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
        
        reload()
        
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
    private func reload() {
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
    }
    
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
                
            case "toPage":
                let destination = segue.destinationViewController as MoePetPageViewController
                destination.data = detailInfo?.petImages as? [LCYPetDetailPetImages]
                if let indexPath = collectionView?.indexPathsForSelectedItems().first as? NSIndexPath {
                    if editable {
                        destination.startIndex = indexPath.row - 1
                    } else {
                        destination.startIndex = indexPath.row
                    }
                }
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
            if editable {
                return detail.petImages.count + 1
            } else {
                return detail.petImages.count
            }
        } else {
            return 0
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if editable && indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("camera", forIndexPath: indexPath) as UICollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MoePetImageCell", forIndexPath: indexPath) as MoePetImageCell
            if editable {
                if let info = detailInfo?.petImages[indexPath.row - 1] as? LCYPetDetailPetImages {
                    cell.imageView.setImageWithURL(NSURL(string: info.cutImg.toAbsolutePath()))
                }
            } else {
                if let info = detailInfo?.petImages[indexPath.row] as? LCYPetDetailPetImages {
                    cell.imageView.setImageWithURL(NSURL(string: info.cutImg.toAbsolutePath()))
                }
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
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !editable || indexPath.row != 0 {
//            performSegueWithIdentifier("toPage", sender: indexPath)
            let imageBrowser = ICYImageBrowser()
            imageBrowser.imageDataSource = self
            imageBrowser.show()
        }
        if editable && indexPath.row == 0 {
            if petId != nil {
                let actionSheet = UIActionSheet(title: "上传宠物图片", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "我要拍照", "从照片库选取", "取消")
                actionSheet.destructiveButtonIndex = 2
                actionSheet.showInView(self.view)
            }
        }
    }
    
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

extension MoePetViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            // 从照片库选择
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            presentViewController(imagePicker, animated: true, completion: nil)
        case 0:
            // 从相机拍照
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(imagePicker, animated: true, completion: nil)
            break
        default:
            return
        }
    }
}

extension MoePetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        showHUDWithTips("处理中")
        
        let smallImage = UIImage(image: info[UIImagePickerControllerOriginalImage] as UIImage, scaledToFillToSize: CGSize(width: 500, height: 500))
        
        // 处理上传之后，隐藏HUD
        // 上传照片
        let data = UIImageJPEGRepresentation(smallImage, 0.97)
        let parameter = [
            "pet_id": petId!
        ]
        LCYNetworking.sharedInstance.POSTFile(LCYApi.PetUploadPetImage, parameters: parameter, fileKey: "Filedata", fileData: data, fileName: "tiancailcy.jpg", mimeType: LCYMimeType.JPEG, success: { [weak self](object) -> Void in
            self?.hideHUD()
            self?.reload()
            return
        }) { [weak self](error) -> Void in
            self?.hideHUD()
            self?.alert("上传失败，请检查您的网络状况")
            return
        }
    }
}

extension MoePetViewController: ICYImageBrowserDataSource {
    func numberOfImagesInICYImageBrowser(icyImageBrowser: ICYImageBrowser) -> Int {
        if let data = detailInfo?.petImages as? [LCYPetDetailPetImages] {
            return data.count
        } else {
            return 0
        }
    }
    func icyImageBrowser(icyImageBrowser: ICYImageBrowser, titleForIndex index: Int) -> String? {
        return nil
    }
    func icyImageBrowser(icyImageBrowser: ICYImageBrowser, pathForIndex index: Int) -> String? {
        if let data = detailInfo?.petImages as? [LCYPetDetailPetImages] {
            return data[index].petImg.toAbsolutePath()
        } else {
            return nil
        }
    }
    func icyImageBrowser(icyImageBrowser: ICYImageBrowser, imageForIndex imageIndex: Int) -> UIImage? {
        return nil
    }
}

