//
//  ContributePreViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/12.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class ContributePreViewController: UIViewController {

    
    var customNavigationBar : UIView!
    
    var scrollView : UIScrollView!
    var imageArray : NSMutableArray! = []
    var contributeViewText : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = yojpTableViewColor
        
        self.creatScrollView()
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
        
        self.view.addSubview(self.customNavigationBar)
        
    }
    
    func creatScrollView() {
        
        let num1 = (self.imageArray.count-1)%3 == 0 ? 0:1
        
        let num = (self.imageArray.count-1)/3 + num1
        
        self.scrollView = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight-44))
        self.scrollView.backgroundColor = UIColor.whiteColor()
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.view.addSubview(self.scrollView)
        
        for i in 0..<self.imageArray.count-1 {
            let imageView : UIImageView = UIImageView(frame: CGRectMake(CGFloat(i%3+1)*10+CGFloat(i%3)*(screenWidth-40)/3, 10*CGFloat(i/3+1)+CGFloat(i/3)*(screenWidth-40)/3+10, (screenWidth-40)/3, (screenWidth-40)/3))
            
            imageView.image = self.imageArray[i] as? UIImage
            
            self.scrollView.addSubview(imageView)
        }
        
        let contributeLabel : UILabel = UILabel(frame: CGRectMake(8,10+((screenWidth-40)/3+10)*CGFloat(num)+20,screenWidth-16,30))
        contributeLabel.numberOfLines = 10
        contributeLabel.text = self.contributeViewText
        contributeLabel.textColor = yojpText
        self.scrollView.addSubview(contributeLabel)
        
        
        let contributeBtn : UIButton = UIButton(frame: CGRectMake(16,contributeLabel.frame.origin.y + contributeLabel.frame.size.height+20,screenWidth-32,44))
        contributeBtn.setTitle("完成", forState: .Normal)
        contributeBtn.backgroundColor = yojpBlue
        contributeBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        contributeBtn.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        contributeBtn.titleLabel?.font = font15
        contributeBtn.addTarget(self, action: Selector("finishContributePreview"), forControlEvents: .TouchUpInside)
        self.scrollView.addSubview(contributeBtn)
        
        
        self.scrollView.contentSize = CGSizeMake(0, 10+((screenWidth-40)/3+10)*CGFloat(num)+20+contributeLabel.frame.size.height+20+44+16)
    }
    
    func finishContributePreview() {
       SVProgressShow.showSuccessWithStatus("投稿成功!等待核实")
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
