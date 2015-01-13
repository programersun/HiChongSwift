//
//  WikiWebViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/1/4.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class WikiWebViewController: UIViewController {
    
    var wikiTitle: String?
    var wikiID: String?

    @IBOutlet private weak var icyWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let myWikiID = wikiID {
            // 显示详情
            let URLString = LCYNetworking.sharedInstance.WikiDetailHTMLAddress(myWikiID)
            println("URL = \(URLString)")
            let URLRequest = NSURLRequest(URL: NSURL(string: URLString)!)
            icyWebView.loadRequest(URLRequest)
        } else {
            alert("加载信息失败")
        }
        
        navigationItem.title = wikiTitle
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
