//
//  WelcomeSinglePageViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/18.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class WelcomeSinglePageViewController: UIViewController {

    @IBOutlet weak var icyImageView: UIImageView!
    
    @IBOutlet private weak var enterButton: UIButton!
    
    var pageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let index = self.pageIndex {
            self.icyImageView.image = UIImage(named: "Guide\(index + 1)")
            if index == 3 {
                self.enterButton.hidden = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enterButtonPressed(sender: AnyObject) {
        LCYCommon.sharedInstance.welcomeGuide = true
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        appDelegate.window?.rootViewController = (storyBoard.instantiateInitialViewController() as! UIViewController)
    }
}
