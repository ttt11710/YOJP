//
//  ForgetPasswordViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/7.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController,UITextFieldDelegate {
    
    
    var registerView : UIView!
    var staticUserName : UILabel!
    var phoneTextField : UITextField!
    var betweenLine1 : UIImageView!
    
    var captchaLabel : UILabel!
    var captchaTextField : UITextField!
    var betweenLine2 : UIImageView!
    var getCaptchaBtn : UIButton!
    
    var newPasswordLabel : UILabel!
    var newPasswordTextField : UITextField!
    var betweenLine3 : UIImageView!
    
    var setPassBtn : UIButton!
    
    var remindLable : UILabel!
    
    var lastTime : Int = 60
    var timer : NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "忘记密码"
        
        self.view.backgroundColor = yojpLightCell
        
        self.creatBackBtn()
        self.creatRegisterView()
        self.creatSetPassBtn()
        
        // Do any additional setup after loading the view.
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
        backBtn.addTarget(self, action: Selector("backClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backBtn)
    }

    
    func creatRegisterView() {
        
        self.registerView = UIView(frame: CGRectMake(0, 20 + 44 + 10, screenWidth, 165))
        self.registerView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.registerView)
        
        self.staticUserName = UILabel(frame: CGRectMake(16, 17, 0, 21))
        self.staticUserName.text = "手机号"
        self.staticUserName.textColor = yojpBlue
        self.staticUserName.sizeToFit()
        self.registerView.addSubview(self.staticUserName)
        
        self.phoneTextField = UITextField(frame: CGRectMake(self.staticUserName.frame.origin.x + self.staticUserName.frame.size.width + 16, 0, screenWidth - 16 - self.staticUserName.frame.size.width - 16, 55))
        self.phoneTextField.placeholder = "请输入手机号码"
        self.phoneTextField.delegate = self
        self.phoneTextField.keyboardType = .NumberPad
        self.registerView.addSubview(self.phoneTextField)
        
        self.betweenLine1 = UIImageView(frame: CGRectMake(self.staticUserName.frame.origin.x, 55, screenWidth-self.staticUserName.frame.origin.x-16, 1))
        self.betweenLine1.backgroundColor = yojpLightCell
        self.registerView.addSubview(self.betweenLine1)
        
        self.captchaLabel = UILabel(frame: CGRectMake(16,  55 + 17, 0, 21))
        self.captchaLabel.text = "验证码"
        self.captchaLabel.textColor = yojpBlue
        self.captchaLabel.sizeToFit()
        self.registerView.addSubview(self.captchaLabel)
        
        self.captchaTextField = UITextField(frame: CGRectMake(self.phoneTextField.frame.origin.x, self.phoneTextField.frame.size.height, self.phoneTextField.frame.size.width - 100, self.phoneTextField.frame.size.height))
        self.captchaTextField.placeholder = "请输入短信验证码"
        self.captchaTextField.secureTextEntry = true
        self.captchaTextField.delegate = self
        self.captchaTextField.keyboardType = .NumberPad
        self.registerView.addSubview(self.captchaTextField)
        
        self.getCaptchaBtn = UIButton(type: .Custom)
        self.getCaptchaBtn.setTitle("获取验证码", forState: .Normal)
        self.getCaptchaBtn.setTitleColor(yojpBlue, forState: .Normal)
        self.getCaptchaBtn.titleLabel?.font = font15
        self.getCaptchaBtn.layer.cornerRadius = 4
        self.getCaptchaBtn.layer.borderColor = yojpBlue.CGColor
        self.getCaptchaBtn.layer.borderWidth = 1
        self.getCaptchaBtn.frame = CGRectMake(screenWidth-130, self.captchaTextField.frame.origin.y + 10 , 120, 35)
        self.getCaptchaBtn.addTarget(self, action: Selector("getCodeBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.registerView.addSubview(self.getCaptchaBtn)
        
        
        self.betweenLine2 = UIImageView(frame: CGRectMake(self.staticUserName.frame.origin.x, 110, self.betweenLine1.frame.size.width, 1))
        self.betweenLine2.backgroundColor = yojpLightCell
        self.registerView.addSubview(self.betweenLine2)
        
        
        self.newPasswordLabel = UILabel(frame: CGRectMake(16, 110 + 17, 0, 21))
        self.newPasswordLabel.text = "新密码"
        self.newPasswordLabel.textColor = yojpBlue
        self.newPasswordLabel.sizeToFit()
        self.registerView.addSubview(self.newPasswordLabel)
        
        self.newPasswordTextField = UITextField(frame: CGRectMake(self.newPasswordLabel.frame.origin.x + self.newPasswordLabel.frame.size.width + 16, 110, screenWidth - 16 - self.newPasswordLabel.frame.size.width - 16, 55))
        self.newPasswordTextField.placeholder = "请输入新密码"
        self.newPasswordTextField.delegate = self
        self.registerView.addSubview(self.newPasswordTextField)
        
        self.betweenLine3 = UIImageView(frame: CGRectMake(self.staticUserName.frame.origin.x, 165, self.betweenLine1.frame.size.width, 1))
        self.betweenLine3.backgroundColor = yojpLightCell
        self.registerView.addSubview(self.betweenLine3)
        
        self.remindLable = UILabel(frame: CGRectMake(16,self.registerView.frame.origin.y + self.registerView.frame.size.height + 16,200,30))
        self.remindLable.text = "忘记密码暂无相应接口!"
        self.remindLable.textColor = yojpBlue
        self.view.addSubview(self.remindLable)
        
    }
    
    func creatSetPassBtn() {
        self.setPassBtn = UIButton(frame: CGRectMake(16, self.registerView.frame.origin.y + self.registerView.frame.size.height + 60, screenWidth - 32, 44))
        self.setPassBtn.backgroundColor = yojpBlue
        self.setPassBtn.setTitle("重置密码", forState: .Normal)
        self.setPassBtn.layer.cornerRadius = 4
        self.setPassBtn.layer.masksToBounds = true
        self.setPassBtn.addTarget(self, action: Selector("setPassBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.setPassBtn)
        
    }
    func getCodeBtnPressed() {
        
        if self.phoneTextField.text?.characters.count <= 0 || self.captchaTextField.text?.characters.count <= 0 || self.newPasswordTextField.text?.characters.count <= 0 {
            SVProgressShow.showInfoWithStatus("信息输入不完整!")
            return
        }
    }
    
    func setPassBtnPressed() {
        
        SVProgressShow.showInfoWithStatus("忘记密码暂无相应接口")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.phoneTextField.resignFirstResponder()
        self.captchaTextField.resignFirstResponder()
        self.newPasswordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.phoneTextField {
            self.betweenLine1.backgroundColor = yojpBlue
        }
        if textField == self.captchaTextField {
            self.betweenLine2.backgroundColor = yojpBlue
        }
        if textField == self.newPasswordTextField {
            self.betweenLine3.backgroundColor = yojpBlue
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == self.phoneTextField {
            self.betweenLine1.backgroundColor = yojpLightCell
        }
        if textField == self.captchaTextField {
            self.betweenLine2.backgroundColor = yojpLightCell
        }
        if textField == self.newPasswordTextField {
            self.betweenLine3.backgroundColor = yojpLightCell
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (touches as NSSet).anyObject()?.view != self.phoneTextField || (touches as NSSet).anyObject()?.view != self.captchaTextField || (touches as NSSet).anyObject()?.view != self.newPasswordTextField {
            self.phoneTextField.resignFirstResponder()
            self.captchaTextField.resignFirstResponder()
            self.newPasswordTextField.resignFirstResponder()
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
