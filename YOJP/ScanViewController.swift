//
//  SupermarketQRViewController.swift
//  swiftShrb
//
//  Created by PayBay on 15/10/14.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import AVFoundation


class ScanViewController: UIViewController,QRViewDelegate,AVCaptureMetadataOutputObjectsDelegate {

    
    var customNavigationBar : UIView!
    
    var merchId : String = ""
    
    var input : AVCaptureDeviceInput?
    var output = AVCaptureMetadataOutput()
    var session = AVCaptureSession()
    var preview = AVCaptureVideoPreviewLayer()
    var str = ""
    var Strcode : ((String)->())!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "二维码/条码"
        
        let device : AVCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do {
            self.input = try AVCaptureDeviceInput(device: device)
        } catch {
            print(error)
        }

        
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        session.canSetSessionPreset(AVCaptureSessionPresetHigh)
        if session.canAddInput(input){
            session.addInput(input)
        }
        
        if session.canAddOutput(output){
            session.addOutput(output)
        }
        output.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code,
            AVMetadataObjectTypeEAN8Code,
            AVMetadataObjectTypeCode128Code,
            AVMetadataObjectTypeQRCode]
        
        preview = AVCaptureVideoPreviewLayer(session: self.session)
        
        preview.videoGravity = AVLayerVideoGravityResize
        preview.frame = self.view.layer.bounds
        self.view.layer.insertSublayer(preview, atIndex: 0)
        self.session.startRunning()
        
        let screenRect : CGRect = UIScreen.mainScreen().bounds
        let qrRectView : QRView = QRView(frame: screenRect)
        qrRectView.transparentArea = CGSizeMake(200, 200)
        qrRectView.backgroundColor = UIColor.clearColor()
        qrRectView.center = CGPointMake(view.bounds.width/2, view.bounds.height/2)
        qrRectView.delegate = self
        view.addSubview(qrRectView)
        
        let pop = UIButton(type: .Custom)
        pop.frame = CGRectMake(20, 20, 50, 50)
        pop.setTitle("返回", forState: .Normal)
        pop.addTarget(self, action: Selector("pop"), forControlEvents: UIControlEvents.TouchUpInside)
      //  self.view.addSubview(pop)
        
        let cropRect = CGRectMake((screenWidth - qrRectView.transparentArea.width)/2, (screenHeight - qrRectView.transparentArea.height)/2, qrRectView.transparentArea.width, qrRectView.transparentArea.height)
        
        self.output.rectOfInterest = CGRectMake(cropRect.origin.y / screenHeight,
            cropRect.origin.x / screenWidth,
            cropRect.size.height / screenHeight,
            cropRect.size.width / screenWidth)
        
        self.creatCustomNavigationBar()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }

    func creatCustomNavigationBar() {
        self.customNavigationBar = UIView(frame: CGRectMake(0,screenHeight-44,screenWidth,44))
        self.customNavigationBar.backgroundColor = yojpBlue
        
        
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 7, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        self.customNavigationBar.addSubview(backBtn)
        
        self.view.addSubview(self.customNavigationBar)

    }
    
    func backClicked() {
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    
    func scanTypeConfig(item: QRItem!) {
        if item.type == QRItemType.QRCode{
            output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        }
        else if item.type == QRItemType.Other{
            output.metadataObjectTypes = [AVMetadataObjectTypeCode128Code]
        }
    }
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!){
        var string = ""
        if metadataObjects.count > 0{
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.session.stopRunning()
            let metadataObject : AVMetadataMachineReadableCodeObject = (metadataObjects as NSArray).objectAtIndex(0) as! AVMetadataMachineReadableCodeObject
            string = metadataObject.stringValue
            
        }
        str = string
        if str != ""{
            self.Strcode?(str)
        }
        else{}
        
        self.pop()
    }
    
    func pop() {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let nav : UINavigationController = self.navigationController!
        self.navigationController?.popViewControllerAnimated(false)
        nav.pushViewController(ScanProductDetailViewController(), animated: true)
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
