//
//  LoginViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/7.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    
    var paybayLogoImageView : UIImageView!
    
    var loginView : UIView!
    var staticUserName : UILabel!
    var phoneTextField : UITextField!
    var betweenLine1 : UIImageView!
    
    var passwordLabel : UILabel!
    var passwordTextField : UITextField!
    var betweenLine2 : UIImageView!

    var loginBtn : UIButton!
    
    var forgetPasswordBtn : UIButton!
    var belowLine : UIImageView!
    
    
    var registerBtn : UIButton!
    
    var userNameTextField : UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = yojpTableViewColor
        
        self.creatBackBtn()
        self.creatPaybayLogo()
        self.creatTextField()
        self.creatLogin()
        
    }
    
    func creatBackBtn() {
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 20, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头Black"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.opaque = true
        self.view.addSubview(backBtn)
    }
    
    func creatPaybayLogo() {
        self.paybayLogoImageView = UIImageView(frame: CGRectMake((screenWidth - 75)/2,  20 + 44 , 75, 75))
        self.paybayLogoImageView.image = UIImage(named: "YOJPLogo")
        self.paybayLogoImageView.opaque = true
        self.view.addSubview(self.paybayLogoImageView)
    }

    
    func creatTextField() {
        
        self.loginView = UIView(frame: CGRectMake(0, 20 + 44 + 130, screenWidth, 110))
        self.loginView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.loginView)

        
        self.staticUserName = UILabel(frame: CGRectMake(32, 17, 0, 21))
        self.staticUserName.text = "用户名"
        self.staticUserName.textColor = yojpText
        self.staticUserName.sizeToFit()
        self.staticUserName.opaque = true
        self.loginView.addSubview(self.staticUserName)
        
        self.phoneTextField = UITextField(frame: CGRectMake(self.staticUserName.frame.origin.x + self.staticUserName.frame.size.width + 16, 0, screenWidth - 16 - self.staticUserName.frame.size.width - 16, 55))
        self.phoneTextField.placeholder = "手机号"
        self.phoneTextField.keyboardType = .NumberPad
        self.phoneTextField.delegate = self
        self.phoneTextField.opaque = true
        self.loginView.addSubview(self.phoneTextField)
        
        self.betweenLine1 = UIImageView(frame: CGRectMake(self.staticUserName.frame.origin.x, 55, screenWidth-self.staticUserName.frame.origin.x - 16, 1))
        self.betweenLine1.backgroundColor = yojpLightCell
        self.loginView.addSubview(self.betweenLine1)
       
        self.passwordLabel = UILabel(frame: CGRectMake(32,  55 + 17, 0, 21))
        self.passwordLabel.text = "密   码"
        self.passwordLabel.textColor = yojpText
        self.passwordLabel.sizeToFit()
        self.passwordLabel.opaque = true
        self.loginView.addSubview(self.passwordLabel)
        
        self.passwordTextField = UITextField(frame: CGRectMake(self.phoneTextField.frame.origin.x, self.phoneTextField.frame.size.height, self.phoneTextField.frame.size.width, self.phoneTextField.frame.size.height))
        self.passwordTextField.placeholder = "登录密码由6-20位字母或数字组成"
        self.passwordTextField.secureTextEntry = true
        self.passwordTextField.delegate = self
        self.passwordTextField.opaque = true
        self.loginView.addSubview(self.passwordTextField)
        
        self.betweenLine2 = UIImageView(frame: CGRectMake(self.staticUserName.frame.origin.x, 110, self.betweenLine1.frame.size.width, 1))
        self.betweenLine2.backgroundColor = yojpLightCell
        self.loginView.addSubview(self.betweenLine2)

    }
    
    func creatLogin() {
        self.loginBtn = UIButton(frame: CGRectMake(16, self.loginView.frame.origin.y + self.loginView.frame.size.height + 60, screenWidth - 32, 44))
        self.loginBtn.backgroundColor = yojpBlue
        self.loginBtn.setTitle("登录", forState: .Normal)
        self.loginBtn.layer.cornerRadius = 4
        self.loginBtn.layer.masksToBounds = true
        self.loginBtn.addTarget(self, action: Selector("loginInBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.loginBtn.opaque = true
        self.view.addSubview(self.loginBtn)
        
        self.forgetPasswordBtn = UIButton(frame: CGRectMake(screenWidth - 100, self.loginBtn.frame.origin.y + self.loginBtn.frame.size.height + 8, 0, 21))
        self.forgetPasswordBtn.setTitle("忘记密码?", forState: .Normal)
        self.forgetPasswordBtn.setTitleColor(yojpBlue, forState: .Normal)
        self.forgetPasswordBtn.titleLabel?.font = font17
        self.forgetPasswordBtn.backgroundColor = UIColor.clearColor()
        self.forgetPasswordBtn.sizeToFit()
        self.forgetPasswordBtn.addTarget(self, action: Selector("forgetPassword"), forControlEvents: UIControlEvents.TouchUpInside)
        self.forgetPasswordBtn.opaque = true
        self.view.addSubview(self.forgetPasswordBtn)
        
        self.belowLine = UIImageView(frame: CGRectMake(self.forgetPasswordBtn.frame.origin.x, self.forgetPasswordBtn.frame.origin.y + self.forgetPasswordBtn.frame.size.height - 5, self.forgetPasswordBtn.frame.size.width, 1))
        self.belowLine.backgroundColor = yojpLightText
        self.belowLine.opaque = true
        self.view.addSubview(self.belowLine)
        
        
        self.registerBtn = UIButton()
        self.registerBtn.center = CGPointMake(screenWidth/2, self.belowLine.frame.origin.y + 30)
        self.registerBtn.bounds = CGRectMake(0, 0, 100, 30)
        self.registerBtn.setTitle("新用户注册", forState: .Normal)
        self.registerBtn.setTitleColor(yojpBlue, forState: .Normal)
        self.registerBtn.titleLabel!.font = font15
        self.registerBtn.titleLabel?.textAlignment = .Center
        self.registerBtn.addTarget(self, action: Selector("registerBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.registerBtn.opaque = true
        self.view.addSubview(self.registerBtn)
        
        let leftLineImageView : UIImageView = UIImageView(frame: CGRectMake(16, self.registerBtn.center.y, screenWidth/2-self.registerBtn.frame.size.width/2-16, 1))
        leftLineImageView.backgroundColor = yojpLightText
        leftLineImageView.opaque = true
        self.view.addSubview(leftLineImageView)
        
        let rightLineImageView : UIImageView = UIImageView(frame: CGRectMake(screenWidth-16-leftLineImageView.frame.size.width, self.registerBtn.center.y, leftLineImageView.frame.size.width, 1))
        rightLineImageView.backgroundColor = yojpLightText
        rightLineImageView.opaque = true
        self.view.addSubview(rightLineImageView)
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if isIphone4s {
            
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                
                self.view.layer.transform = CATransform3DMakeTranslation(0, -100, 0)
                }, completion: { (finished : Bool) -> Void in
                    
            })
        }
        if textField == self.phoneTextField {
            self.betweenLine1.backgroundColor = yojpBlue
        }
        if textField == self.passwordTextField {
            self.betweenLine2.backgroundColor = yojpBlue
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if isIphone4s {
            UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.view.layer.transform = CATransform3DIdentity
                }, completion: { (finished : Bool) -> Void in
                    
            })
        }
        
        if textField == self.phoneTextField {
            self.betweenLine1.backgroundColor = yojpLightCell
        }
        if textField == self.passwordTextField {
            self.betweenLine2.backgroundColor = yojpLightCell
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.phoneTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (touches as NSSet).anyObject()?.view == self.passwordTextField  {
            
            self.passwordTextField.secureTextEntry = false
        }
        
        if (touches as NSSet).anyObject()?.view != self.passwordTextField && (touches as NSSet).anyObject()?.view != self.phoneTextField
        {
            self.phoneTextField.resignFirstResponder()
            self.passwordTextField.resignFirstResponder()
        }
        
    }
    
    func loginInBtnPressed() {
        
        if self.phoneTextField.text?.characters.count <= 0 || self.passwordTextField.text?.characters.count <= 0 {
            SVProgressShow.showInfoWithStatus("信息输入不完整!")
            return
        }
    
        
        self.phoneTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
        CurrentUser.user = JapanUser(userId: self.phoneTextField.text!)
      
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func forgetPassword() {
        
        self.presentViewController(ForgetPasswordViewController(), animated: true) { () -> Void in
            
        }
    }
    
    func registerBtnPressed() {
        
        self.presentViewController(RegisterViewController(), animated: true) { () -> Void in
            
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
