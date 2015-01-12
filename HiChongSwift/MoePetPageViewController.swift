//
//  MoePetPageViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/13.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class MoePetPageViewController: UIPageViewController {
    
    var data: [LCYPetDetailPetImages]?
    
    var startIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let data = data {
            let storyBoard = UIStoryboard(name: "Find", bundle: nil)
            let startPage = storyBoard.instantiateViewControllerWithIdentifier("imageVC") as FindTwitterImageViewController
            startPage.index = startIndex
            startPage.MoePetData = data[startIndex]
            setViewControllers([startPage], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
            dataSource = self
            delegate = self
            
            navigationItem.title = "\(startIndex + 1)/\(data.count)"
        } else {
            alert("无法获取图集信息，请退回重试")
        }
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

extension MoePetPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let from = viewController as FindTwitterImageViewController
        let storyBoard = UIStoryboard(name: "Find", bundle: nil)
        let startPage = storyBoard.instantiateViewControllerWithIdentifier("imageVC") as FindTwitterImageViewController
        startPage.index = from.index - 1
        if startPage.index < 0 {
            return nil
        } else {
            startPage.MoePetData = data?[from.index - 1]
            return startPage
        }
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let from = viewController as FindTwitterImageViewController
        let storyBoard = UIStoryboard(name: "Find", bundle: nil)
        let startPage = storyBoard.instantiateViewControllerWithIdentifier("imageVC") as FindTwitterImageViewController
        startPage.index = from.index + 1
        if startPage.index >= data!.count {
            return nil
        } else {
            startPage.MoePetData = data?[from.index + 1]
            return startPage
        }
    }
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
        let vc = pendingViewControllers[0] as FindTwitterImageViewController
        if let data = data {
            navigationItem.title = "\(vc.index + 1)/\(data.count)"
        }
    }
}

