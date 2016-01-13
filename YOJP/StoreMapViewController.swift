//
//  StoreMapViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/8.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit
import MapKit
import JPSThumbnailAnnotation

class StoreMapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    
    var customNavigationBar : UIView!
    
    
    var locationManager : CLLocationManager!
    var mapView : MKMapView!
    var currentLatitude : Double = 0.0000
    var currentLongitude : Double!
    
    var detailView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      self.view.backgroundColor = UIColor.whiteColor()
        self.creatCustomNavigationBar()
    
        self.creatMapView()
        self.creatDetailView()
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBar.alpha = 0
        
        self.startLocation()
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
    
    func creatMapView(){
        
        self.mapView = MKMapView(frame: CGRectMake(0,0,screenWidth,screenHeight-44-100))
        self.mapView?.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth]
        self.mapView?.delegate = self
        self.view.addSubview(self.mapView)
    }
    
    func creatDetailView() {
        
        self.detailView = UIView(frame: CGRectMake(0,screenHeight-40-100,screenWidth,100))
        self.detailView.backgroundColor = yojpLightCell
        self.view.addSubview(self.detailView)
        
        let addressLabel : UILabel = UILabel(frame: CGRectMake(16,16,screenWidth-32,25))
        addressLabel.text = "目标位置:某某街某某路某某号 某某店"
        addressLabel.textColor = yojpText
        addressLabel.font = font15
        self.detailView.addSubview(addressLabel)
        
        let distanceLabel : UILabel = UILabel(frame: CGRectMake(16,16+25+16,screenWidth-32,25))
        distanceLabel.text = "距您0.8公里"
        distanceLabel.textColor = yojpText
        distanceLabel.font = font15
        self.detailView.addSubview(distanceLabel)
        
    }
    
    
    func startLocation() {
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = 1.0
            self.locationManager.requestAlwaysAuthorization()
        }
        else {
            print("您关闭了的定位功能，将无法收到位置信息，建议您到系统设置打开定位功能!")
        }
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        if self.currentLatitude == 0.0000 {
            self.currentLatitude = newLocation.coordinate.latitude
            self.currentLongitude = newLocation.coordinate.longitude
            self.annotations()
            self.mapView.addAnnotations(self.annotations() as! [MKAnnotation])
        }
    }

    func annotations() ->NSArray {
        
        let annotations : NSMutableArray = []
        
        for i in 0..<3 {
            let thumbnail : JPSThumbnail = JPSThumbnail()
            thumbnail.image = UIImage(named: String(format: "image%d", i))
            thumbnail.title = "16eme-nord"
            thumbnail.subtitle = "引领时尚潮流,品牌理念;引领时尚潮流,品牌理念;引领时尚潮流,品牌理念;引领时尚潮流,品牌理念;引领时尚潮流,品牌理念;引领时尚潮流,品牌理念;"
            thumbnail.tag = i
            var num1 : Double = 1.00/Double(arc4random()%1000+200)
            var num2 : Double = 1.00/Double(arc4random()%1000+200)
            if arc4random()%2 == 0 {
                num1 = 0-num1
            }
            if arc4random()%2 == 0 {
                num2 = 0-num2
            }
            
            thumbnail.coordinate = CLLocationCoordinate2DMake(self.currentLatitude + num1, self.currentLongitude + num2)
            thumbnail.disclosureBlock = {
                tag in
                SVProgressShow.showWithStatus("展示更多内容...")
                let delayInSeconds : Double = 1
                let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
                dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                    SVProgressShow.dismiss()
                })
                
            }
            annotations.addObject(JPSThumbnailAnnotation(thumbnail: thumbnail))
            
            if i == 0 {
                self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(thumbnail.coordinate,1000,1000), animated: true)
            }
        }
        
        print(annotations)
        return annotations
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if view.conformsToProtocol(JPSThumbnailAnnotationViewProtocol) {
            
            var myView =  view as! JPSThumbnailAnnotationViewProtocol
            myView.didSelectAnnotationViewInMap(mapView)
        }
    }
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        if view.conformsToProtocol(JPSThumbnailAnnotationViewProtocol) {
            var myView =  view as! JPSThumbnailAnnotationViewProtocol
            myView.didDeselectAnnotationViewInMap(mapView)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.conformsToProtocol(JPSThumbnailAnnotationProtocol) {
            var myAnnotation =  annotation as! JPSThumbnailAnnotationProtocol
            return myAnnotation.annotationViewInMap(mapView)
            
        }
        return nil
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
