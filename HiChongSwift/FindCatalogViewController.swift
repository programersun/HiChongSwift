//
//  FindCatalogViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/17.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit
import CoreLocation

class FindCatalogViewController: UITableViewController {
    
    private var location: CLLocation?
    
    class catalogData {
        var fansData: UserFansFriendsMsg
        var distance: String = ""
        init(fansData: UserFansFriendsMsg, distance: String = "") {
            self.fansData = fansData
            self.distance = distance
        }
    }
    
    private var fansDataV2: [catalogData]?
    private var friendsDataV2: [catalogData]?
    
//    private var fansData: [UserFansFriendsMsg]?
//    private var friendsData: [UserFansFriendsMsg]?
//    
    @IBOutlet private weak var icySegmentControl: UISegmentedControl!
    private enum FindCatalogType {
        case fans
        case care
    }
    
    private var currentType: FindCatalogType = FindCatalogType.fans {
        didSet {
            tableView.reloadData()
            switch currentType {
            case .fans:
                if fansDataV2 == nil {
                    reload()
                }
            case .care:
                if friendsDataV2 == nil {
                    reload()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "宠友录"
        
//        self.tableView.backgroundColor = UIColor.LCYThemeColor()
        self.tableView.hideExtraSeprator()
        
        showHUD()
        
        LCYCommon.sharedInstance.getLocation({ [weak self](location) -> Void in
            self?.location = location
            self?.reload()
            return
            }, fail: { [weak self]() -> Void in
                self?.alert("无法获取您的地理位置信息。")
                return
        })
        
//        reload()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    private func reload() {
        let parameter = [
            "user_id"   : LCYCommon.sharedInstance.userName!
        ]
        switch currentType {
        case .fans:
            LCYNetworking.sharedInstance.POST(LCYApi.UserFansList, parameters: parameter, success: { [weak self](object) -> Void in
                let retrieved = UserFansFriendsBase.modelObjectWithDictionary(object)
                if retrieved.result {
//                    self?.fansData = [UserFansFriendsMsg]()
//                    self?.fansData?.extend(retrieved.msg as [UserFansFriendsMsg])

                    
                    self?.fansDataV2 = [catalogData]()
                    self?.fansDataV2?.extend((retrieved.msg as [UserFansFriendsMsg]).map({
                        let data = catalogData(fansData: $0)
                        if let location = self?.location {
                            let geoManager = GeoManager()
                            if abs($0.latitude.bridgeToObjectiveC().doubleValue) > 0.001 && abs($0.longitude.bridgeToObjectiveC().doubleValue) > 0.001 {
                                data.distance = geoManager.distanceTo(latitude: $0.latitude.bridgeToObjectiveC().doubleValue, longitude: $0.longitude.bridgeToObjectiveC().doubleValue, myLocation: location).toKM()
                            }
                        }
                        return data
                    }))
                    
                    if self?.currentType == FindCatalogType.fans {
                        self?.tableView.reloadData()
                    }
                    self?.icySegmentControl.setTitle("粉丝 \(retrieved.msg.count)", forSegmentAtIndex: 0)
                }
                self?.hideHUD()
                return
                }, failure: { [weak self](error) -> Void in
                    self?.hideHUD()
                    return
            })
            fallthrough
        case .care:
            LCYNetworking.sharedInstance.POST(LCYApi.UserFriendList, parameters: parameter, success: { [weak self](object) -> Void in
                let retrieved = UserFansFriendsBase.modelObjectWithDictionary(object)
                if retrieved.result {
//                    self?.friendsData = [UserFansFriendsMsg]()
//                    self?.friendsData?.extend(retrieved.msg as [UserFansFriendsMsg])
                    
                    
                    self?.friendsDataV2 = [catalogData]()
                    self?.friendsDataV2?.extend((retrieved.msg as [UserFansFriendsMsg]).map({
                        let data = catalogData(fansData: $0)
                        if let location = self?.location {
                            let geoManager = GeoManager()
                            if abs($0.latitude.bridgeToObjectiveC().doubleValue) > 0.001 && abs($0.longitude.bridgeToObjectiveC().doubleValue) > 0.001 {
                                data.distance = geoManager.distanceTo(latitude: $0.latitude.bridgeToObjectiveC().doubleValue, longitude: $0.longitude.bridgeToObjectiveC().doubleValue, myLocation: location).toKM()
                            }
                        }
                        return data
                    }))
                    
                    
                    if self?.currentType == FindCatalogType.care {
                        self?.tableView.reloadData()
                    }
                    self?.icySegmentControl.setTitle("关注 \(retrieved.msg.count)", forSegmentAtIndex: 1)
                }
                self?.hideHUD()
                return
                }, failure: { [weak self](error) -> Void in
                    self?.hideHUD()
                    return
            })
        }
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        currentType = sender.selectedSegmentIndex == 0 ? .fans : .care
    }
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch currentType {
        case .fans:
            if let data = fansDataV2 {
                return data.count
            } else {
                return 0
            }
        case .care:
            if let data = friendsDataV2 {
                return data.count
            } else {
                return 0
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier(FindCatalogCell.identifier(), forIndexPath: indexPath) as FindCatalogCell
        let cell = tableView.dequeueReusableCellWithIdentifier(FindCatelogWhiteCell.identifier) as FindCatelogWhiteCell
        // Configure the cell...
//        var data: UserFansFriendsMsg
        var data: catalogData
        switch currentType {
        case .fans:
            data = fansDataV2![indexPath.row]
        case .care:
            data = friendsDataV2![indexPath.row]
        }
//        cell.icyImagePath = data.headImage.toAbsolutePath()
//        cell.gender = data.sex == "0" ? .Male : .Female
//        cell.nickNameLabel.text = data.nickName
//        cell.signLabel.text = data.tip
//        cell.petCount = data.petCount
        cell.keeperAvatarPath = data.fansData.headImage.toAbsolutePath()
        cell.keeperGender = FindCatelogWhiteCell.cateGender(pValue: data.fansData.sex)
        cell.userNameLabel.text = data.fansData.nickName
        cell.petImagePaths = (data.fansData.pets as? [UserFansFriendsPets])?
            .map({
                $0.headImage.toAbsolutePath()
        })
        cell.distanceLabel.text = data.distance
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var data: UserFansFriendsMsg
        switch currentType {
        case .fans:
            data = fansDataV2![indexPath.row].fansData
        case .care:
            data = friendsDataV2![indexPath.row].fansData
        }
        
        let storyBoard = UIStoryboard(name: "AboutMe", bundle: nil)
        let controller = storyBoard.instantiateViewControllerWithIdentifier("userInfo") as AboutMeViewController
        
        controller.otherUserID = data.userId

        navigationController?.pushViewController(controller, animated: true)
    }
    
}
