//
//  MainViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/4.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(12), NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(12), NSForegroundColorAttributeName: UIColor.LCYThemeDarkText()], forState: UIControlState.Selected)
        
        UITabBar.appearance().barTintColor = UIColor.LCYTabBarBarTintColor()
        UITabBar.appearance().tintColor = UIColor.LCYThemeDarkText()

        // 发现
        let findStoryBoard = UIStoryboard(name: "Find", bundle: nil)
        let findVC = findStoryBoard.instantiateInitialViewController() as UINavigationController
        findVC.tabBarItem.title = "发现"
        findVC.tabBarItem.image = UIImage(named: "find")
        self.addChildViewController(findVC)
        
        // 广场
        let squareStoryBoard = UIStoryboard(name: "Square", bundle: nil)
        let squareVC = squareStoryBoard.instantiateInitialViewController() as UINavigationController
        squareVC.tabBarItem.title = "广场"
        squareVC.tabBarItem.image = UIImage(named: "square")
        self.addChildViewController(squareVC)
        
        // 百科
        let wikiStoryBoard = UIStoryboard(name: "Wiki", bundle: nil)
        let wikiVC = wikiStoryBoard.instantiateInitialViewController() as UINavigationController
        wikiVC.tabBarItem.title = "百科"
        wikiVC.tabBarItem.image = UIImage(named: "wiki")
        self.addChildViewController(wikiVC)
        
        // 特卖
        let saleStoryBoard = UIStoryboard(name: "Sale", bundle: nil)
        let saleVC = saleStoryBoard.instantiateInitialViewController() as UINavigationController
        saleVC.tabBarItem.title = "特卖"
        saleVC.tabBarItem.image = UIImage(named: "sale")
        self.addChildViewController(saleVC)
        
        // 我
        let aboutMeStoryBoard = UIStoryboard(name: "AboutMe", bundle: nil)
        let aboutMeVC = aboutMeStoryBoard.instantiateInitialViewController() as UINavigationController
        aboutMeVC.tabBarItem.title = "我"
        aboutMeVC.tabBarItem.image = UIImage(named: "me")
        self.addChildViewController(aboutMeVC)
        
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
