//
//  SquareDetailViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/12.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit
import CoreLocation

class SquareDetailViewController: UIViewController {
    
    
    @IBOutlet weak var icyTableView: UITableView!
    
    /// 商家ID
    var merchantID: String?
    
    /// 用户所在的地理位置
    private var currentLocation: CLLocation?
    
    /// 商家信息
    private var merchantData: SquareMerchantInfoBase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // tool bar 内容
        let flex1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let comment = UIBarButtonItem(image: UIImage(named: "sqIWantComment"), style: UIBarButtonItemStyle.Plain, target: self, action: "wantCommentButtonPressed:")
        let flex2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let share = UIBarButtonItem(image: UIImage(named: "sqIWantShare"), style: UIBarButtonItemStyle.Plain, target: self, action: "wantShareButtonPressed:")
        let flex3 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        self.setToolbarItems([flex1, comment, flex2, share, flex3], animated: false)
        
        // tool bar 颜色
        self.navigationController?.toolbar.barTintColor = UIColor.LCYTabBarBarTintColor()
        self.navigationController?.toolbar.tintColor = UIColor.whiteColor()
        
        // 去掉多余的线
        let emptyView = UIView(frame: CGRectZero)
        self.icyTableView.tableFooterView = emptyView
        
        // 背景颜色
        self.icyTableView.backgroundColor = UIColor.LCYThemeColor()
        
        self.title = "详情"
        
        if merchantID == nil {
            alert("无法获取商家信息")
        } else {
            reload()
        }
        
        LCYCommon.sharedInstance.getLocation({ [weak self](location) -> Void in
            self?.currentLocation = location
            self?.icyTableView.reloadData()
            }, fail: { [weak self]() -> Void in
                self?.alert("无法获取定位坐标")
                return
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    
    func wantCommentButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("showAdd", sender: nil)
    }

    var shareVC: ICYShareViewController?
    func wantShareButtonPressed(sender: AnyObject) {
        if let data = merchantData {
            // 暂时屏蔽分享功能
            shareVC = UIStoryboard(name: "ICYShare", bundle: nil).instantiateInitialViewController() as? ICYShareViewController
            if let shareVC = shareVC {
                shareVC.messageDescription = "向您推荐商家：\n\(data.msg.businessName)"
                UIApplication.sharedApplication().delegate?.window??.addSubview(shareVC.view)
            }
        }
    }
    
    private func reload() {
        LCYNetworking.sharedInstance.POST(LCYApi.SquareMerchantInfo, parameters: ["business_id": merchantID!], success: { [weak self](object) -> Void in
            let retrieved = SquareMerchantInfoBase.modelObjectWithDictionary(object)
            if retrieved.result {
                self?.merchantData = retrieved
                self?.icyTableView.reloadData()
            }
            return
            }) { [weak self](error) -> Void in
                self?.alert("网络连接异常，请重试")
                return
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "showAdd":
                let destination = segue.destinationViewController as SquareCommentViewController
                destination.businessID = merchantID
                destination.businessName = merchantData?.msg.businessName
            case "showCommentList":
                let destination = segue.destinationViewController as SquareCommentListViewController
                destination.businessID = merchantID
                destination.businessName = merchantData?.msg.businessName
            case "showMap":
                let destination = segue.destinationViewController as SquareMapViewController
                destination.businessData = merchantData?.msg
            default:
                break
            }
        }
    }
}

extension SquareDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if merchantData == nil {
            return 0
        } else {
            return 3
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 1
        default:
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        let data = merchantData!.msg
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(SquareDetailHeadCell.identifier()) as UITableViewCell
            let cell = cell as SquareDetailHeadCell
            cell.imagePath = data.businessImage.toAbsolutePath()
            cell.icyTitleLabel.text = data.businessName
            cell.icyScore = CGFloat((data.businessScore as NSString).floatValue)
            if let location = currentLocation {
                let geoManager = GeoManager()
                cell.distanceLabel.text = geoManager.distanceTo(latitude: (data.businessLatitude as NSString).doubleValue, longitude: (data.businessLongitude as NSString).doubleValue, myLocation: location).toKM()
            } else {
                cell.distanceLabel.text = "0.0km"
            }
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(SquareDetailMiddleCell.identifier()) as UITableViewCell
            // 设置背景颜色
            switch indexPath.row % 2 {
            case 0:
                cell.backgroundColor = UIColor.LCYTableLightGray()
            case 1:
                cell.backgroundColor = UIColor.LCYTableLightBlue()
            default:
                break
            }
            // 设置内容
            let cell = cell as SquareDetailMiddleCell
            switch indexPath.row {
            case 0:
                cell.cellType = .Location
                cell.icyLabel.text = data.businessLocation
            case 1:
                cell.cellType = .Phone
                cell.icyLabel.text = data.businessPhone
            case 2:
                cell.cellType = .Comment
                cell.icyLabel.text = "共计\(data.commentCount)条评论"
            default:
                break
            }
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(SquareDetailDynamicCell.identifier()) as UITableViewCell
            let cell = cell as SquareDetailDynamicCell!
            cell.icyLabel.text = data.businessDetail
        default:
            break
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100.0
        case 1:
            return 44.0
        case 2:
            // 计算高度
            let data = merchantData!.msg
            let height = (data.businessDetail as NSString).boundingRectWithSize(CGSize(width:UIScreen.mainScreen().bounds.width - 16.0, height:20000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15.0)], context: nil).height
            return height + 16.0
        default:
            return 44.0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                performSegueWithIdentifier("showMap", sender: nil)
            case 1:
                let phone = merchantData!.msg.businessPhone
                if let telURL = NSURL(string:"telprompt:\(phone)") {
                    UIApplication.sharedApplication().openURL(telURL)
                }
            case 2:
                self.performSegueWithIdentifier("showCommentList", sender: nil)
            default:
                break
            }
        }
    }
}
