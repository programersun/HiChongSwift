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
//        ext.extInfo = "<xml>extend info</xml>"
        ext.url = "https://itunes.apple.com/us/app/hai-chong-chong-wu/id918809824?l=zh&ls=1&mt=8"
        
        message.mediaObject = ext
        
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = 0
        
        WXApi.sendReq(req)
        
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
