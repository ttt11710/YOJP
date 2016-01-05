//
//  HelpCenterViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/7.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class HelpCenterViewController: UIViewController {

    
    var customNavigationBar : UIView!
    var scrollView : UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.creatCustomNavigationBar()
        self.creatScrollView()
        
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
        self.scrollView = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight-44))
        self.scrollView.contentSize = CGSizeMake(0, screenHeight+20)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.scrollView)
        
        let messageDetailLabel : UILabel = UILabel(frame: CGRectMake(8,30,screenWidth-16,20))
        messageDetailLabel.text = "中国驻日本大使馆\n   地址：东京都港区元麻布3-4-33\n   网址：www.china-embassy.or.jp/chn\n联系方式\n   0081-3-3403-3388（总机）\n   0081-3-3403-3380（值班)\n   0081-3-5785-6868（签证、证件查询\n\n中国驻大阪总领事馆\n   地址：大阪府大阪市西区靱本町3-9-2\n   咨询电话：0081-6-6445-9481/2\n   应急电话:0081-90-6673-6659（仅限事件、事故、伤亡等紧急情况\n\n重要电话\n   日本国家区号：0081\n   电话号码查询台：104\n   外语应答急救：#9110\n   警察局英语热线：0081-3-35010110\n   匪警：110\n   救护车以及火警：119\n   日本旅游电话：0081-3-350034400（上午九点至下午五点\n\n在紧急情况下，可以直接使用公用电话，无须投入10日元的硬币。只要您需要看医生或者需要急救，请与饭店服务台联系，或者请周围的人帮助。\n\n如果您将包裹等物品遗忘在车站或者其他公共场所，可以到站长室或就近的派出所寻求英语协助。如果遗忘在出租汽车上，请到饭店服务台查询，出租汽车司机经常将物品送到您住的饭店。"
        messageDetailLabel.textColor = yojpText
        messageDetailLabel.font = font15
        messageDetailLabel.numberOfLines = 0
        messageDetailLabel.sizeToFit()
        self.scrollView.addSubview(messageDetailLabel)
        
        
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
