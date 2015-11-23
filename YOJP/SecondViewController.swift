//
//  SecondViewController.swift
//  YOJP
//
//  Created by PayBay on 15/11/23.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class SecondViewController: AMScrollingNavbarViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.creatCollectionView()
        
        // Do any additional setup after loading the view.
    }

    func creatCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        flowLayout.headerReferenceSize = CGSizeMake(screenWidth, 0)
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 0, 0, 0)
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let collectionView = UICollectionView(frame: CGRectMake(0, 64, screenWidth, screenHeight), collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = yojpTableViewColor
        
        collectionView.registerNib(UINib(nibName: "myCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCollectionViewCellId")
        collectionView.registerClass(myCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "myCollectionReusableViewId")
        
        self.view.addSubview(collectionView)
        
        self.followScrollView(collectionView)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier : String = "myCollectionViewCellId"
        let cell : myCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! myCollectionViewCell
        
        cell.backgroundColor = UIColor.whiteColor()
        cell.backImageView.image = UIImage(named: String(format: "image%d", indexPath.row+2))
        cell.desLabel.text = "在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆"
        cell.desLabel.textColor = yojpText
        cell.desLabel.font = font15
        
        cell.dateLabel.hidden = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(screenWidth, 150)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(screenWidth, 0)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var sectionHeader : myCollectionReusableView! = myCollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            sectionHeader = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "myCollectionReusableViewId", forIndexPath: indexPath) as! myCollectionReusableView
            
            sectionHeader.backgroundColor = UIColor.redColor()
            
        }
        return sectionHeader
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
