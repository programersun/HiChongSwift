//
//  ICYImageBrowser.swift
//  CYImageBrowser
//
//  Created by eagle on 15/1/22.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import UIKit

class ICYImageBrowser: UIPageViewController {
    
    /// 如果没有设置，默认为切换导航栏显示
    func setSingleTapHandler(handler:(() -> Void)?) {
        singleTapHandler = handler
    }
    private var singleTapHandler: (Void -> Void)?
    
    /// 导航栏右侧按钮样式，默认为没有
    func setRightButton(#image: UIImage?, title: String?, handler:((index: Int) -> Void)?) {
        rightButtonHandler = handler
        rightButtonImage = image
        rightButtonTitle = title
    }
    private var rightButtonHandler: ((Int) -> Void)?
    private var rightButtonImage: UIImage?
    private var rightButtonTitle: String?
    
    var imageDataSource: ICYImageBrowserDataSource?
    
    var startIndex: Int = 0
    
    private var icyNavigation: UINavigationController!
    
    convenience init() {
        self.init(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
    }
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [NSObject : AnyObject]?) {
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
            firstPage.image = imageDataSource.icyImageBrowser(self, imageForIndex: startIndex)
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
        hide()
    }
    
    func doubleTapHandler(sender: AnyObject) {
        if let currentPage = viewControllers.first as? ICYImageController {
            currentPage.doubleTapHandler()
        }
    }
    
    func singleTapHandler(sender: AnyObject) {
        if let handler = singleTapHandler {
            handler()
            return
        }
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
    
    func hide() {
        navigationController?.dismissViewControllerAnimated(false, completion: nil)
        icyNavigation = nil
    }
    
    func show() {
        icyNavigation = UINavigationController(rootViewController: self)
        UIApplication.sharedApplication().delegate?.window??.rootViewController?.presentViewController(icyNavigation, animated: false
            , completion: nil)
        if let handler = rightButtonHandler {
            var rightButton: UIBarButtonItem!
            if let image = rightButtonImage {
                rightButton = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "rightButtonHandler:")
            } else if let title = rightButtonTitle {
                rightButton = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: "rightButtonHandler:")
            } else {
                rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "rightButtonHandler:")
            }
            navigationItem.rightBarButtonItem = rightButton
        }
    }
    
    func rightButtonHandler(sender: AnyObject) {
        if let handler = rightButtonHandler {
            if let currentController = viewControllers.first as? ICYImageController {
                handler(currentController.index)
            }
        }
    }
    
    func reloadData() {
        var currentIndex = 0
        if let currentController = viewControllers.first as? ICYImageController {
            currentIndex = currentController.index
        }
        if let icyDataSource = imageDataSource {
            let totalCount = icyDataSource.numberOfImagesInICYImageBrowser(self)
            if totalCount <= 0 {
                hide()
                return
            }
            if currentIndex > totalCount - 1 {
                currentIndex = totalCount - 1
            }
            let newPage = ICYImageController()
            newPage.index = currentIndex
            newPage.imagePath = icyDataSource.icyImageBrowser(self, pathForIndex: newPage.index)
            newPage.image = icyDataSource.icyImageBrowser(self, imageForIndex: newPage.index)
            setViewControllers([newPage], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        navigationItem.title = navigationTitle()
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
                    previous.image = icyDataSource.icyImageBrowser(self, imageForIndex: previous.index)
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
                    next.image = icyDataSource.icyImageBrowser(self, imageForIndex: next.index)
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
    func icyImageBrowser(icyImageBrowser: ICYImageBrowser, pathForIndex pathIndex: Int) -> String?
    func icyImageBrowser(icyImageBrowser: ICYImageBrowser, imageForIndex imageIndex: Int) -> UIImage?
    func icyImageBrowser(icyImageBrowser: ICYImageBrowser, titleForIndex titleIndex: Int) -> String?
}
