//
//  SquareListViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/11.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareListViewController: UIViewController {

    @IBOutlet weak var icySegmentControl: UISegmentedControl!
    
    @IBOutlet weak var icyTableView: UITableView!
    
    var categoryInfo: LCYGetSquareCategoryListInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.icySegmentControl.setBackgroundImage(UIImage(named: "sqSegmentNormal"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        self.icySegmentControl.setBackgroundImage(UIImage(named: "sqSegmentSelected"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        self.icySegmentControl.setDividerImage(UIImage(named: "sqSegmentNormal"), forLeftSegmentState: UIControlState.Normal, rightSegmentState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        self.icySegmentControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.LCYThemeColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(16.0)], forState: UIControlState.Normal)
        self.icySegmentControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.LCYThemeOrange(), NSFontAttributeName: UIFont.boldSystemFontOfSize(16.0)], forState: UIControlState.Selected)
        
        self.title = self.categoryInfo.cateName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}
