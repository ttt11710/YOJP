//
//  SchedulingViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/8.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class SchedulingViewController: UIViewController {

    
    var customNavigationBar : UIView!
    
    var chooseScheduingView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.creatCustomNavigationBar()
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
        
        
        let addScheduingBtn = UIButton(type: .Custom)
        addScheduingBtn.frame = CGRectMake(screenWidth-50, 7, 30, 30)
        addScheduingBtn.setBackgroundImage(UIImage(named: "新建行程"), forState: UIControlState.Normal)
        addScheduingBtn.setBackgroundImage(UIImage(named: "新建行程"), forState: UIControlState.Highlighted)
        addScheduingBtn.addTarget(self, action: Selector("addScheduingBtnClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        self.customNavigationBar.addSubview(addScheduingBtn)
        
        self.view.addSubview(self.customNavigationBar)
    }
    
    func backClicked() {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func addScheduingBtnClicked() {
        
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
