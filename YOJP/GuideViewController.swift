//
//  GuideViewController.swift
//  YOJP
//
//  Created by PayBay on 15/11/30.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import MMDrawerController


class GuideViewController: UIViewController, UIScrollViewDelegate {

    
    
    var pageControl : UIPageControl!
    var scrollView : UIScrollView!
    var imageView : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        
        self.creatScrollView()
        self.creatScrollImage()
        self.creatPageControll()

        // Do any additional setup after loading the view.
    }
    
    
    func creatScrollView() {
        self.scrollView = UIScrollView(frame: self.view.bounds)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(self.scrollView)
        
        self.scrollView.contentSize = CGSizeMake(3*screenWidth, 0)
        self.scrollView.pagingEnabled = true
        self.scrollView.delegate = self
    }
    
    func creatScrollImage() {
        for i in 0...2 {
            let imageView = UIImageView(frame: CGRectMake(CGFloat(i)*screenWidth, 0, screenWidth, screenHeight))
            imageView.image = UIImage(named: String(format: "Walkthroughs_%d", i))
            self.scrollView.addSubview(imageView)
            
            if i == 2 {
                let finishBtn : UIButton = UIButton(type: .Custom)
                finishBtn.center = CGPointMake(screenWidth*0.5, screenHeight*0.87)
                finishBtn.bounds = CGRectMake(0, 0, 100, 30)
                finishBtn.backgroundColor = yojpBlue
                finishBtn.layer.cornerRadius = 4
                finishBtn.setTitle("立即体验", forState: .Normal)
                finishBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                imageView.userInteractionEnabled = true
                finishBtn.addTarget(self, action: #selector(GuideViewController.gotoDrawerView), forControlEvents: .TouchUpInside)
                imageView.addSubview(finishBtn)
            }
        }
    }
    
    func creatPageControll() {
        self.pageControl = UIPageControl()
        self.pageControl.center = CGPointMake(screenWidth*0.5, screenHeight*0.95)
        self.pageControl.numberOfPages = 3
        self.pageControl.pageIndicatorTintColor = UIColor.blackColor()
        self.pageControl.currentPageIndicatorTintColor = yojpBlue
        self.pageControl.bounds = CGRectMake(0, 0, 150, 0)
        self.view.addSubview(self.pageControl)
    }
    
    func gotoDrawerView() {
        let tempAppDelegatea : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        self.presentViewController(tempAppDelegatea.leftSlideVC, animated: true) { () -> Void in
            
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
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
