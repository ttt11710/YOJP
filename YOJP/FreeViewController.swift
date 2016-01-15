//
//  FreeViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/13.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class FreeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.creatCollectionView()
        
        // Do any additional setup after loading the view.
    }
    
    
    func creatCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        // flowLayout.headerReferenceSize = CGSizeMake(screenWidth, 37)
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 0, 0, 0)
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 0, screenWidth, screenHeight-navBarH-titleH), collectionViewLayout: flowLayout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = yojpTableViewColor
        
        self.view.addSubview(self.collectionView)
        
        
        self.collectionView.registerNib(UINib(nibName: "SearchCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchCollectionReusableViewId")
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
            self.collectionView.registerNib(UINib(nibName: "myCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCollectionViewCellId")
            
            let cellIdentifier : String = "myCollectionViewCellId"
            let cell : myCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! myCollectionViewCell
            
            cell.backgroundColor = UIColor.whiteColor()
            cell.backImageView.image = UIImage(named: String(format: "image%d", indexPath.row))
            cell.desLabel.text = "在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆"
            cell.desLabel.textColor = yojpText
            cell.desLabel.font = font15
            cell.dateLabel.text = "1小时前"
            cell.dateLabel.textColor = yojpLightText
            cell.dateLabel.font = font14
            cell.layoutIfNeeded()
            return cell
    
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(screenWidth/2-2, (screenWidth-10)/8*3+100)
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 4 {
            self.navigationController?.pushViewController(NearbyViewController(), animated: true)
        }
            
        else if indexPath.row != 0 {
            let cell : myCollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath) as! myCollectionViewCell
            let string = cell.labelLabel.text
            
            let freeDetailViewController : FreeDetailViewController = FreeDetailViewController()
            
            if string == "免费券" {
                freeDetailViewController.ticketType = "免费券"
            }
            else if string == "打折券" {
                freeDetailViewController.ticketType = "九折券"
            }
            else if string == "抵扣券" {
                freeDetailViewController.ticketType = "100元抵扣券"
            }
            else if string == "福袋" {
                freeDetailViewController.ticketType = "福袋"
            }
            
            self.navigationController?.pushViewController(freeDetailViewController, animated: true)
        }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y > oldOffsetY {
            FirstViewController.shareFirstViewController().escapeBtn.hidden = true
        }
        else {
            FirstViewController.shareFirstViewController().escapeBtn.hidden = false
        }
        
        oldOffsetY = scrollView.contentOffset.y
        
        if scrollView.contentOffset.y == 0 {
            FirstViewController.shareFirstViewController().escapeBtn.hidden = false
        }
        
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

