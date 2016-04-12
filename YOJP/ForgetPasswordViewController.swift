//
//  ForgetPasswordViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/7.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit


var defaultForgetPasswordViewController : ForgetPasswordViewController!

class ForgetPasswordViewController: UIViewController,UITextFieldDelegate {
    
    
    var registerView : UIView!
    var staticUserName : UILabel!
    var phoneTextField : UITextField!
    var betweenLine1 : UIImageView!
    
    var captchaTextField : UITextField!
    var betweenLine2 : UIImageView!
    var getCaptchaBtn : UIButton!

    var nextBtn : UIButton!

    var lastTime : Int = 60
    var timer : NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = yojpLightCell
        
        self.creatBackBtn()
        self.creatRegisterView()
        self.creatNextBtn()
        
        defaultForgetPasswordViewController = self
        
        // Do any additional setup after loading the view.
    }
    
    
    class func shareForgetPasswordViewController() -> ForgetPasswordViewController {
        return defaultForgetPasswordViewController
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressShow.dismiss()
        
        if self.timer != nil {
            if self.timer.valid {
                self.timer.invalidate()
            }
        }
    }
    
    
    func creatBackBtn() {
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 20, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头Black"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: #selector(ForgetPasswordViewController.backClicked), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.opaque = true
        self.view.addSubview(backBtn)
    }

    
    func creatRegisterView() {
        
        self.registerView = UIView(frame: CGRectMake(0, 20 + 44 + 10, screenWidth, 110))
      //  self.registerView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.registerView)
        
        self.staticUserName = UILabel(frame: CGRectMake(16, 17, 0, 21))
        self.staticUserName.text = "用户名"
        self.staticUserName.textColor = yojpBlue
        self.staticUserName.sizeToFit()
        self.staticUserName.opaque = true
        self.registerView.addSubview(self.staticUserName)
    
        self.phoneTextField = UITextField(frame: CGRectMake(self.staticUserName.frame.origin.x + self.staticUserName.frame.size.width + 16, 0, screenWidth - 16 - self.staticUserName.frame.size.width - 16, 55))
        self.phoneTextField.placeholder = CurrentUser.user?.userId
        self.phoneTextField.delegate = self
        self.phoneTextField.keyboardType = .NumberPad
        self.registerView.addSubview(self.phoneTextField)
        
        self.betweenLine1 = UIImageView(frame: CGRectMake(self.staticUserName.frame.origin.x, 55, screenWidth-self.staticUserName.frame.origin.x-16, 1))
        self.betweenLine1.backgroundColor = yojpText
        self.betweenLine1.opaque = true
        self.registerView.addSubview(self.betweenLine1)
        
        
        self.captchaTextField = UITextField(frame: CGRectMake(16, 55+17, (screenWidth-48)/3*2, 45))
        self.captchaTextField.placeholder = "请输入短信验证码"
        self.captchaTextField.secureTextEntry = true
        self.captchaTextField.delegate = self
        self.captchaTextField.keyboardType = .NumberPad
        self.captchaTextField.opaque = true
        self.registerView.addSubview(self.captchaTextField)
        
        self.getCaptchaBtn = UIButton(type: .Custom)
        self.getCaptchaBtn.setTitle("获取验证码", forState: .Normal)
        self.getCaptchaBtn.setTitleColor(yojpBlue, forState: .Normal)
        self.getCaptchaBtn.titleLabel?.font = font15
        self.getCaptchaBtn.layer.cornerRadius = 4
        self.getCaptchaBtn.layer.borderColor = yojpBlue.CGColor
        self.getCaptchaBtn.layer.borderWidth = 1
        self.getCaptchaBtn.frame = CGRectMake(self.captchaTextField.frame.origin.x+self.captchaTextField.frame.size.width+16, self.captchaTextField.frame.origin.y , (screenWidth-48)/3, 45)
        self.getCaptchaBtn.addTarget(self, action: Selector("getCodeBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.getCaptchaBtn.titleLabel!.opaque = true
        self.registerView.addSubview(self.getCaptchaBtn)
        
        
        self.betweenLine2 = UIImageView(frame: CGRectMake(self.staticUserName.frame.origin.x, 110, self.captchaTextField.frame.size.width, 1))
        self.betweenLine2.backgroundColor = yojpText
        self.betweenLine2.opaque = true
        self.registerView.addSubview(self.betweenLine2)
        
    }
    
    func creatNextBtn() {
        self.nextBtn = UIButton(frame: CGRectMake(16, self.registerView.frame.origin.y + self.registerView.frame.size.height + 16, screenWidth - 32, 44))
        self.nextBtn.backgroundColor = yojpBlue
        self.nextBtn.setTitle("下一步", forState: .Normal)
        self.nextBtn.layer.cornerRadius = 4
        self.nextBtn.layer.masksToBounds = true
        self.nextBtn.addTarget(self, action: Selector("nextBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.nextBtn.titleLabel!.opaque = true
        self.view.addSubview(self.nextBtn)
        
    }

    func getCodeBtnPressed() {
        
        if self.phoneTextField.text?.characters.count <= 0 || self.captchaTextField.text?.characters.count <= 0 {
            SVProgressShow.showInfoWithStatus("信息输入不完整!")
            return
        }
    }
    
    func nextBtnPressed() {
        
       self.presentViewController(ForgetPasswordViewController2(), animated: true) { () -> Void in
        
        }

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.phoneTextField.resignFirstResponder()
        self.captchaTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.phoneTextField {
            self.betweenLine1.backgroundColor = yojpBlue
        }
        if textField == self.captchaTextField {
            self.betweenLine2.backgroundColor = yojpBlue
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == self.phoneTextField {
            self.betweenLine1.backgroundColor = yojpText
        }
        if textField == self.captchaTextField {
            self.betweenLine2.backgroundColor = yojpText
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (touches as NSSet).anyObject()?.view != self.phoneTextField || (touches as NSSet).anyObject()?.view != self.captchaTextField {
            self.phoneTextField.resignFirstResponder()
            self.captchaTextField.resignFirstResponder()
        }
    }
    
    func startTime() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerFun"), userInfo: nil, repeats: true)
        
    }
    
    func timerFun() {
        self.getCaptchaBtn.userInteractionEnabled = false
        self.getCaptchaBtn.setTitle(String(format: "%ds后重新获得", self.lastTime), forState: UIControlState.Normal)
        self.getCaptchaBtn.backgroundColor = yojpLightCell
        self.lastTime = self.lastTime - 1
        if self.lastTime == 0 {
            self.timer.invalidate()
            self.lastTime = 60
            self.getCaptchaBtn.setTitle("获取验证码", forState: .Normal)
            self.getCaptchaBtn.backgroundColor = UIColor.whiteColor()
            self.getCaptchaBtn.userInteractionEnabled = true
        }
    }


    func backClicked() {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    
    }

    func backClickedWithNoAnimated() {
        self.dismissViewControllerAnimated(false) { () -> Void in
            
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
