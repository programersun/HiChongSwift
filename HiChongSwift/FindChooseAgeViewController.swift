//
//  FindChooseAgeViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

protocol FindChooseAgeDelegate: class {
    func chooseAgeDone(#from: Int, to: Int)
}

class FindChooseAgeViewController: UIViewController {
    
    weak var delegate: FindChooseAgeDelegate?

    @IBOutlet private weak var icyPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addRightButton("确定", action: "doneButtonPressed:")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func doneButtonPressed(sender: AnyObject) {
        if let delegate = delegate {
            let from = icyPickerView.selectedRowInComponent(0)
            let to = icyPickerView.selectedRowInComponent(2)
            delegate.chooseAgeDone(from: from, to: to)
        }
        navigationController?.popViewControllerAnimated(true)
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

extension FindChooseAgeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 12
        case 1:
            return 1
        case 2:
            return 12
        default:
            return 0
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == 1 {
            return "~"
        } else {
            if row == 11 {
                return "大于10岁"
            } else if row == 0 {
                return "小于1岁"
            } else {
                return "\(row)岁"
            }
        }
    }
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let screenWidth = UIScreen.mainScreen().bounds.width
        if component == 1 {
            return screenWidth / 5.0
        } else {
            return screenWidth / 5.0 * 2.0
        }
    }
}
