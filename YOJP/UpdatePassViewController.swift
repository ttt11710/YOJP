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
    
    var updatePayPassView : UIView!
    var oldPasswordLabel : UILabel!
    var oldPasswordTextField : UITextField!
    var betweenLine : UIImageView!
    var newPasswordLabel : UILabel!
    var newPasswordTextField : UITextField!
    
    var updatePayPasswordBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = yojpTableViewColor
        
        self.creatCustomNavigationBar()
        self.creatRegisterView()
        self.creatUpdatePasswordBtn()
        
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
        
        self.updatePayPassView = UIView(frame: CGRectMake(0, 20 , screenWidth, 110))
        self.updatePayPassView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.updatePayPassView)
        
        self.oldPasswordLabel = UILabel(frame: CGRectMake(16, 17, 0, 21))
        self.oldPasswordLabel.text = "旧密码"
        self.oldPasswordLabel.textColor = yojpBlue
        self.oldPasswordLabel.sizeToFit()
        self.updatePayPassView.addSubview(self.oldPasswordLabel)
        
        self.oldPasswordTextField = UITextField(frame: CGRectMake(self.oldPasswordLabel.frame.origin.x + self.oldPasswordLabel.frame.size.width + 16, 0, screenWidth - 16 - self.oldPasswordLabel.frame.size.width - 16, 55))
        self.oldPasswordTextField.placeholder = "请输入原始密码"
        self.oldPasswordTextField.delegate = self
        self.oldPasswordTextField.secureTextEntry = true
        self.updatePayPassView.addSubview(self.oldPasswordTextField)
        
        self.betweenLine = UIImageView(frame: CGRectMake(self.oldPasswordLabel.frame.origin.x, 55, self.oldPasswordTextField.frame.size.width, 1))
        self.betweenLine.backgroundColor = yojpLightCell
        self.updatePayPassView.addSubview(self.betweenLine)
        
        self.newPasswordLabel = UILabel(frame: CGRectMake(16,  55 + 17, 0, 21))
        self.newPasswordLabel.text = "新密码"
        self.newPasswordLabel.textColor = yojpBlue
        self.newPasswordLabel.sizeToFit()
        self.updatePayPassView.addSubview(self.newPasswordLabel)
        
        self.newPasswordTextField = UITextField(frame: CGRectMake(self.oldPasswordTextField.frame.origin.x, self.oldPasswordTextField.frame.size.height, self.oldPasswordTextField.frame.size.width, self.oldPasswordTextField.frame.size.height))
        self.newPasswordTextField.placeholder = "请输入新密码"
        self.newPasswordTextField.secureTextEntry = true
        self.newPasswordTextField.delegate = self
        self.updatePayPassView.addSubview(self.newPasswordTextField)
        
    }
    
    func creatUpdatePasswordBtn() {
        self.updatePayPasswordBtn = UIButton(frame: CGRectMake(16, screenHeight - 100, screenWidth - 32, 44))
        self.updatePayPasswordBtn.backgroundColor = yojpBlue
        self.updatePayPasswordBtn.setTitle("重置密码", forState: .Normal)
        self.updatePayPasswordBtn.layer.cornerRadius = 4
        self.updatePayPasswordBtn.layer.masksToBounds = true
        self.updatePayPasswordBtn.addTarget(self, action: Selector("updatePassBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.updatePayPasswordBtn)
        
    }
    
    
    func updatePassBtnPressed() {
        
        if self.oldPasswordTextField.text?.characters.count == 0 || self.newPasswordTextField.text?.characters.count == 0 {
            SVProgressShow.showInfoWithStatus("信息不完整")
            return
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if (touches as NSSet).anyObject()?.view != self.oldPasswordTextField && (touches as NSSet).anyObject()?.view != self.newPasswordTextField
        {
            self.oldPasswordTextField.resignFirstResponder()
            self.newPasswordTextField.resignFirstResponder()
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.oldPasswordTextField.resignFirstResponder()
        self.newPasswordTextField.resignFirstResponder()
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
