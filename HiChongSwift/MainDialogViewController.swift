//
//  MainDialogViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/14.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class MainDialogViewController: UIViewController {
    
    weak var delegate: mainDialogDelegate?
    
    @IBOutlet var icyButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backgroundTouched(sender: AnyObject) {
        view.removeFromSuperview()
        delegate?.mainDialogDidCancel(self)
    }
    
    @IBAction func textButtonPressed(sender: AnyObject) {
        view.removeFromSuperview()
        delegate?.mainDialogTextButtonPressed(self)
    }
    
    
    @IBAction func mixButtonPressed(sender: AnyObject) {
        view.removeFromSuperview()
        delegate?.mainDialogMixButtonPressed(self)
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

protocol mainDialogDelegate: class {
    func mainDialogDidCancel(viewController: MainDialogViewController)
    func mainDialogTextButtonPressed(viewController: MainDialogViewController)
    func mainDialogMixButtonPressed(viewController: MainDialogViewController)
}
