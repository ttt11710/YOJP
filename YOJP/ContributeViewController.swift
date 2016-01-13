//
//  ContributeViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/7.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class ContributeViewController: UIViewController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate {

    
    var customNavigationBar : UIView!
    
    var scrollView : UIScrollView!
    var backView : UIView!
    var tap : UITapGestureRecognizer!
    var lineImageView : UIImageView!
    var textView : UITextView!
    var contributeView : UIView!
    
    var imageArray : NSMutableArray! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = yojpTableViewColor
        
        self.creatScrollView()
        self.creatCustomNavigationBar()
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
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

    func creatScrollView() {
        
        self.scrollView = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight-44))
        self.scrollView.backgroundColor = yojpTableViewColor
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.scrollView)
        
        self.backView = UIView(frame: CGRectMake(0,0,screenWidth,10+(screenWidth-40)/3+10+1+8+200+44))
        self.backView.backgroundColor = UIColor.whiteColor()
        self.scrollView.addSubview(self.backView)
        
        for i in 0...2 {
            let imageView : UIImageView = UIImageView(frame: CGRectMake(CGFloat(i+1)*10+CGFloat(i)*(screenWidth-40)/3, 10, (screenWidth-40)/3, (screenWidth-40)/3))
            if i < 2 {
                imageView.image = UIImage(named: String(format: "image%d", i))
            }
            else {
                imageView.image = UIImage(named: "添加图片")
                self.tap = UITapGestureRecognizer(target: self, action: Selector("tapAddImage"))
                imageView.userInteractionEnabled = true
                imageView.addGestureRecognizer(self.tap)

            }
            self.imageArray.addObject(imageView.image!)
            self.backView.addSubview(imageView)
        }
        
        self.lineImageView = UIImageView(frame: CGRectMake(16, 10+(screenWidth-40)/3+10, screenWidth-32, 1))
        self.lineImageView.image = UIImage(named: "dashedLine")
        self.backView.addSubview(self.lineImageView)
        
        self.textView = UITextView(frame: CGRectMake(8, lineImageView.frame.origin.y+1+8, screenWidth-16, 200))
        self.textView.text = "分享你的使用心得"
        self.textView.textColor = yojpLightText
        self.textView.font = font15
        self.backView.addSubview(self.textView)
        
        
        self.contributeView = UIView(frame: CGRectMake(0,textView.frame.origin.y+textView.frame.size.height,screenWidth,44))
        self.contributeView.layer.borderWidth = 1
        self.contributeView.layer.borderColor = yojpTableViewColor.CGColor
        self.backView.addSubview(self.contributeView)
        
        let contributeBtn : UIButton = UIButton(frame: CGRectMake(screenWidth-100,0,80,44))
        contributeBtn.setTitle("投稿", forState: .Normal)
        contributeBtn.setTitleColor(yojpText, forState: .Normal)
        contributeBtn.setTitleColor(yojpText, forState: .Highlighted)
        contributeBtn.titleLabel?.font = font15
        contributeBtn.addTarget(self, action: Selector("gotoContributePreview"), forControlEvents: .TouchUpInside)
        self.contributeView.addSubview(contributeBtn)
        
    }
    
    func updateScrollView() {

        let num1 = (self.imageArray.count)%3 == 0 ? 0:1

        let num = (self.imageArray.count)/3 + num1
        self.backView.frame = CGRectMake(0,0,screenWidth,10+((screenWidth-40)/3+10)*CGFloat(num)+1+8+200+44)
        
        self.scrollView.contentSize = CGSizeMake(0,self.backView.frame.size.height)
        
        for view in self.backView.subviews {
            if view.isKindOfClass(UIImageView) {
                view.removeFromSuperview()
            }
        }
        
        for i in 0..<self.imageArray.count {
            let imageView : UIImageView = UIImageView(frame: CGRectMake(CGFloat(i%3+1)*10+CGFloat(i%3)*(screenWidth-40)/3, 10*CGFloat(i/3+1)+CGFloat(i/3)*(screenWidth-40)/3+10, (screenWidth-40)/3, (screenWidth-40)/3))
            
                imageView.image = self.imageArray[i] as? UIImage
           
            if i == self.imageArray.count-1 {
                
                self.tap = UITapGestureRecognizer(target: self, action: Selector("tapAddImage"))
                imageView.userInteractionEnabled = true
                imageView.addGestureRecognizer(self.tap)
            }
            
            self.backView.addSubview(imageView)
        }
        
        self.lineImageView.frame = CGRectMake(16, 10+((screenWidth-40)/3+10)*CGFloat(num), screenWidth-32, 1)
        self.textView.frame = CGRectMake(8, lineImageView.frame.origin.y+1+8, screenWidth-16, 200)
        self.contributeView.frame = CGRectMake(0,textView.frame.origin.y+textView.frame.size.height,screenWidth,44)
    }

    
    func tapAddImage() {
        
        let sheet : UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "本地相册","拍照")
        sheet.showInView(self.view)
    
    }
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        if buttonIndex == actionSheet.cancelButtonIndex {
            return
        }
        switch buttonIndex {
        case 1:
            self.addAlbumImage()
            break
        case 2:
            self.takePhoto()
            break
        default:
            break
        }
    }
    
    func addAlbumImage() {
        
        let sourceType : UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.PhotoLibrary
        let imagePicker : UIImagePickerController = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true) { () -> Void in
            
        }
    }
    
    func takePhoto() {
        
        let sourceType : UIImagePickerControllerSourceType
        let isCamera : Bool = UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear)
        if !isCamera {
            let alertView : UIAlertView = UIAlertView(title: "提示", message: "此设备没有摄像头", delegate: self, cancelButtonTitle: "确定")
        
            alertView.show()
            return
        }
        
        sourceType = UIImagePickerControllerSourceType.Camera
        let imagePicker : UIImagePickerController = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.navigationBarHidden = true
        self.presentViewController(imagePicker, animated: true) { () -> Void in
            
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var image : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        if picker.allowsEditing {
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }
        
        self.imageArray.insertObject(image, atIndex: self.imageArray.count-1)
        picker.navigationController?.navigationBar.alpha = 1
        picker.dismissViewControllerAnimated(true) { () -> Void in
            
            self.updateScrollView()
            self.navigationController?.navigationBar.alpha = 1
        }
    }
    
    func gotoContributePreview() {
        let contributePreViewController : ContributePreViewController = ContributePreViewController()
        contributePreViewController.imageArray = self.imageArray.mutableCopy() as! NSMutableArray
        contributePreViewController.contributeViewText = self.textView.text
        self.navigationController?.pushViewController(contributePreViewController, animated: true)
    }
    
    func backClicked() {
        self.navigationController?.popViewControllerAnimated(true)
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
