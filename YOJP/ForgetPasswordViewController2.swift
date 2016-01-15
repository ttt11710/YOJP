//
//  ForgetPasswordViewController2.swift
//  YOJP
//
//  Created by PayBay on 15/12/9.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class ForgetPasswordViewController2: UIViewController,UITextFieldDelegate {

    
    var staticpassword : UILabel!
    var passwordTextField : UITextField!
    var betweenLine1 : UIImageView!
    
    var finishBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = yojpLightCell
        self.creatBackBtn()
        self.creatpasswordView()
        self.creatfinishBtn()
        // Do any additional setup after loading the view.
    }

    func creatBackBtn() {
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 20, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头Black"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.opaque = true
        self.view.addSubview(backBtn)
    }
    
    func creatpasswordView() {
        self.staticpassword = UILabel(frame: CGRectMake(16, 77, 0, 21))
        self.staticpassword.text = "密  码"
        self.staticpassword.textColor = yojpBlue
        self.staticpassword.sizeToFit()
        self.staticpassword.opaque = true
        self.view.addSubview(self.staticpassword)
        
        self.passwordTextField = UITextField(frame: CGRectMake(self.staticpassword.frame.origin.x + self.staticpassword.frame.size.width + 16, 60, screenWidth - 16 - self.staticpassword.frame.size.width - 16-16, 55))
        self.passwordTextField.placeholder = "登录密码  6-20位字母、数字"
        self.passwordTextField.delegate = self
        self.passwordTextField.opaque = true
        self.view.addSubview(self.passwordTextField)
        
        self.betweenLine1 = UIImageView(frame: CGRectMake(self.staticpassword.frame.origin.x, self.passwordTextField.frame.origin.y+self.passwordTextField.frame.size.height, screenWidth-self.staticpassword.frame.origin.x-16, 1))
        self.betweenLine1.backgroundColor = yojpText
        self.view.addSubview(self.betweenLine1)
    }

    
    func creatfinishBtn() {
        self.finishBtn = UIButton(frame: CGRectMake(16, 60 + 55 + 16, screenWidth - 32, 44))
        self.finishBtn.backgroundColor = yojpBlue
        self.finishBtn.setTitle("确认", forState: .Normal)
        self.finishBtn.layer.cornerRadius = 4
       // self.finishBtn.layer.masksToBounds = true
        self.finishBtn.addTarget(self, action: Selector("finishBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.finishBtn.titleLabel!.opaque = true
        self.view.addSubview(self.finishBtn)
        
        
//        self.finishBtn.layer.cornerRadius = 5
//        self.finishBtn.layer.shadowOffset = CGSizeMake(1, 1)
//        self.finishBtn.layer.shadowOpacity = 0.8
//        self.finishBtn.layer.shadowRadius = 5.0
//        
//        self.finishBtn.layer.shadowColor = UIColor.blackColor().CGColor
//        
//        
//        self.finishBtn.layer.shadowOpacity = 1.0
        
    }

    func finishBtnPressed(){
        
        
        self.dismissViewControllerAnimated(false) { () -> Void in
        }
        ForgetPasswordViewController.shareForgetPasswordViewController().backClickedWithNoAnimated()
    }
    
    func backClicked() {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
   
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.passwordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.passwordTextField {
            self.betweenLine1.backgroundColor = yojpBlue
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == self.passwordTextField {
            self.betweenLine1.backgroundColor = yojpText
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (touches as NSSet).anyObject()?.view != self.passwordTextField{
            self.passwordTextField.resignFirstResponder()
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
