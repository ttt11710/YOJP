//
//  ShowImageViewController.swift
//  YOJP
//
//  Created by PayBay on 16/2/23.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit
import SDWebImage

class SubPageViewController : UIViewController,UIAlertViewDelegate {
    
    var index : NSInteger!
    var urlStr : String!
    var imageView : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
//        self.imageView = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        self.view.addSubview(self.imageView)
        self.imageView.contentMode = .ScaleAspectFill
        
//        self.imageView.sd_setImageWithURL(NSURL(string: ""), placeholderImage: UIImage(named: String(format: "%@.jpg", self.urlStr))) { (image, error, cacheType, imageUrl) -> Void in
//            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                let scaleHeight : CGFloat = screenHeight * ((self.imageView.image?.size.height)!/(self.imageView.image?.size.width)!)
//                self.imageView.frame = CGRectMake(0, (screenHeight-scaleHeight)/2, screenWidth, scaleHeight)
//            })
//        }
        self.imageView.userInteractionEnabled = true
        let pinch : UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(SubPageViewController.pinchGestureEven(_:)))
        self.imageView.addGestureRecognizer(pinch)
        
        
        // Do any additional setup after loading the view.
    }
    
    func pinchGestureEven(sender : UIPinchGestureRecognizer) {
        
        sender.view?.layer.transform = CATransform3DScale((sender.view?.layer.transform)!, sender.scale, sender.scale, 1)
        sender.scale = 1.0
    }
}




class ShowImageViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var showImageNsstring : String!
    var imageArray : NSArray!
    var currentImageIndex : NSInteger!
    var showImageView : UIImageView!
    
    var pageViewController : UIPageViewController!
    var viewControllers : NSMutableArray!
    var pageControl : UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blackColor()
        self.view.userInteractionEnabled = true
        
        let tapGestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ShowImageViewController.tapGrstureEven(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        self.showImageView = UIImageView()
        if self.imageArray == nil || self.imageArray.count <= 1 {
            self.showImageView.contentMode = .ScaleAspectFill
            self.showImageView.sd_setImageWithURL(NSURL(string: self.showImageNsstring), placeholderImage: UIImage(named: "启动页"), completed: { (image, error, cacheType, imageURL) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let scaleHeight : CGFloat = screenHeight * ((self.showImageView.image?.size.height)!/(self.showImageView.image?.size.width)!)
                    self.showImageView.frame = CGRectMake(0, (screenHeight-scaleHeight)/2, screenWidth, scaleHeight)
                })
            })
            
            self.showImageView.userInteractionEnabled = true
            
            let pinch : UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(SubPageViewController.pinchGestureEven(_:)))
            self.showImageView.addGestureRecognizer(pinch)
        }
        else {
            
            
            print(self.imageArray)
            self.viewControllers = NSMutableArray()
            self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
            self.pageViewController.delegate = self
            self.pageViewController.dataSource = self
            
           // var i : NSInteger = 0
            for i  in 0..<self.imageArray.count-1 {
                let subPageViewController : SubPageViewController = SubPageViewController()
               // subPageViewController.urlStr = newUrlStr as! String
                
                subPageViewController.imageView = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
                subPageViewController.index = i
                self.viewControllers.addObject(subPageViewController)
                
                var scaleHeight : CGFloat = (self.imageArray[i].size.height)*screenWidth/(self.imageArray[i].size.width)
                
                scaleHeight = scaleHeight > screenHeight ? screenHeight : scaleHeight
                
              //  let scaleHeight : CGFloat = screenHeight * ((self.imageArray[i].size.height)/(self.imageArray[i].size.width))
                
                subPageViewController.imageView.frame = CGRectMake(0, (screenHeight-scaleHeight)/2, screenWidth, scaleHeight)
                subPageViewController.imageView.image = self.changeImageSize(self.imageArray[i] as! UIImage, byScalingToSize: CGSize(width: screenWidth, height: scaleHeight))
                print(scaleHeight)
                print(subPageViewController.imageView)
            }
            
            let subPageViewController : SubPageViewController = self.viewControllers[self.currentImageIndex] as! SubPageViewController
            self.pageViewController.setViewControllers([subPageViewController], direction: .Forward, animated: true, completion: { (finished : Bool) -> Void in
                
            })
            
            self.view.addSubview(self.pageViewController.view)
            
            self.pageControl = UIPageControl(frame: CGRectMake((self.view.bounds.size.width-200)/2, self.view.bounds.size.height-100,200,30))
            self.pageControl.enabled = false
            self.pageControl.numberOfPages = self.imageArray.count-1
            self.pageControl.currentPage = self.currentImageIndex
            self.view.addSubview(self.pageControl)
            
            
        }
    }
    
    
    func pinchGestureEven(sender : UIPinchGestureRecognizer) {
        
        sender.view?.layer.transform = CATransform3DScale((sender.view?.layer.transform)!, sender.scale, sender.scale, 1)
        sender.scale = 1.0
    }
    
    func tapGrstureEven(sender : UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let subPageViewController : SubPageViewController = pageViewController.viewControllers![0] as! SubPageViewController
        
        self.currentImageIndex = subPageViewController.index
        self.currentImageIndex = self.currentImageIndex + 1
        
        if self.currentImageIndex >= self.imageArray.count-1 {
            return nil
        }
        
        return self.viewControllers[self.currentImageIndex] as? UIViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let subPageViewController : SubPageViewController = pageViewController.viewControllers![0] as! SubPageViewController
        
        self.currentImageIndex = subPageViewController.index
        self.currentImageIndex = self.currentImageIndex - 1
        
        if self.currentImageIndex < 0 {
            return nil
        }
        
        return self.viewControllers[self.currentImageIndex] as? UIViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        let subPageViewController : SubPageViewController = pageViewController.viewControllers![0] as! SubPageViewController
        subPageViewController.imageView.layer.transform = CATransform3DIdentity
    }

    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let subPageViewController : SubPageViewController = pageViewController.viewControllers![0] as! SubPageViewController
        self.pageControl.currentPage = subPageViewController.index
    }
    
    
    func changeImageSize(image : UIImage , byScalingToSize : CGSize) -> UIImage {
        let sourceImage : UIImage = image
        var newImage : UIImage = UIImage()
        
        UIGraphicsBeginImageContext(byScalingToSize)
        
        var thumbnailRect : CGRect = CGRectZero
        thumbnailRect.origin = CGPointZero
        thumbnailRect.size.width = byScalingToSize.width
        thumbnailRect.size.height = byScalingToSize.height
        
        sourceImage.drawInRect(thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
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
