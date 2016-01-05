//
//  RegisterViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/7.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    
    var registerView : UIView!
    var staticUserName : UILabel!
    var phoneTextField : UITextField!
    var betweenLine1 : UIImageView!
    var passwordLabel : UILabel!
    var passwordTextField : UITextField!
    var betweenLine2 : UIImageView!
    
    var captchaView : UIView!
    var captchaTextField : UITextField!
    var getCaptchaBtn : UIButton!
    var betweenLine3 : UIImageView!
    
    var agreeClauseView : TNCheckBoxGroup!
    var registerBtn : UIButton!
    
    var lastTime : Int = 60
    var timer : NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "注册"
        
        self.view.backgroundColor = yojpLightCell
        
        self.creatBackBtn()
        self.creatRegisterView()
        self.creatcaptchaView()
        self.creatRegisterBtnView()
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
        
        self.registerView = UIView(frame: CGRectMake(0, 20 + 44 + 20, screenWidth, 110))
        self.registerView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.registerView)
        
        self.staticUserName = UILabel(frame: CGRectMake(16, 17, 0, 21))
        self.staticUserName.text = "用户名"
        self.staticUserName.textColor = yojpBlue
        self.staticUserName.sizeToFit()
        self.registerView.addSubview(self.staticUserName)
        
        self.phoneTextField = UITextField(frame: CGRectMake(self.staticUserName.frame.origin.x + self.staticUserName.frame.size.width + 16, 0, screenWidth - 16 - self.staticUserName.frame.size.width - 16, 55))
        self.phoneTextField.placeholder = "请输入手机号码"
        self.phoneTextField.delegate = self
        self.phoneTextField.keyboardType = .NumberPad
        self.registerView.addSubview(self.phoneTextField)
        
        self.betweenLine1 = UIImageView(frame: CGRectMake(self.staticUserName.frame.origin.x, 55, screenWidth-self.staticUserName.frame.origin.x - 16, 1))
        self.betweenLine1.backgroundColor = yojpLightCell
        self.registerView.addSubview(self.betweenLine1)
        
        self.passwordLabel = UILabel(frame: CGRectMake(16,  55 + 17, 0, 21))
        self.passwordLabel.text = "密码"
        self.passwordLabel.textColor = yojpBlue
        self.passwordLabel.sizeToFit()
        self.registerView.addSubview(self.passwordLabel)
        
        self.passwordTextField = UITextField(frame: CGRectMake(self.phoneTextField.frame.origin.x, self.phoneTextField.frame.size.height, self.phoneTextField.frame.size.width, self.phoneTextField.frame.size.height))
        self.passwordTextField.placeholder = "请输入密码"
        self.passwordTextField.secureTextEntry = true
        self.passwordTextField.delegate = self
        self.registerView.addSubview(self.passwordTextField)
        
        self.betweenLine2 = UIImageView(frame: CGRectMake(self.staticUserName.frame.origin.x, 110, screenWidth-self.staticUserName.frame.origin.x - 16, 1))
        self.betweenLine2.backgroundColor = yojpLightCell
        self.registerView.addSubview(self.betweenLine2)
    }
    
    func creatcaptchaView() {
        
        self.captchaView = UIView(frame: CGRectMake(0, self.registerView.frame.origin.y + self.registerView.frame.size.height + 40, screenWidth, 55))
        self.captchaView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.captchaView)
        
        self.captchaTextField = UITextField(frame: CGRectMake(16, 0, screenWidth-130-16, 55))
        self.captchaTextField.placeholder = "请输入验证码"
        self.captchaTextField.delegate = self
        self.captchaTextField.keyboardType = .NumberPad
        self.captchaView.addSubview(self.captchaTextField)
        
        
        self.getCaptchaBtn = UIButton(type: .Custom)
        self.getCaptchaBtn.setTitle("获取验证码", forState: .Normal)
        self.getCaptchaBtn.setTitleColor(yojpBlue, forState: .Normal)
        self.getCaptchaBtn.layer.cornerRadius = 4
        self.getCaptchaBtn.layer.borderColor = yojpBlue.CGColor
        self.getCaptchaBtn.layer.borderWidth = 1
        self.getCaptchaBtn.layer.masksToBounds = true
        self.getCaptchaBtn.titleLabel?.font = font16
        self.getCaptchaBtn.frame = CGRectMake(self.captchaTextField.frame.origin.x + self.captchaTextField.frame.size.width, 10, 120, 35)
        self.getCaptchaBtn.addTarget(self, action: Selector("getCodeBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.captchaView.addSubview(self.getCaptchaBtn)
        
        self.betweenLine3 = UIImageView(frame: CGRectMake(self.staticUserName.frame.origin.x, 55, self.captchaTextField.frame.size.width, 1))
        self.betweenLine3.backgroundColor = yojpLightCell
        self.captchaView.addSubview(self.betweenLine3)
        
    }
    
    
    func creatRegisterBtnView() {
        
        let agreeClauseBoxData = TNImageCheckBoxData()
        agreeClauseBoxData.identifier = "agreeClause"
        agreeClauseBoxData.labelText = "同意《通宝用户协议》"
        agreeClauseBoxData.checked = true
        agreeClauseBoxData.checkedImage = UIImage(named: "checked")
        agreeClauseBoxData.uncheckedImage = UIImage(named: "unchecked")
        
        self.agreeClauseView = TNCheckBoxGroup(frame: CGRectMake(16, self.captchaView.frame.origin.y + self.captchaView.frame.size.height + 58, screenWidth-32, 28))
        self.agreeClauseView.checkBoxData = [agreeClauseBoxData]
        self.agreeClauseView.layout = TNCheckBoxLayoutVertical
        self.agreeClauseView.labelColor = yojpBlue
        self.agreeClauseView.myCreate()
        self.view.addSubview(self.agreeClauseView)
        
        self.registerBtn = UIButton(frame: CGRectMake(16, self.agreeClauseView.frame.origin.y + self.agreeClauseView.frame.size.height + 10, screenWidth - 32, 44))
        self.registerBtn.backgroundColor = yojpBlue
        self.registerBtn.setTitle("注册", forState: .Normal)
        self.registerBtn.layer.cornerRadius = 4
        self.registerBtn.layer.masksToBounds = true
        self.registerBtn.addTarget(self, action: Selector("registerBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.registerBtn)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("agreeClauseViewChanged:"), name: GROUP_CHANGED, object: self.agreeClauseView)
        
    }
    
    
    func getCodeBtnPressed() {
        
        
    }
    
    
    func registerBtnPressed() {
        
        
        if self.phoneTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty || self.captchaTextField.text!.isEmpty {
            SVProgressShow.showErrorWithStatus("请输入所有信息")
            return
        }
        
        SVProgressShow.showSuccessWithStatus("注册成功!")
        self.phoneTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
        CurrentUser.user = JapanUser(userId: self.phoneTextField.text!)
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.phoneTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.captchaTextField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (touches as NSSet).anyObject()?.view != self.phoneTextField || (touches as NSSet).anyObject()?.view != self.captchaTextField || (touches as NSSet).anyObject()?.view != self.passwordTextField {
            self.phoneTextField.resignFirstResponder()
            self.captchaTextField.resignFirstResponder()
            self.passwordTextField.resignFirstResponder()
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.phoneTextField {
            self.betweenLine1.backgroundColor = yojpBlue
        }
        if textField == self.passwordTextField {
            self.betweenLine2.backgroundColor = yojpBlue
        }
        if textField == self.captchaTextField {
            self.betweenLine3.backgroundColor = yojpBlue
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == self.phoneTextField {
            self.betweenLine1.backgroundColor = yojpLightCell
        }
        if textField == self.passwordTextField {
            self.betweenLine2.backgroundColor = yojpLightCell
        }
        if textField == self.captchaTextField {
            self.betweenLine3.backgroundColor = yojpLightCell
        }
    }
    
    func agreeClauseViewChanged(notification : NSNotification) {
        print(self.agreeClauseView.checkedCheckBoxes)
        print(self.agreeClauseView.uncheckedCheckBoxes)
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
