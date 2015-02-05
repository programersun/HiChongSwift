//
//  SquareListViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/11.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit
import CoreLocation

class SquareListViewController: UIViewController {
    
    @IBOutlet weak var icySegmentControl: UISegmentedControl!
    
    @IBOutlet weak var icyTableView: UITableView!
    
    var categoryInfo: SquareHomeCategory?
    
    
    private enum squareListType: Int {
        case distance   = 1
        case star       = 2
    }
    private var currentType: squareListType = .distance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        icyTableView.backgroundColor = UIColor.LCYThemeColor()
        
        icySegmentControl.setBackgroundImage(UIImage(named: "sqSegmentNormal"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        icySegmentControl.setBackgroundImage(UIImage(named: "sqSegmentSelected"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        icySegmentControl.setDividerImage(UIImage(named: "sqSegmentNormal"), forLeftSegmentState: UIControlState.Normal, rightSegmentState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        icySegmentControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.LCYThemeDarkText(), NSFontAttributeName: UIFont.boldSystemFontOfSize(16.0)], forState: UIControlState.Normal)
        icySegmentControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.LCYThemeOrange(), NSFontAttributeName: UIFont.boldSystemFontOfSize(16.0)], forState: UIControlState.Selected)
        
        navigationItem.title = categoryInfo?.cateName
        
        LCYCommon.sharedInstance.getLocation({ [weak self](location) -> Void in
            self?.location = location
            self?.tryToReload()
            return
            }, fail: { [weak self]() -> Void in
                self?.alert("请允许程序进行定位。")
                return
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    private var location: CLLocation?
    private func tryToReload() {
        
        if let category = categoryInfo {
            if location != nil {
                if let regionID = LCYCommon.sharedInstance.regionID {
                    reload()
                } else {
                    let geoManager = GeoManager()
                    geoManager.reverse(location!, completionHandler: { [weak self](region) -> () in
                        if let uregion = region {
                            LCYCommon.sharedInstance.regionID = uregion.region_id.stringValue
                            self?.reload()
                        } else {
                            self?.alert("无法获取城市信息，请自行选择定位")
                        }
                        return
                    })
                }
                
            } else {
                alert("定位失败")
            }
        } else {
            alert("信息加载失败")
        }
    }
    
    private var distanceData: [SquareGetListMsg]?
    private var starData: [SquareGetListMsg]?
    
    private func reload() {
        let parameters: [String: String] = [
            "type":         "\(currentType.rawValue)",
            "latitude":     "\(location!.coordinate.latitude)",
            "longitude":    "\(location!.coordinate.longitude)",
            "city":         LCYCommon.sharedInstance.regionID!,
            "page":         "0",
            "category":     categoryInfo!.cateId
        ]
        
        loadDataWithParameters(parameters, append: false)
    }
    
    private func loadDataWithParameters(parameter: [String: String], append: Bool) {
        
        typealias mySuccessClosure = ((object: NSDictionary) -> Void)
        var successClosure: mySuccessClosure?
        
        switch currentType {
        case .distance:
            successClosure = {
                [weak self] (object: NSDictionary) -> Void in
                let retrieved = SquareGetListBase.modelObjectWithDictionary(object)
                if retrieved.result {
                    if !append {
                        self?.distanceData = retrieved.msg as? [SquareGetListMsg]
                    } else {
                        if self?.distanceData != nil {
                            if let data = retrieved.msg as? [SquareGetListMsg] {
                                self?.distanceData?.extend(data)
                            }
                        }
                    }
                }
                if self?.currentType == squareListType.distance {
                    self?.icyTableView.reloadData()
                }
                return
            }
            break
        case .star:
            successClosure = {
                [weak self] (object: NSDictionary) -> Void in
                let retrieved = SquareGetListBase.modelObjectWithDictionary(object)
                if retrieved.result {
                    if !append {
                        self?.starData = retrieved.msg as? [SquareGetListMsg]
                    } else {
                        if self?.starData != nil {
                            if let data = retrieved.msg as? [SquareGetListMsg] {
                                self?.starData?.extend(data)
                            }
                        }
                    }
                }
                if self?.currentType == squareListType.star {
                    self?.icyTableView.reloadData()
                }
                return
            }
            break
        }
        
        LCYNetworking.sharedInstance.POST(LCYApi.SquaregetSquareList, parameters: parameter, success: successClosure) { [weak self](error) -> Void in
            self?.alert("网络状态欠佳")
            return
        }
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            currentType = .distance
            if distanceData == nil {
                tryToReload()
            }
        } else {
            currentType = .star
            if starData == nil {
                tryToReload()
            }
        }
        icyTableView.reloadData()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "showDetail":
                let destination = segue.destinationViewController as SquareDetailViewController
                if let indexPath = icyTableView.indexPathForSelectedRow() {
                    var data: SquareGetListMsg
                    switch currentType {
                    case .distance:
                        data = distanceData![indexPath.row]
                    case .star:
                        data = starData![indexPath.row]
                    }
                    destination.merchantID = "\(data.businessId)"
                }
            default:
                break
            }
        }
    }
    
}

extension SquareListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentType {
        case .distance:
            if let data = distanceData {
                return data.count
            } else {
                return 0
            }
        case .star:
            if let data = starData {
                return data.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SquareListCell.identifier()) as SquareListCell
        switch indexPath.row % 2 {
        case 0:
            cell.backgroundColor = UIColor.LCYTableLightGray()
        case 1:
            cell.backgroundColor = UIColor.LCYTableLightBlue()
        default:
            break
        }
        
        var data: SquareGetListMsg
        switch currentType {
        case .distance:
            data = distanceData![indexPath.row]
        case .star:
            data = starData![indexPath.row]
        }
        cell.nameLabel.text = data.businessName
        cell.detailLabel.text = data.businessBrief
        let dot2format = ".1"
        cell.distanceLabel.text = data.distance.toKM()
        cell.icyScore = CGFloat(data.businessScore)
        
        cell.imagePath = data.businessImage.toAbsolutePath()
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: nil)
    }
}
