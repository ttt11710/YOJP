//
//  popPayPwdView.swift
//  PayPwdDemo
//
//  Created by yaoyunheng on 15/11/2.
//  Copyright © 2015年 yaoyunheng. All rights reserved.
//

let SCREEN_SIZE_WIDTH  = UIScreen.mainScreen().bounds.size.width
let SCREEN_SIZE_HEIGHT = UIScreen.mainScreen().bounds.size.height

import UIKit

@objc public protocol popPayDelegate {
    // MARK: - Delegate functions
    func compareCode(payCode: String)
}

public class popPayPwdView: UIView, UITextFieldDelegate {
    
    public init() {
        //可重新定义frame
        super.init(frame: CGRect(x: 0, y: SCREEN_SIZE_HEIGHT-226-120, width: SCREEN_SIZE_WIDTH, height: 226+120))
        self.hidden = true
        self.customInit()
        self.registerForKeyboardNotifications()
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //weak弱引用delegate
    public weak var delegate: popPayDelegate?

    var overlayView: UIControl!
    var backBtn : UIButton!
    var payCodeTextField: CodeTextField!
    let lineTag = 1000
    let dotTag  = 3000
    //线
    var lineLabel: UILabel?
    //圆点
    var dotLabel: UILabel?
    //密码长度默认6位
    let passWordLength = 6
    var pwdCode = ""
    
    func customInit() {
        self.backgroundColor = UIColor.whiteColor()
        overlayView = UIControl(frame: UIScreen.mainScreen().bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        overlayView.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 4, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头Blue"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("dismiss"), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(backBtn)
        
        let countLabel : UILabel = UILabel(frame: CGRectMake(64,4,SCREEN_SIZE_WIDTH-128,30))
        countLabel.text = "请输入支付密码"
        countLabel.textAlignment = .Center
        countLabel.textColor = yojpText
        countLabel.font = font17
        self.addSubview(countLabel)
        
        
        payCodeTextField = CodeTextField(frame: CGRectMake(12, 48, self.frame.width - 24, 44))
        payCodeTextField.backgroundColor = UIColor.whiteColor()
        payCodeTextField.layer.borderColor = UIColor(red: 0xe0/255.0, green: 0xe0/255.0, blue: 0xdf/255.0, alpha: 1.0).CGColor
        payCodeTextField.layer.borderWidth = 0.5
        payCodeTextField.secureTextEntry = true
        payCodeTextField.delegate = self
        payCodeTextField.tag = 102
        payCodeTextField.tintColor = UIColor.clearColor()
        payCodeTextField.textColor = UIColor.clearColor()
        payCodeTextField.font = UIFont.systemFontOfSize(30)
        payCodeTextField.keyboardType = UIKeyboardType.NumberPad
        payCodeTextField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        payCodeTextField.becomeFirstResponder()
        
        let frame = payCodeTextField.frame
        let perWidth = (frame.size.width - CGFloat(passWordLength) + 1) * 1.0 / CGFloat(passWordLength)
        //遍历密码长度，添加圆点
        for var i = 0; i < passWordLength; i++ {
            if i < passWordLength - 1 {
                lineLabel = payCodeTextField.viewWithTag(lineTag + i) as? UILabel
                if !(lineLabel != nil) {
                    lineLabel = UILabel()
                    lineLabel!.tag = lineTag + i
                    payCodeTextField.addSubview(lineLabel!)
                }
                lineLabel!.frame = CGRectMake(perWidth + (perWidth + 1) * CGFloat(i), 0, 0.5, frame.size.height)
                lineLabel!.backgroundColor = UIColor(red: 0xe0/255.0, green: 0xe0/255.0, blue: 0xdf/255.0, alpha: 1.0)
            }
            dotLabel = payCodeTextField.viewWithTag(dotTag + i) as? UILabel
            if !(dotLabel != nil) {
                dotLabel = UILabel()
                dotLabel!.tag = dotTag + i
                payCodeTextField.addSubview(dotLabel!)
            }
            dotLabel!.frame = CGRectMake((perWidth + 1) * CGFloat(i) + (perWidth - 10) * 0.5, (frame.size.height - 10) * 0.5, 10, 10)
            dotLabel!.layer.masksToBounds = true
            dotLabel!.layer.cornerRadius  = 5
            dotLabel!.backgroundColor = UIColor.blackColor()
            dotLabel!.hidden = true
        }
        self.addSubview(payCodeTextField)
    }

    public func cancelBtnPressed() {
        self.dismiss()
    }
    
    public func fadeIn() {
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.frame.origin.y = (SCREEN_SIZE_HEIGHT - self.frame.size.height) / 2 + 30
            }, completion: { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.frame.origin.y -= 30
                    }, completion: { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.05, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                            self.frame.origin.y += 10
                            }, completion: { (finished: Bool) -> Void in
                                UIView.animateWithDuration(0.05, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                                    self.frame.origin.y -= 5
                                    }, completion: { (finished: Bool) -> Void in
                                        
                                })
                        })
                })
        })
    }
    
    public func fadeOut() {
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.frame.origin.y += 30
            
            
            
            }, completion: { (finished: Bool) -> Void in
                
                self.payCodeTextField.resignFirstResponder()
                UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.frame.origin.y = SCREEN_SIZE_HEIGHT
                    self.overlayView.alpha = 0.01
                    }, completion: { (finished: Bool) -> Void in
                        if finished {
                            
                            self.overlayView.removeFromSuperview()
                            self.removeFromSuperview()
                        }
                })
        })
    }
    
    public func pop() {
        let keyWindow = UIApplication.sharedApplication().keyWindow!
        keyWindow.addSubview(overlayView)
        keyWindow.addSubview(self)
       // self.center = CGPointMake(keyWindow.bounds.size.width / 2.0,
       //     keyWindow.bounds.size.height / 2.0)
       // fadeIn()
    }
    
    public func dismiss() {
        fadeOut()
    }

    func textFieldDidChange() {
        let length = payCodeTextField.text!.characters.count
        if length == passWordLength {
            dismiss()
            delegate?.compareCode(payCodeTextField.text!)
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
        for var i = 0; i < passWordLength; i++ {
            dotLabel = payCodeTextField.viewWithTag(dotTag + i) as? UILabel
            if (dotLabel != nil) {
                dotLabel!.hidden = length <= i
            }
        }
        payCodeTextField.sendActionsForControlEvents(.ValueChanged)
    }
    
    
    func registerForKeyboardNotifications() {
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWasShown(notif : NSNotification) {
        let info : NSDictionary = notif.userInfo!
        let value : NSValue = info.objectForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyBoardSize : CGSize = value.CGRectValue().size
        print(keyBoardSize.height,SCREEN_SIZE_HEIGHT)
        self.hidden = false
    }

}
