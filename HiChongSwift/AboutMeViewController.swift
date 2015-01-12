//
//  AboutMeViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/18.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit
import CoreData

class AboutMeViewController: UITableViewController {
    
    private enum AboutMeType {
        case Me
        case Other
    }
    private var currentType: AboutMeType = .Me
    
    var otherUserID: String? {
        didSet {
            if let userID = otherUserID {
                currentType = .Other
            }
        }
    }
    
    private let cannotSee = "该用户隐藏了这一项。"
    private let didnotFill = "用户未填写"
    
    private var userInfo: GetUserInfoBase?
    
    
    private var clawHeaderView: UIView!
    private var addPetView: UIView!
    @IBOutlet private weak var addPetButton: UIButton!
    @IBOutlet private weak var clawHeaderLabel: UILabel!
    
    private var onceToken: dispatch_once_t = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if currentType == .Me {
            let rightButton = UIButton()
            rightButton.setImage(UIImage(named: "ProfileEditButton"), forState: UIControlState.Normal)
            rightButton.addTarget(self, action: "rightButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            rightButton.sizeToFit()
            let rightItem = UIBarButtonItem(customView: rightButton)
            navigationItem.rightBarButtonItem = rightItem
            
            let leftButton = UIButton()
            leftButton.setImage(UIImage(named: "settingButton"), forState: UIControlState.Normal)
            leftButton.addTarget(self, action: "leftButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            leftButton.sizeToFit()
            let leftItem = UIBarButtonItem(customView: leftButton)
            navigationItem.leftBarButtonItem = leftItem
        }
        
        
        let nib = UINib(nibName: "AboutMePetHeaderView", bundle: nil)
        clawHeaderView = nib.instantiateWithOwner(self, options: nil).first as UIView?
        clawHeaderLabel.textColor = UIColor.LCYThemeOrange()
        clawHeaderView.backgroundColor = UIColor.LCYTableLightGray()
        clawHeaderView.bounds.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: 30.0)
        
        let addPetNib = UINib(nibName: "AboutMeFooter", bundle: nil)
        addPetView = addPetNib.instantiateWithOwner(self, options: nil).first as UIView?
        addPetButton.layer.cornerRadius = 4.0
        addPetButton.backgroundColor = UIColor.LCYThemeOrange()
        addPetView.bounds.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: 60.0)
        addPetView.backgroundColor = UIColor.LCYThemeColor()
        addPetView.layoutIfNeeded()
        
        navigationItem.title = ""
        // 添加下拉刷新
        tableView.addHeaderWithCallback { [weak self] () -> Void in
            self?.reloadInitData()
            return
        }
        tableView.baseTextColor = UIColor.whiteColor();
        tableView.backgroundColor = UIColor.LCYThemeColor()
        
