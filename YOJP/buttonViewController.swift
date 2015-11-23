//
//  buttonViewController.swift
//  YOJP
//
//  Created by PayBay on 15/11/19.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import MMDrawerController

class buttonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let btn : UIButton = UIButton(type: .Custom)
        btn.frame = CGRectMake(screenWidth/2-40, 100, 80, 40)
        btn.setTitle("下一页", forState: UIControlState.Normal)
        btn.setTitleColor(yojpBlue, forState: UIControlState.Normal)
        btn.addTarget(self, action: Selector("gotoView"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }
    
    func gotoView() {
        let leftSideDrawerViewController = LeftViewController()
        let centerViewController = MainViewController()
        
        let navigationController : MyNavigationController = MyNavigationController(rootViewController: centerViewController)
        navigationController.restorationIdentifier = "MMExampleCenterNavigationControllerRestorationKey"
        
        let leftSideNavController : MyNavigationController = MyNavigationController(rootViewController: leftSideDrawerViewController)
        leftSideNavController.restorationIdentifier = "MMExampleLeftNavigationControllerRestorationKey"
        
        let drawerController : MMDrawerController = MMDrawerController(centerViewController: navigationController, leftDrawerViewController: leftSideNavController)
        drawerController.showsShadow = false
        drawerController.restorationIdentifier = "MMDrawer"
        drawerController.maximumLeftDrawerWidth = 200
        drawerController.openDrawerGestureModeMask = .All
        drawerController.closeDrawerGestureModeMask = .All
        drawerController.setGestureShouldRecognizeTouchBlock { (drawerController : MMDrawerController!, gesture : UIGestureRecognizer!, touch : UITouch!) -> Bool in
            var shouldRecognizeTouch : Bool = false
            if drawerController.openSide == MMDrawerSide.None && gesture.isKindOfClass(UIPanGestureRecognizer) {
                let customView : UIView = drawerController.centerViewController.view
                let location : CGPoint = touch.locationInView(customView)
                shouldRecognizeTouch = CGRectContainsPoint(customView.bounds, location)
            }
            return shouldRecognizeTouch
        }
       
        self.navigationController?.navigationBarHidden = true
//        let navigationController : MyNavigationController = MyNavigationController(rootViewController: drawerController)
        self.navigationController?.pushViewController(drawerController, animated: true)
        drawerController.centerViewController.navigationController

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
