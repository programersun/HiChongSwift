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
    
    var listData: TwitterListMsg?
    
    var MoePetData: LCYPetDetailPetImages?

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
        
        if let listData = listData {
            icyTextLabel.text = listData.twitterContent
            let imageData = listData.images[index] as TwitterListImages
            icyImageView.setImageWithURL(NSURL(string: imageData.imagePath.toAbsolutePath()))
        }
        
        if let moePetData = MoePetData {
            icyTextLabel.text = ""
            icyImageView.setImageWithURL(NSURL(string: moePetData.petImg.toAbsolutePath()))
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
