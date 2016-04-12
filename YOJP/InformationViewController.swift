//
//  InformationViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/12.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController,UITextFieldDelegate {

    
    var customNavigationBar : UIView!
    var scrollView : UIScrollView!
    
    
    var nameTextField : UITextField!
    var phoneTextField : UITextField!
    var IDCardTextField : UITextField!
    var BankAccountTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.creatScrollView()
        self.creatCustomNavigationBar()
        
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBar.alpha = 0
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.alpha = 1
    }
    
    func creatScrollView() {
        self.scrollView = UIScrollView(frame: CGRectMake(0,20,screenWidth,screenHeight-20-44))
        self.scrollView.contentSize = CGSizeMake(0, screenHeight-20-44)
        self.scrollView.contentOffset = CGPointMake(0, 0)
        self.scrollView.backgroundColor = yojpTableViewColor
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.scrollView)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InformationViewController.tapInScrollView(_:)))
        self.scrollView.addGestureRecognizer(tap)
        
        
        let nameLabel : UILabel = UILabel(frame: CGRectMake(0,40,100,25))
        nameLabel.text = "姓名:"
        nameLabel.textColor = yojpText
        nameLabel.textAlignment = .Right
        nameLabel.font = font15
        nameLabel.opaque = true
        self.scrollView.addSubview(nameLabel)
        
        self.nameTextField = UITextField(frame: CGRectMake(nameLabel.frame.origin.x + nameLabel.frame.size.width + 8, nameLabel.frame.origin.y - 8,screenWidth - nameLabel.frame.origin.x-nameLabel.frame.size.width-8-32,nameLabel.frame.size.height+16))
        self.nameTextField.backgroundColor = UIColor.whiteColor()
        self.nameTextField.placeholder = "请输入真实姓名"
        self.nameTextField.textColor = yojpText
        self.nameTextField.font = font15
        self.nameTextField.layer.borderColor = yojpText.CGColor
        self.nameTextField.layer.borderWidth = 1
        self.nameTextField.delegate = self
        self.nameTextField.opaque = true
        self.scrollView.addSubview(self.nameTextField)
        
        let phoneLabel : UILabel = UILabel(frame: CGRectMake(0,nameLabel.frame.origin.y+nameLabel.frame.size.height+24,100,25))
        phoneLabel.text = "手机号:"
        phoneLabel.textColor = yojpText
        phoneLabel.textAlignment = .Right
        phoneLabel.font = font15
        phoneLabel.opaque = true
        self.scrollView.addSubview(phoneLabel)
        
       self.phoneTextField = UITextField(frame: CGRectMake(phoneLabel.frame.origin.x + phoneLabel.frame.size.width + 8, phoneLabel.frame.origin.y - 8,screenWidth - phoneLabel.frame.origin.x-phoneLabel.frame.size.width-8-32,phoneLabel.frame.size.height+16))
        self.phoneTextField.backgroundColor = UIColor.whiteColor()
        self.phoneTextField.placeholder = "18267856123"
        self.phoneTextField.textColor = yojpText
        self.phoneTextField.font = font15
        self.phoneTextField.layer.borderColor = yojpText.CGColor
        self.phoneTextField.layer.borderWidth = 1
        self.phoneTextField.delegate = self
        self.phoneTextField.opaque = true
        self.scrollView.addSubview(self.phoneTextField)
        
        let tipLabel : UILabel = UILabel()
        tipLabel.text = "银行卡绑定的手机号"
        tipLabel.textAlignment = .Right
        tipLabel.bounds = CGRectMake(0, 0, 200, 20)
        tipLabel.center = CGPointMake(phoneTextField.frame.origin.x+phoneTextField.frame.size.width-100, phoneTextField.frame.origin.y + phoneTextField.frame.size.height + 15)
        tipLabel.textColor = yojpText
        tipLabel.font = font14
        tipLabel.opaque = true
        self.scrollView.addSubview(tipLabel)
        
        let IDCardLabel : UILabel = UILabel(frame: CGRectMake(0,phoneLabel.frame.origin.y+phoneLabel.frame.size.height+24 + 20,100,25))
        IDCardLabel.text = "身份证号:"
        IDCardLabel.textColor = yojpText
        IDCardLabel.textAlignment = .Right
        IDCardLabel.font = font15
        IDCardLabel.opaque = true
        self.scrollView.addSubview(IDCardLabel)
        
        self.IDCardTextField = UITextField(frame: CGRectMake(IDCardLabel.frame.origin.x + IDCardLabel.frame.size.width + 8, IDCardLabel.frame.origin.y - 8,screenWidth - IDCardLabel.frame.origin.x-IDCardLabel.frame.size.width-8-32,IDCardLabel.frame.size.height+16))
        self.IDCardTextField.backgroundColor = UIColor.whiteColor()
        self.IDCardTextField.textColor = yojpText
        self.IDCardTextField.font = font15
        self.IDCardTextField.layer.borderColor = yojpText.CGColor
        self.IDCardTextField.layer.borderWidth = 1
        self.IDCardTextField.delegate = self
        self.scrollView.addSubview(self.IDCardTextField)
        
        let BankAccountLabel : UILabel = UILabel(frame: CGRectMake(0,IDCardLabel.frame.origin.y+IDCardLabel.frame.size.height+24,100,25))
        BankAccountLabel.text = "银行卡号:"
        BankAccountLabel.textColor = yojpText
        BankAccountLabel.textAlignment = .Right
        BankAccountLabel.font = font15
        BankAccountLabel.opaque = true
        self.scrollView.addSubview(BankAccountLabel)
        
        self.BankAccountTextField = UITextField(frame: CGRectMake(BankAccountLabel.frame.origin.x + BankAccountLabel.frame.size.width + 8, BankAccountLabel.frame.origin.y - 8,screenWidth - BankAccountLabel.frame.origin.x-BankAccountLabel.frame.size.width-8-32,BankAccountLabel.frame.size.height+16))
        self.BankAccountTextField.backgroundColor = UIColor.whiteColor()
        self.BankAccountTextField.placeholder = "上海银行银行卡"
        self.BankAccountTextField.textColor = yojpText
        self.BankAccountTextField.font = font15
        self.BankAccountTextField.layer.borderColor = yojpText.CGColor
        self.BankAccountTextField.layer.borderWidth = 1
        self.BankAccountTextField.delegate = self
        self.scrollView.addSubview(self.BankAccountTextField)
        
        
        let submitBtn : UIButton = UIButton(frame: CGRectMake(16,screenHeight - 20-44-100,screenWidth-32,44))
        submitBtn.setTitle("提交", forState: .Normal)
        submitBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        submitBtn.titleLabel!.font = font16
        submitBtn.backgroundColor = yojpBlue
        submitBtn.addTarget(self, action: #selector(InformationViewController.submitBtnPressed), forControlEvents: .TouchUpInside)
        submitBtn.layer.cornerRadius = 4
        submitBtn.titleLabel!.opaque = true
        self.scrollView.addSubview(submitBtn)
        
    }

    func creatCustomNavigationBar() {
        self.customNavigationBar = UIView(frame: CGRectMake(0,screenHeight-44,screenWidth,44))
        self.customNavigationBar.backgroundColor = yojpBlue
        
        
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 7, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: #selector(InformationViewController.backClicked), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.opaque = true
        self.customNavigationBar.addSubview(backBtn)
        self.view.addSubview(self.customNavigationBar)
        
    }
    
    func submitBtnPressed() {
        SVProgressShow.showSuccessWithStatus("提交成功!")
    }

    func backClicked() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
   
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.phoneTextField.resignFirstResponder()
        self.IDCardTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.BankAccountTextField.resignFirstResponder()
        
        return true
    }
    
    func tapInScrollView(tap : UITapGestureRecognizer) {
       
        print(tap.view)
        self.phoneTextField.resignFirstResponder()
        self.IDCardTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.BankAccountTextField.resignFirstResponder()
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
