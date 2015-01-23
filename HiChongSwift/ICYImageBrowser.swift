//
//  ICYImageBrowser.swift
//  CYImageBrowser
//
//  Created by eagle on 15/1/22.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import UIKit

class ICYImageBrowser: UIPageViewController {
    
    var imageDataSource: ICYImageBrowserDataSource?
    
    var startIndex: Int = 0
    
    private var icyNavigation: UINavigationController!
    
    override init() {
        super.init(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        automaticallyAdjustsScrollViewInsets = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancelButtonPressed:")
        
        dataSource = self
        delegate = self
        
        if let imageDataSource = imageDataSource {
            let imageCount = imageDataSource.numberOfImagesInICYImageBrowser(self)
            assert(startIndex < imageCount, "图片index必须要小于图片数量，请调用之前检查图片数量。")
            let firstPage = ICYImageController()
            firstPage.index = startIndex
            firstPage.imagePath = imageDataSource.icyImageBrowser(self, pathForIndex: startIndex)
            setViewControllers([firstPage], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
            navigationItem.title = navigationTitle()
        }
        
        // 添加手势
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: "doubleTapHandler:")
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "singleTapHandler:")
        tapGesture.requireGestureRecognizerToFail(doubleTapGesture)
        view.addGestureRecognizer(tapGesture)
        
        // 隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func cancelButtonPressed(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(false, completion: nil)
        icyNavigation = nil
    }
    
    func doubleTapHandler(sender: AnyObject) {
        if let currentPage = viewControllers.first as? ICYImageController {
            currentPage.doubleTapHandler()
        }
    }
    
    func singleTapHandler(sender: AnyObject) {
        if let navigationHidden = navigationController?.navigationBarHidden {
            navigationController?.setNavigationBarHidden(!navigationHidden, animated: true)
        }
    }
    
    private func navigationTitle() -> String {
        if let currentPage = viewControllers.first as? ICYImageController {
            if let icyDataSource = imageDataSource {
                return icyDataSource.icyImageBrowser(self, titleForIndex: currentPage.index) ?? "\(currentPage.index + 1)/\(icyDataSource.numberOfImagesInICYImageBrowser(self))"
            }
        }
        return ""
    }
    
    func show() {
        icyNavigation = UINavigationController(rootViewController: self)
        UIApplication.sharedApplication().delegate?.window??.rootViewController?.presentViewController(icyNavigation, animated: false
            , completion: nil)
    }
    
    deinit{
        println("de init called")
    }
}

extension ICYImageBrowser: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let currentController = viewController as? ICYImageController {
            if currentController.index <= 0 {
                return nil
            } else {
                if let icyDataSource = imageDataSource {
                    let previous = ICYImageController()
                    previous.index = currentController.index - 1
                    previous.imagePath = icyDataSource.icyImageBrowser(self, pathForIndex: previous.index)
                    return previous
                } else {
                    return nil
                }
            }
        }
        return nil
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let currentController = viewController as? ICYImageController {
            if let icyDataSource = imageDataSource {
                if currentController.index >= icyDataSource.numberOfImagesInICYImageBrowser(self) - 1 {
                    return nil
                } else {
                    let next = ICYImageController()
                    next.index = currentController.index + 1
                    next.imagePath = icyDataSource.icyImageBrowser(self, pathForIndex: next.index)
                    return next
                }
            } else {
                return nil
            }
        }
        return nil
    }
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        if let currentController = pageViewController.viewControllers.first as? ICYImageController {
            if let icyDataSource = imageDataSource {
                navigationItem.title = navigationTitle()
            }
        }
    }
}

protocol ICYImageBrowserDataSource {
    func numberOfImagesInICYImageBrowser(icyImageBrowser: ICYImageBrowser) -> Int
    func icyImageBrowser(icyImageBrowser: ICYImageBrowser, pathForIndex index: Int) -> String?
    func icyImageBrowser(icyImageBrowser: ICYImageBrowser, titleForIndex index: Int) -> String?
}
