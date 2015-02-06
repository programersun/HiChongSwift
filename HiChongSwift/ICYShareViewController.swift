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
        message.title = "嗨宠宠物"
        message.description = messageDescription ?? "嗨宠宠物，为您服务。"
        message.setThumbImage(UIImage(named: "placeholderLogo"))
        //        message.messageExt = "messageExt"
        //        message.messageAction = "<action>hichong</action>"
        
        let ext = WXAppExtendObject()
        ext.extInfo = "ext info"
        ext.url = "https://itunes.apple.com/us/app/hai-chong-chong-wu/id918809824?l=zh&ls=1&mt=8"
        
        let data = "暂时不需要任何内容".dataUsingEncoding(NSUTF8StringEncoding)
        ext.fileData = data
        
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
        let wbMessage = WBMessageObject()
        
        wbMessage.text = weiboMessage ?? messageDescription ?? "嗨宠宠物，为您服务。"
        
        if let weiboImage = weiboImage {
            let imageObject = WBImageObject()
            imageObject.imageData = UIImageJPEGRepresentation(weiboImage, 1)
            wbMessage.imageObject = imageObject
        }
        
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
