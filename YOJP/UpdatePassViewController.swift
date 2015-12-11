//
//  UpdatePassViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/7.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class UpdatePassViewController: UIViewController,UITextFieldDelegate {

    
    var customNavigationBar : UIView!
    
    var customLabel : UILabel!
    var captchaTextField : UITextField!
    var getCaptchaBtn : UIButton!
    var nextBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = yojpTableViewColor
        
        self.creatCustomNavigationBar()
        self.creatRegisterView()
        self.creatNextBtn()
        
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

    func creatRegisterView() {
        
        self.customLabel = UILabel(frame: CGRectMake(16,20+20,screenWidth,25))
        self.customLabel.text = "请输入138***1234收到的短信验证码"
        self.customLabel.font = font14
        self.customLabel.textColor = yojpText
        self.view.addSubview(self.customLabel)
        
        self.captchaTextField = UITextField(frame: CGRectMake(16, self.customLabel.frame.origin.y + self.customLabel.frame.size.height+16, (screenWidth-48)/3*2, 45))
        self.captchaTextField.placeholder = "请输入短信验证码"
        self.captchaTextField.secureTextEntry = true
        self.captchaTextField.delegate = self
        self.captchaTextField.keyboardType = .NumberPad
        self.captchaTextField.layer.borderColor = yojpBlue.CGColor
        self.captchaTextField.layer.borderWidth = 1
        self.view.addSubview(self.captchaTextField)
        
        self.getCaptchaBtn = UIButton(type: .Custom)
        self.getCaptchaBtn.setTitle("获取验证码", forState: .Normal)
        self.getCaptchaBtn.setTitleColor(yojpBlue, forState: .Normal)
        self.getCaptchaBtn.titleLabel?.font = font15
        self.getCaptchaBtn.layer.cornerRadius = 4
        self.getCaptchaBtn.layer.borderColor = yojpBlue.CGColor
        self.getCaptchaBtn.layer.borderWidth = 1
        self.getCaptchaBtn.frame = CGRectMake(self.captchaTextField.frame.origin.x+self.captchaTextField.frame.size.width+16, self.captchaTextField.frame.origin.y , (screenWidth-48)/3, 45)
        self.getCaptchaBtn.addTarget(self, action: Selector("getCodeBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.getCaptchaBtn)
        
    }
    
    func creatNextBtn() {
        self.nextBtn = UIButton(frame: CGRectMake(16, self.captchaTextField.frame.origin.y + self.captchaTextField.frame.size.height + 16, screenWidth - 32, 44))
        self.nextBtn.backgroundColor = yojpBlue
        self.nextBtn.setTitle("下一步", forState: .Normal)
        self.nextBtn.layer.cornerRadius = 4
        self.nextBtn.layer.masksToBounds = true
        self.nextBtn.addTarget(self, action: Selector("nextBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.nextBtn)
        
    }
    
    func getCodeBtnPressed() {
        
    }

    func nextBtnPressed() {
        
        if self.captchaTextField.text?.characters.count == 0 {
            SVProgressShow.showInfoWithStatus("信息不完整")
            return
        }
        
        self.navigationController?.pushViewController(UpdatePassViewController2(), animated: true)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if (touches as NSSet).anyObject()?.view != self.captchaTextField         {
            self.captchaTextField.resignFirstResponder()
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.captchaTextField.resignFirstResponder()
        return true
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