        reloadInitData()
        
    }
    
    private func reloadInitData() {
        var parameter: [String: String]
        if currentType == .Me {
            parameter = ["user_name": LCYCommon.sharedInstance.userName!]
        } else {
            parameter = ["user_name": otherUserID!]
        }
        LCYNetworking.sharedInstance.POST(LCYApi.UserGetInfo, parameters: parameter, success: { [weak self] (object) -> Void in
            self?.userInfo = GetUserInfoBase.modelObjectWithDictionary(object)
            if let result = self?.userInfo?.result {
                if result {
                    self?.navigationItem.title = self?.userInfo?.userInfo.nickName
                    self?.tableView.reloadData()
                    if self?.currentType == AboutMeType.Me {
                        self?.addFooter()
                    }
                } else {
                    self?.alert("加载失败")
                }
            }
            self?.tableView.headerEndRefreshing()
            return
            }) { [weak self](error) -> Void in
                self?.tableView.headerEndRefreshing()
                return
        }
    }
    
    private func addFooter() {
        dispatch_once(&onceToken, { [weak self] () -> Void in
            self?.addPetView.frame.origin = CGPoint(x: 0, y: 0)
            self?.tableView.tableFooterView = self?.addPetView
            return
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showEdit":
                let destination = segue.destinationViewController as AboutMeEditProfileViewController
                destination._userInfo = userInfo?.userInfo
            case "showMoePet":
                let destination = segue.destinationViewController as MoePetViewController
                if let indexPath = tableView.indexPathForSelectedRow() {
                    let petInfo = userInfo?.petInfo[indexPath.row] as? GetUserInfoPetInfo
                    destination.petId = petInfo?.petId
                }
                if currentType == .Other {
                    destination.editable = false
                }
            case "showAdd":
                let destination = segue.destinationViewController as AddEditPetViewController
                destination.delegate = self
            case "showSetting":
                let destination = segue.destinationViewController as AboutMeSettingViewController
            default:
                break
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addPetButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("showAdd", sender: nil)
    }
    
    func rightButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("showEdit", sender: nil)
    }
    
    func leftButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("showSetting", sender: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        if let data = userInfo {
            return 4
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 4
        case 3:
            return userInfo!.petInfo.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(AboutMeHeaderCell.identifier()) as UITableViewCell
            let cell = cell as AboutMeHeaderCell
            if let imagePath = userInfo?.userInfo.headImage {
                cell.avatarImagePath = imagePath.toAbsolutePath()
            }
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(AboutMeLikeCell.identifier()) as UITableViewCell
            let cell = cell as AboutMeLikeCell
            if let info = userInfo {
                let decimal = "."
                cell.likeLabel.text = "\(info.userInfo.starCount.format(decimal))"
                cell.fansLabel.text = info.userInfo.fansCount
                cell.careLabel.text = info.userInfo.friendCount
            }
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("AboutMeProfileCellIdentifier") as UITableViewCell
            cell.textLabel?.textColor = UIColor.LCYThemeDarkText()
            switch indexPath.row % 2 {
            case 0:
                cell.backgroundColor = UIColor.LCYTableLightGray()
            case 1:
                cell.backgroundColor = UIColor.LCYTableLightBlue()
            default:
                break
            }
            
            switch indexPath.row {
            case 0:
                cell.imageView?.image = UIImage(named: "AboutMeMid1")
                if userInfo?.userInfo.fTip == "1" {
                    if let text = userInfo?.userInfo.tip {
                        cell.textLabel?.text = text
                    } else {
                        cell.textLabel?.textColor = UIColor.lightGrayColor()
                        cell.textLabel?.text = didnotFill
                    }
                } else {
                    cell.textLabel?.textColor = UIColor.lightGrayColor()
                    cell.textLabel?.text = cannotSee
                }
            case 1:
                cell.imageView?.image = UIImage(named: "AboutMeMid2")
                if userInfo?.userInfo.fLocation == "1" {
                    let province = userInfo!.userInfo.province
                    let city = userInfo!.userInfo.city
                    let town = userInfo!.userInfo.town
                    var provinceText: String? = ""
                    var cityText: String? = ""
                    var townText: String? = ""
                    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                    let context = appDelegate.managedObjectContext!
                    let fetchRequset = NSFetchRequest()
                    let entity = NSEntityDescription.entityForName("Region", inManagedObjectContext: context)
                    fetchRequset.entity = entity
                    let predicate = NSPredicate(format: "region_id == %@ OR region_id == %@ OR region_id == %@", argumentArray:[province, city, town])
                    fetchRequset.predicate = predicate
                    var error: NSError? = nil
                    let result = context.executeFetchRequest(fetchRequset, error: &error)
                    if let entities = result {
                        for regionEntity in entities as [Region] {
                            switch regionEntity.region_id {
                            case province.toInt()!:
                                provinceText = regionEntity.region_name
                            case city.toInt()!:
                                cityText = regionEntity.region_name
                            case town.toInt()!:
                                townText = regionEntity.region_name
                            default:
                                break
                            }
                        }
                    } else {
                        println("error!===>\(error)")
                    }
                    if let townText = townText {
                        cell.textLabel?.text = "\(provinceText!) \(cityText!) \(townText)"
                    } else {
                        cell.textLabel?.text = "\(provinceText!) \(cityText!)"
                    }
                } else {
                    cell.textLabel?.textColor = UIColor.lightGrayColor()
                    cell.textLabel?.text = cannotSee
                }
            case 2:
                cell.imageView?.image = UIImage(named: "AboutMeMid3")
                if userInfo?.userInfo.fTelephone == "1" {
                    if let text = userInfo?.userInfo.telephone {
                        cell.textLabel?.text = text
                    } else {
                        cell.textLabel?.textColor = UIColor.lightGrayColor()
                        cell.textLabel?.text = didnotFill
                    }
                } else {
                    cell.textLabel?.textColor = UIColor.lightGrayColor()
                    cell.textLabel?.text = cannotSee
                }
            case 3:
                cell.imageView?.image = UIImage(named: "AboutMeMid4")
                if userInfo?.userInfo.fCellphone == "1" {
                    if let text = userInfo?.userInfo.userName {
                        cell.textLabel?.text = text
                    } else {
                        cell.textLabel?.textColor = UIColor.lightGrayColor()
                        cell.textLabel?.text = didnotFill
                    }
                } else {
                    cell.textLabel?.textColor = UIColor.lightGrayColor()
                    cell.textLabel?.text = cannotSee
                }
            default:
                break
            }
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier(AboutMePetCell.identifier()) as UITableViewCell
            let cell = cell as AboutMePetCell
            let info = userInfo?.petInfo[indexPath.row] as GetUserInfoPetInfo
            cell.avatarImagePath = info.headImage.toAbsolutePath()
            cell.detailText = " \(info.age.toAge()) \(info.name) "
            cell.gender = info.petSex == "0" ? .Male : .Female
            cell.nameText = info.petName
            cell.statusLable(breeding: info.fHybridization == "1", adopt: info.fAdopt == "1", entrust: info.isEntrust == "1")
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 85.0
        case 1:
            return 40.0
        case 2:
            return 44.0
        case 3:
            return 70.0
        default:
            return 0.0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 3:
            return clawHeaderView
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 3:
            return 30.0
        default:
            return 0.0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 3 {
            self.performSegueWithIdentifier("showMoePet", sender: nil)
        }
    }
}

extension AboutMeViewController: AddPetDelegate {
    func addPetDone() {
        reloadInitData()
    }
}
