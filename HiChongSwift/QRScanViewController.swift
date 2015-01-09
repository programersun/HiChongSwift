//
//  QRScanViewController.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/24.
//  Copyright (c) 2014年 多思科技. All rights reserved.
//

import UIKit
import AVFoundation

class QRScanViewController: UIViewController {
    
    weak var delegate: QRScanDelegate?
    
    var device: AVCaptureDevice?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureMetadataOutput?
    var session: AVCaptureSession?
    var preview: AVCaptureVideoPreviewLayer?

    @IBOutlet weak var lensView: UIView!
    @IBOutlet weak var layoutView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lensView.layer.borderWidth = 1.0
        lensView.layer.borderColor = UIColor.yellowColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCamera()
    }
    
    private func setupCamera() {
        // Device
        device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Input
        input = AVCaptureDeviceInput(device: device, error: nil)
        
        // Output
        output = AVCaptureMetadataOutput()
        output?.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        // Session
        session = AVCaptureSession()
//        session?.sessionPreset = AVCaptureSessionPresetHigh
        session?.sessionPreset = AVCaptureSessionPreset1920x1080
        if let usession = session {
            if usession.canAddInput(input) {
                usession.addInput(input)
            }
            if usession.canAddOutput(output) {
                usession.addOutput(output)
            }
        }
        
        // 条码类型
        output?.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        // preview
        preview = AVCaptureVideoPreviewLayer.layerWithSession(session) as? AVCaptureVideoPreviewLayer
        preview?.videoGravity = AVLayerVideoGravityResizeAspectFill
        preview?.frame = CGRect(origin: CGPointZero, size: view.bounds.size)
        preview?.addSublayer(layoutView.layer)
        view.layer.addSublayer(preview)
        
        // 设置检测区域
        let x: CGFloat = lensView.frame.origin.x / layoutView.bounds.width
        let y: CGFloat = lensView.frame.origin.y / layoutView.bounds.height
        let w: CGFloat = lensView.bounds.width / layoutView.bounds.width
        let h: CGFloat = lensView.bounds.height / layoutView.bounds.height
        output?.rectOfInterest = CGRect(x: y, y: x, width: h, height: w)
        
        // Start
        session?.startRunning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelButtonPressed(sender: AnyObject) {
        session?.stopRunning()
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension QRScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if isBeingPresented() {
            return
        }
        if isBeingDismissed() {
            return
        }
        var stringValue: String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
        }
        
        if let result = stringValue {
            delegate?.QRCodeDidScan(result)
        }
        
        session?.stopRunning()
        dismissViewControllerAnimated(true, completion: nil)
    }
}

protocol QRScanDelegate: class {
    func QRCodeDidScan(info: String)
}
