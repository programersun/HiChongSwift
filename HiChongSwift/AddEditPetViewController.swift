//
//  AddEditPetViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/24.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit

class AddEditPetViewController: UIViewController {
    
    enum AddEditPetVCType {
        case Add
        case Edit
    }
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var tagTextBackView: UIView!
    @IBOutlet private weak var tagTextLabel: UILabel!
    
    
    @IBOutlet var roundedViews: [UIView]!
    
    var viewControllerType: AddEditPetVCType = .Add

    @IBOutlet private weak var avatarImageView: UIImageView!
    
    // MARK: - 宠物数据
    var avatarImage: UIImage? {
        didSet {
            if let uImage = avatarImage {
                avatarImageView.contentMode = .ScaleAspectFill
                avatarImageView.image = uImage
            } else {
                avatarImageView.contentMode = .Center
                avatarImageView.image = UIImage(named: "bigCamera")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        switch viewControllerType {
        case .Add:
            navigationItem.title = "添加宠物"
            addRightButton("确定", action: "addConfirmButtonPressed:")
        case .Edit:
            navigationItem.title = "编辑宠物"
        }
        
        contentView.backgroundColor = UIColor.LCYThemeColor()
        view.backgroundColor = UIColor.LCYThemeColor()
        
        for roundView in roundedViews {
            roundView.layer.cornerRadius = 4.0
        }
        
        tagTextBackView.backgroundColor = UIColor.LCYTableLightBlue()
        
        tagTextLabel.textColor = UIColor.LCYThemeOrange()
        
        avatarImage = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func addConfirmButtonPressed(sender: AnyObject) {
        
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
