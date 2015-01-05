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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
    private var location: CLLocationCoordinate2D!
    private func tryToReload() {
        if let category = categoryInfo {
            reload()
        } else {
            alert("信息加载失败")
        }
    }
    
    private func reload() {
        let parameters: [String: String] = [
            "type":         "1",
            "latitude":     "\(location.latitude)",
            "longitude":    "\(location.longitude)",
            "city":         "245",
            "page":         "0",
            "category":     categoryInfo!.cateId
        ]
        
        LCYNetworking.sharedInstance.POST(LCYApi.SquaregetSquareList, parameters: parameters, success: { (object) -> Void in
            return
            }) { (error) -> Void in
                return
        }
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

extension SquareListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
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
        cell.icyScore = 0.5 * CGFloat(indexPath.row)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 76.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: nil)
    }
}
