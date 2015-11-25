//
//  ViewController.swift
//  YOJP
//
//  Created by PayBay on 15/11/5.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import MapKit
import JPSThumbnailAnnotation

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    var locationManager : CLLocationManager!
    var mapView : MKMapView!
    var currentLatitude : Double = 0.0000
    var currentLongitude : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.mapView = MKMapView(frame: self.view.bounds)
        self.mapView?.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth]
        self.mapView?.delegate = self
        self.view.addSubview(self.mapView)
        
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 30, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头Blue"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backBtn)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.startLocation()
    }
    
    func startLocation() {
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = 10.0
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
            self.mapView.addAnnotations(self.annotations() as! [MKAnnotation])
        }
    }
    
    func annotations() ->NSArray {
        
        var annotations : NSMutableArray = []
        
        for i in 0..<13 {
            let thumbnail : JPSThumbnail = JPSThumbnail()
            thumbnail.image = UIImage(named: String(format: "%d", i))
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
    
    func backBtnPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



















