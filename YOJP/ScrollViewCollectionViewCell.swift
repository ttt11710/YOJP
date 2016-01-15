//
//  ScrollViewCollectionViewCell.swift
//  YOJP
//
//  Created by PayBay on 15/11/25.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import SDWebImage

class ScrollViewCollectionViewCell: UICollectionViewCell,UIScrollViewDelegate {

    
    var timer : NSTimer!
    var imageCount : Int = 3
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.scrollView.contentSize = CGSizeMake(screenWidth*CGFloat(imageCount+2), 0)
        self.scrollView.contentOffset = CGPointMake(screenWidth, 0)
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.scrollView.backgroundColor = UIColor.whiteColor()
        
        self.pageControl.numberOfPages = imageCount
        self.pageControl.currentPage = 0
        self.pageControl.addTarget(self, action: Selector(""), forControlEvents: .ValueChanged)
        self.pageControl.currentPageIndicatorTintColor = yojpBlue
        self.pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        
        for index in 0..<(imageCount+2) {
            
            let imageView = UIImageView(frame: CGRectMake(screenWidth * CGFloat(index), 0, screenWidth, self.frame.size.height))
            imageView.clipsToBounds = true
            imageView.backgroundColor = UIColor.whiteColor()
            imageView.contentMode = .ScaleAspectFill
            if index == 0 {
                imageView.sd_setImageWithURL(NSURL(string: ""), placeholderImage: UIImage(named: "back3"))
                imageView.tag = imageCount
            }
            else if index == imageCount+1 {
                imageView.sd_setImageWithURL(NSURL(string: ""), placeholderImage: UIImage(named: "back1"))
                imageView.tag = 0
            }
            else {
                imageView.sd_setImageWithURL(NSURL(string: ""), placeholderImage: UIImage(named: String(format: "back%d", index)))
                imageView.tag = index-1
            }
            
            imageView.userInteractionEnabled = true
            
            self.scrollView.addSubview(imageView)
            
            
            
            let describeLabel = UILabel(frame: CGRectMake(10,130,screenWidth-20,20))
            
            if index == 2 {
                describeLabel.text = "这个包有点脏又有点味道，也不怎么时髦，它为何会风靡全球?"
            }
            else {
                describeLabel.text = "宜家为什么很少在中国打广告？"
            }
            
            describeLabel.numberOfLines = 2
            describeLabel.font = font17
            describeLabel.textColor = UIColor.whiteColor()
            describeLabel.sizeToFit()
            imageView.addSubview(describeLabel)
            
            describeLabel.frame = CGRectMake(10, 200-30-describeLabel.frame.size.height, describeLabel.frame.size.width, describeLabel.frame.size.height)
            
            let labelView = LabelView(frame: CGRectMake(10,describeLabel.frame.origin.y-30,100,20))
            imageView.addSubview(labelView)
            
        }

        if self.timer == nil {
            self.startTime()
        }

//        if self.timer != nil {
//            if self.timer.valid {
//                self.timer.invalidate()
//            }
//        }

    }
    
    
    func startTime() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("timerFun"), userInfo: nil, repeats: true)
    }
    
    func timerFun() {
        
        self.pageControl.currentPage = (self.pageControl.currentPage+1)%imageCount
        if self.pageControl.currentPage == 0 {
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.scrollView.contentOffset = CGPointMake(CGFloat(self.imageCount+1)*screenWidth, 0)
                }, completion: { (finished : Bool) -> Void in
                    
                    self.scrollView.contentOffset = CGPointMake(screenWidth, 0)
            })
        }
        else {
            self.scrollView.setContentOffset(CGPointMake(CGFloat(self.pageControl.currentPage+1)*screenWidth, 0), animated: true)
        }
        
    }
    
    func pageControlValueChanged() {
        
        self.scrollView.setContentOffset(CGPointMake((CGFloat(self.pageControl.currentPage) + 1)*screenWidth, 0), animated: true)
        
    }
    
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
        if self.timer.valid {
            self.timer.invalidate()
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if !self.timer.valid {
            self.startTime()
        }
        
        let page = Int(scrollView.contentOffset.x / screenWidth)
        if page == (imageCount + 1) {
            scrollView.contentOffset = CGPointMake(screenWidth, 0)
            self.pageControl.currentPage = 0
        }
        else if page == 0 {
            scrollView.contentOffset = CGPointMake(screenWidth * CGFloat(imageCount), 0)
            self.pageControl.currentPage = imageCount - 1
        }
        else {
            self.pageControl.currentPage = page - 1
        }
    }
}
