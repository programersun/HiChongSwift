//
//  WikiArticleViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/25.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit
import WebKit

class WikiArticleViewController: UIViewController {
    
    @IBOutlet private weak var icyWebView: UIWebView!
    
    var wikiArticleID: String?
    var wikiCollected: Bool? {
        didSet {
            if let collected = wikiCollected {
                navigationItem.rightBarButtonItem?.enabled = true
                if collected {
                    navigationItem.rightBarButtonItem?.title = "取消收藏"
                } else {
                    navigationItem.rightBarButtonItem?.title = "加入收藏"
                }
            } else {
                navigationItem.rightBarButtonItem?.enabled = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let wikiID = wikiArticleID {
            // 显示详情
            let URLString = LCYNetworking.sharedInstance.WikiHTMLAddress(wikiID)
            let URLRequest = NSURLRequest(URL: NSURL(string: URLString)!)
            println("URL =||| \(URLString)")
            icyWebView.loadRequest(URLRequest)
            // 判断收藏情况
            if let collected = wikiCollected {
                wikiCollected = collected
            } else {
                let parameters = [
                    "user_name" : LCYCommon.sharedInstance.userName!,
                    "ency_id"   : wikiID
                ]
                LCYNetworking.sharedInstance.POSTNONEJSON(LCYApi.WikiIsCollect, parameters: parameters, success: { [weak self] in
                    if $0 == "true" {
                        self?.wikiCollected = true
                    } else {
                        self?.wikiCollected = false
                    }
                    return
                    }, failure: { (error) -> Void in
                        return
                })
            }
        } else {
            alert("无法加载信息")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        icyWebView.reload()
    }
    
    @IBAction func collectionButtonPressed(sender: AnyObject) {
        if let collect = wikiCollected {
            // 发送请求
            showHUD()
            let parameters = [
                "ency_id"   : wikiArticleID!,
                "user_name" : LCYCommon.sharedInstance.userName!,
                "status"    : collect ? "2" : "1"
            ]
            LCYNetworking.sharedInstance.POST(LCYApi.WikiCollect, parameters: parameters, success: { [weak self](object) -> Void in
                self?.hideHUD()
                if let result = object["result"]?.boolValue {
                    if result {
                        if let msgs = object["msg"] as? String {
                            self?.alert(msgs)
                        }
                        if let collect = self?.wikiCollected {
                            self?.wikiCollected = !collect
                        }
                    } else {
                        self?.alert("操作失败")
                    }
                } else {
                    self?.alert("操作失败")
                }
                return
            }, failure: { [weak self](error) -> Void in
                self?.hideHUD()
                self?.alert("网络连接异常，情检查网络状态")
                return
            })
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

extension WikiArticleViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(webView: UIWebView) {
    }
}
