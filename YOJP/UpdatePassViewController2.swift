//
//  UpdatePassViewController2.swift
//  YOJP
//
//  Created by PayBay on 15/12/9.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class UpdatePassViewController2: UIViewController,UITextFieldDelegate {

    
    var customNavigationBar : UIView!
    
    var customLabel : UILabel!
    var passwordTextField : UITextField!
    var betweenLine1 : UIImageView!
    var finishBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = yojpTableViewColor
        
        self.creatCustomNavigationBar()
        self.creatRegisterView()
        self.creatfinishBtn()
    }

    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        UIApplication.sharedApplication().statusBarStyle = .Default
//        self.navigationController?.navigationBarHidden = true
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBarHidden = false
//    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBar.alpha = 0
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.alpha = 1
    }

    
    func creatRegisterView() {
        
        self.customLabel = UILabel(frame: CGRectMake(16,20+20,screenWidth,25))
        self.customLabel.text = "新登录密码仅用于账户登录"
        self.customLabel.font = font14
        self.customLabel.textColor = yojpText
        self.customLabel.opaque = true
        self.view.addSubview(self.customLabel)
        
        
        self.passwordTextField = UITextField(frame: CGRectMake(16, self.customLabel.frame.origin.y + self.customLabel.frame.size.height+16, screenWidth-32, 45))
        self.passwordTextField.placeholder = "密码由6-20位字母、数字组成"
        self.passwordTextField.font = font14
        self.passwordTextField.secureTextEntry = true
        self.passwordTextField.delegate = self
        self.passwordTextField.keyboardType = .NumberPad
        self.passwordTextField.opaque = true
        self.view.addSubview(self.passwordTextField)
        
        self.betweenLine1 = UIImageView(frame: CGRectMake(16, self.passwordTextField.frame.origin.y+self.passwordTextField.frame.size.height, screenWidth-32, 1))
        self.betweenLine1.backgroundColor = yojpBlue
        self.view.addSubview(self.betweenLine1)
        
    }
    func creatCustomNavigationBar() {
        self.customNavigationBar = UIView(frame: CGRectMake(0,screenHeight-44,screenWidth,44))
        self.customNavigationBar.backgroundColor = yojpBlue
        
        
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 7, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.opaque = true
        self.customNavigationBar.addSubview(backBtn)
        self.view.addSubview(self.customNavigationBar)
        
    }

    func creatfinishBtn() {
        self.finishBtn = UIButton(frame: CGRectMake(16, self.passwordTextField.frame.origin.y + self.passwordTextField.frame.size.height + 16, screenWidth - 32, 44))
        self.finishBtn.backgroundColor = yojpBlue
        self.finishBtn.setTitle("完成", forState: .Normal)
        self.finishBtn.layer.cornerRadius = 4
        self.finishBtn.layer.masksToBounds = true
        self.finishBtn.addTarget(self, action: Selector("finishBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.finishBtn.titleLabel!.opaque = true
        self.view.addSubview(self.finishBtn)
        
    }

    
    func finishBtnPressed() {
        
        if self.passwordTextField.text?.characters.count == 0 {
            SVProgressShow.showInfoWithStatus("信息不完整")
            return
        }
    }

    
    
    func backClicked() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if (touches as NSSet).anyObject()?.view != self.passwordTextField         {
            self.passwordTextField.resignFirstResponder()
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.passwordTextField.resignFirstResponder()
        return true
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
