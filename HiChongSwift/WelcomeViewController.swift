//
//  WelcomeViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/18.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class WelcomeViewController: UIPageViewController {
    
    private let singlePageIdnetifier = "singlePage"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.LCYThemeColor()
        
        let startPage = self.storyboard?.instantiateViewControllerWithIdentifier(singlePageIdnetifier) as! WelcomeSinglePageViewController
        startPage.pageIndex = 0
        self.setViewControllers([startPage], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        self.dataSource = self
        
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

extension WelcomeViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = (self.viewControllers.first as! WelcomeSinglePageViewController).pageIndex!
        if currentIndex >= 3 {
            return nil
        } else {
            let nextPage = self.storyboard?.instantiateViewControllerWithIdentifier(singlePageIdnetifier) as! WelcomeSinglePageViewController
            nextPage.pageIndex = currentIndex + 1
            return nextPage
        }
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = (self.viewControllers.first as! WelcomeSinglePageViewController).pageIndex!
        if currentIndex <= 0 {
            return nil
        } else {
            let previousPage = self.storyboard?.instantiateViewControllerWithIdentifier(singlePageIdnetifier) as! WelcomeSinglePageViewController
            previousPage.pageIndex = currentIndex - 1
            return previousPage
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 4
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
