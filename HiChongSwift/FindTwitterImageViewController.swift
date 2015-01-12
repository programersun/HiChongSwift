//
//  FindTwitterImageViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class FindTwitterImageViewController: UIViewController {
    
    var index: Int = 0
    
    var data: TwitterPersonalMsg?

    @IBOutlet private weak var icyImageView: UIImageView!
    
    @IBOutlet private weak var icyScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let data = data {
            icyTextLabel.text = data.twitterContent
            let imageData = data.images[index] as TwitterPersonalImages
            icyImageView.setImageWithURL(NSURL(string: imageData.imagePath.toAbsolutePath()))
        }
    }

    @IBOutlet private weak var icyTextLabel: UILabel!
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

extension FindTwitterImageViewController: UIScrollViewDelegate {

}
