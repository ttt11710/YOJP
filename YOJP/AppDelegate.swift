//
//  AppDelegate.swift
//  YOJP
//
//  Created by PayBay on 15/11/5.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import MMDrawerController
//import REFrostedViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var leftSlideVC : LeftSlideViewController!
    
    var firstNavigationController : UINavigationController?
    
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
//        let leftSideDrawerViewController = LeftViewController()
//        let centerViewController = MainViewController()
//        
//        let navigationController : MyNavigationController = MyNavigationController(rootViewController: centerViewController)
//        navigationController.navigationBar.translucent = false
//        navigationController.restorationIdentifier = "MMExampleCenterNavigationControllerRestorationKey"
//        let leftSideNavController : MyNavigationController = MyNavigationController(rootViewController: leftSideDrawerViewController)
//        //leftSideNavController.navigationBarHidden = true
//        leftSideNavController.restorationIdentifier = "MMExampleLeftNavigationControllerRestorationKey"
//        
//        let drawerController : MMDrawerController = MMDrawerController(centerViewController: navigationController, leftDrawerViewController: leftSideNavController)
//        drawerController.showsShadow = true
//        drawerController.restorationIdentifier = "MMDrawer"
//        drawerController.maximumLeftDrawerWidth = screenWidth-80
//        drawerController.openDrawerGestureModeMask = .All
//        drawerController.closeDrawerGestureModeMask = .All
//        drawerController.setGestureShouldRecognizeTouchBlock { (drawerController : MMDrawerController!, gesture : UIGestureRecognizer!, touch : UITouch!) -> Bool in
//            var shouldRecognizeTouch : Bool = false
//            if drawerController.openSide == MMDrawerSide.None && gesture.isKindOfClass(UIPanGestureRecognizer) {
//                let customView : UIView = drawerController.centerViewController.view
//                let location : CGPoint = touch.locationInView(customView)
//                shouldRecognizeTouch = CGRectContainsPoint(customView.bounds, location)
//            }
//
//           return shouldRecognizeTouch
//        }
//        
//        
//        drawerController.setGestureCompletionBlock { (drawerController : MMDrawerController!, gesture :UIGestureRecognizer!) -> Void in
//            
//            if drawerController.openSide == MMDrawerSide.Left {
//                MainViewController.shareMainViewController().changeShowLeftBtnTypeWithInt(1)
//             
//            }
//            else {
//                MainViewController.shareMainViewController().changeShowLeftBtnTypeWithInt(0)
//             
//            }
//            MainViewController.shareMainViewController().showORhideShowLeftViewBtn(false)
//           
//        }
//        
//        
//        
//        self.window?.tintColor = yojpBlue
//               
//        drawerController.view.backgroundColor = UIColor.whiteColor()
        
        
        let firstViewController : FirstViewController = FirstViewController()
        self.firstNavigationController = UINavigationController(rootViewController: firstViewController)
        self.firstNavigationController?.view.backgroundColor = UIColor.whiteColor()
        
        self.leftSlideVC = LeftSlideViewController(leftView: LeftViewController(), andMainView: self.firstNavigationController)
        
        //self.window?.rootViewController = self.leftSlideVC
        
        if !NSUserDefaults.standardUserDefaults().boolForKey("firstLaunch") {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstLaunch")
            //第一次启动
            self.window?.rootViewController = GuideViewController()
            
        }
        else {
           // NSUserDefaults.standardUserDefaults().setBool(false, forKey: "firstLaunch")
             self.window?.rootViewController = self.leftSlideVC
        }
        return true
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = yojpBlue
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName:font20]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), forBarMetrics:UIBarMetrics.Default)
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    
        
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.makeKeyAndVisible()
        
        
        
        
        return true
    }
    
    func application(application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [AnyObject], coder: NSCoder) -> UIViewController? {
        let key : String = (identifierComponents.last?.string) ?? ""
        
        if key == "MMDrawer" {
            return self.window?.rootViewController
        }
        else if key == "MMExampleCenterNavigationControllerRestorationKey" {
            return (self.window?.rootViewController as! MMDrawerController).centerViewController
        }
        else if key == "MMExampleLeftNavigationControllerRestorationKey" {
            return (self.window?.rootViewController as! MMDrawerController).leftDrawerViewController
        }
        else if key == "MMExampleLeftSideDrawerController" {
            let leftVC = (self.window?.rootViewController as! MMDrawerController).leftDrawerViewController
            if leftVC.isKindOfClass(UINavigationController.classForCoder()) {
                return (leftVC as! UINavigationController).topViewController
            }
            else {
                return leftVC
            }
        }
        
        return nil
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

