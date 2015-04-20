//
//  ICYShareViewController.swift
//  HiChongSwift
//
//  Created by eagle on 15/2/4.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ICYShareViewController: UIViewController {
    
    var messageDescription: String?
    var weiboImage: UIImage?
    var weiboMessage: String?
    
    var wxTitle : String?
    var wxDesciption : String?
    var wxImg : UIImage?
    var wxURL  : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func weChatButtonPressed(sender: UIButton) {
        println("message button pressed")
        
        
        let message = WXMediaMessage()
        message.title = wxTitle ?? "嗨宠宠物"
        message.description = messageDescription ?? "嗨宠宠物，为您服务。"
        message.setThumbImage(wxImg ?? UIImage(named: "placeholderLogo"))
        //        message.messageExt = "messageExt"
        //        message.messageAction = "<action>hichong</action>"
        
        let ext = WXAppExtendObject()
        
        ext.url = wxURL ?? "https://itunes.apple.com/us/app/hai-chong-chong-wu/id918809824?l=zh&ls=1&mt=8"
        message.mediaObject = ext
        
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = Int32(sender.tag)
        
        WXApi.sendReq(req)
        
        
        
        //        let messageSender = MessageSender()
        //        messageSender.sendAppContent()
        
    }
    @IBAction func weiboButtonPressed(sender: AnyObject) {
        let messageSender = MessageSender()
        let wbMessage = WBWebpageObject()
        
        wbMessage.title = wxTitle ?? "嗨宠宠物"
        wbMessage.description = messageDescription ?? "嗨宠宠物，为您服务。"
        wbMessage.thumbnailData = UIImageJPEGRepresentation(wxImg ?? UIImage(named: "placeholderLogo"), 1)
        wbMessage.webpageUrl    = wxURL ?? "https://itunes.apple.com/us/app/hai-chong-chong-wu/id918809824?l=zh&ls=1&mt=8"
        messageSender.sendWeiboContent(wbMessage)
    }
    
    @IBAction func backgroundTouched(sender: AnyObject) {
        view.removeFromSuperview()
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    deinit {
        println("share view controller de init called")
    }
    
}
