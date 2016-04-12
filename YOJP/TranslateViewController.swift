//
//  TranslateViewController.swift
//  YOJP
//
//  Created by PayBay on 15/11/9.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class TranslateViewController: UIViewController,UITextViewDelegate,  UINavigationControllerDelegate {

    
    
    var fromString : String = "auto"
    var toString : String = "auto"
    
    var translateModel : TranslateModel!
    
    var fromTextView : UITextView!
    var toTextView : UITextView!
    
    var toJapanBtn : UIButton!
    var toChinaBtn : UIButton!
    
    
    var takePhoneBtn : UIButton!
    
    
    var activityIndicator:UIActivityIndicatorView!
    var originalTopMargin:CGFloat!
    
     override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "翻译"
    
        self.initView()
        
       // http://openapi.baidu.com/public/2.0/bmt/translate?client_id=LNFofptUs1gwelXocMMdl0OE&q=today&from=auto&to=auto
        
        
//        Alamofire.request(.GET, "http://openapi.baidu.com/public/2.0/bmt/translate?", parameters: ["client_id":"LNFofptUs1gwelXocMMdl0OE","from":"auto","to":"jp","q":"translate"])
//            
//            .response { request, response, data, error in
//                
//                print("request111111111111111111111111%@" , request)
//                print("response2222222222222222222222%@" ,response)
//                print("data333333333333333333333333333%@" ,data)
//                print("error4444444444444444444444444%@" ,error)
//                
//                if error == nil {
//                    let json  = JSON(data: data!)
//                    
//                   
//                    print(json)
//                }
//                else {
//                    
//                }
//                
//        }

    }
    
    func initView() {
      
        self.fromTextView = UITextView(frame: CGRectMake(0,40,screenWidth,200))
        self.fromTextView.text = "请输入要翻译的文字"
        self.fromTextView.font = font15
        self.fromTextView.delegate = self
        self.fromTextView.backgroundColor = yojpLightCell
        self.view.addSubview(self.fromTextView)
        
        let constLabel : UILabel = UILabel(frame: CGRectMake(20,250,screenWidth-40,30))
        constLabel.text = "翻译结果"
        constLabel.textColor = yojpText
        self.view.addSubview(constLabel)
        
        self.toTextView = UITextView(frame: CGRectMake(20,280,screenWidth-40,200))
        self.toTextView.textColor = yojpBlue
        self.toTextView.editable = false
        self.view.addSubview(self.toTextView)
        
        self.toJapanBtn = UIButton(type: .Custom)
        self.toJapanBtn.frame = CGRectMake(screenWidth/2-180, screenHeight-100, 160, 40)
        self.toJapanBtn.setTitle("翻译成日语", forState: UIControlState.Normal)
        self.toJapanBtn.setTitleColor(yojpBlue, forState: UIControlState.Normal)
        self.view.addSubview(self.toJapanBtn)
        self.toJapanBtn.addTarget(self, action: #selector(TranslateViewController.toJapanBtnPressed), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.toChinaBtn = UIButton(type: .Custom)
        self.toChinaBtn.frame = CGRectMake(screenWidth/2+20, screenHeight-100, 160, 40)
        self.toChinaBtn.setTitle("翻译成中文", forState: UIControlState.Normal)
        self.toChinaBtn.setTitleColor(yojpBlue, forState: UIControlState.Normal)
        self.view.addSubview(self.toChinaBtn)
        self.toChinaBtn.addTarget(self, action: Selector("toChinaBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        self.takePhoneBtn = UIButton(type: .Custom)
        self.takePhoneBtn.frame = CGRectMake(screenWidth/2+20, screenHeight-50, 160, 40)
        self.takePhoneBtn.setTitle("拍照翻译", forState: UIControlState.Normal)
        self.takePhoneBtn.setTitleColor(yojpBlue, forState: UIControlState.Normal)
        self.view.addSubview(self.takePhoneBtn)
        self.takePhoneBtn.addTarget(self, action: Selector("takePhoneBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)

        
        
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if self.fromTextView.text == "请输入要翻译的文字" {
            self.fromTextView.text = ""
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if self.fromTextView.text == "" {
            self.fromTextView.text = "请输入要翻译的文字"
        }
    }
    
    func toJapanBtnPressed() {

        self.translateFrom("auto", to: "jp")
    }
    
    func toChinaBtnPressed() {
        
        self.translateFrom("auto", to: "zh")
        
    }
    
    
    func translateFrom(from : String, to : String) {
        Alamofire.request(.GET, baiduTranslateBaseUrl, parameters: ["client_id":baiduTranslateKey,"from":from,"to":to,"q":self.fromTextView.text])
            
            .response { request, response, data, error in
                
                if error == nil {
                    let json  = JSON(data: data!)
                    
                    self.translateModel = TranslateModel(json: json)
                    var string : String = ""
                    for i in  0..<self.translateModel.trans_result.count {
                        string = string + self.translateModel.trans_result[i].dst!
                        }
                    self.toTextView.text = string
                    print(json)
                }
                else {
                    
                }
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_bar_backgroundBlue"), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
//        self.navigationController?.navigationBar.alpha = 1.0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (touches as NSSet).anyObject()?.view != self.fromTextView || (touches as NSSet).anyObject()?.view == self.toTextView {
            self.fromTextView.resignFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }

    
    func takePhoneBtnPressed() {
        view.endEditing(true)
        
        // 2
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",
            message: nil, preferredStyle: .ActionSheet)
        
        // 3
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                style: .Default) { (alert) -> Void in
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .Camera
                    self.presentViewController(imagePicker,
                        animated: true,
                        completion: nil)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        // 4
        let libraryButton = UIAlertAction(title: "Choose Existing",
            style: .Default) { (alert) -> Void in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker,
                    animated: true,
                    completion: nil)
        }
        imagePickerActionSheet.addAction(libraryButton)
        
        // 5
        let cancelButton = UIAlertAction(title: "Cancel",
            style: .Cancel) { (alert) -> Void in
        }
        imagePickerActionSheet.addAction(cancelButton)
        
        // 6
        presentViewController(imagePickerActionSheet, animated: true,
            completion: nil)
        
    }

    
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor: CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }

    
    func performImageRecognition(image: UIImage) {
        // 1
        let tesseract = G8Tesseract()
        
        // 2
        tesseract.language = "eng+chi_sim+jpn"
        
        // 3
        tesseract.engineMode = .TesseractOnly
        
        // 4
        tesseract.pageSegmentationMode = .Auto
        
        // 5
        tesseract.maximumRecognitionTime = 60.0
        
        // 6
        tesseract.image = image.g8_blackAndWhite()
        tesseract.recognize()
        
        // 7
        fromTextView.text = tesseract.recognizedText
        self.translateFrom("auto", to: "zh")
        
        // 8
        removeActivityIndicator()
    }

    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
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




extension TranslateViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        let scaledImage = scaleImage(selectedPhoto, maxDimension: 640)
        
        addActivityIndicator()
        
        dismissViewControllerAnimated(true, completion: {
            self.performImageRecognition(scaledImage)
        })
        
    }
}



