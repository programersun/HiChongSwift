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
        
        // 照片墙
        let photoWallStoryBoard = UIStoryboard(name: "PhotoWall", bundle: nil)
        let photoWallVC = photoWallStoryBoard.instantiateInitialViewController() as UINavigationController
        photoWallVC.tabBarItem.title = "首页"
        self.addChildViewController(photoWallVC)

        // 我
        let aboutMeStoryBoard = UIStoryboard(name: "AboutMe", bundle: nil)
        let aboutMeVC = aboutMeStoryBoard.instantiateInitialViewController() as UINavigationController
        aboutMeVC.tabBarItem.title = "我"
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
