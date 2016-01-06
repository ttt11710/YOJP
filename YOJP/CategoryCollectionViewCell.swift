//
//  CategoryCollectionViewCell.swift
//  YOJP
//
//  Created by PayBay on 16/1/6.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell,UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var titleArray : NSMutableArray = ["全部","免费券","打折券","抵扣券","福袋"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.scrollView.contentSize = CGSizeMake(screenWidth*CGFloat(5), 0)
        self.scrollView.contentOffset = CGPointMake(0, 0)
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        
        for index in 0..<5 {
            
            let imageView = UIImageView(frame: CGRectMake(screenWidth * CGFloat(index), 0, screenWidth, self.frame.size.height))
            imageView.clipsToBounds = true
            imageView.contentMode = .ScaleAspectFill
            
            imageView.sd_setImageWithURL(NSURL(string: ""), placeholderImage: UIImage(named: String(format: "image%d", index)))
            imageView.tag = index
            
            imageView.userInteractionEnabled = true
            
            self.scrollView.addSubview(imageView)
            
            
        }
        
    }
    
    
    
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
                print("scrollView")
        //        if self.timer.valid {
        //            self.timer.invalidate()
        //        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        //        if !self.timer.valid {
        //            self.startTime()
        //        }
        //
        //        let page = Int(scrollView.contentOffset.x / screenWidth)
        //        if page == (imageCount + 1) {
        //            scrollView.contentOffset = CGPointMake(screenWidth, 0)
        //            self.pageControl.currentPage = 0
        //        }
        //        else if page == 0 {
        //            scrollView.contentOffset = CGPointMake(screenWidth * CGFloat(imageCount), 0)
        //            self.pageControl.currentPage = imageCount - 1
        //        }
        //        else {
        //            self.pageControl.currentPage = page - 1
        //        }
    }
}
