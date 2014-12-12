//
//  SquareDetailViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/12.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class SquareDetailViewController: UIViewController {
    
    let testText = "子曰：\n“学而时习之，不亦说乎？有朋自远方来，不亦乐乎？人不知而不愠，不亦君子乎？”\n"
                    + "子曰：\n“道千乘之国，敬事而信，节用而爱人，使民以时。”"

    @IBOutlet weak var icyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // tool bar 内容
        let flex1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let comment = UIBarButtonItem(image: UIImage(named: "sqIWantComment"), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        let flex2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let share = UIBarButtonItem(image: UIImage(named: "sqIWantShare"), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SquareDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
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
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(SquareDetailHeadCell.identifier()) as UITableViewCell
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
            case 1:
                cell.cellType = .Phone
            case 2:
                cell.cellType = .Comment
            default:
                break
            }
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier(SquareDetailDynamicCell.identifier()) as UITableViewCell
            let cell = cell as SquareDetailDynamicCell!
            cell.icyLabel.text = testText
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
            let height = (testText as NSString).boundingRectWithSize(CGSize(width:UIScreen.mainScreen().bounds.width - 16.0, height:20000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15.0)], context: nil).height
            return height + 16.0
        default:
            return 44.0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                break
            case 1:
                break
            case 2:
                self.performSegueWithIdentifier("showCommentList", sender: nil)
            default:
                break
            }
        }
    }
}
