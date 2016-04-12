//
//  GoodsDetailViewController.swift
//  YOJP
//
//  Created by PayBay on 16/3/16.
//  Copyright © 2016年 PayBay. All rights reserved.
//


//好物详情
import UIKit

class GoodsDetailViewController: UIViewController {

    var scrollView : UIScrollView!
    var cardDetail : UIView!
    var count : Int = 1
    var countLabel : UILabel!
    
    var dataArray : NSMutableArray = ["WIFI","免税","银联","海淘","无烟区"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let rightButtonItem1 : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "u83"), style: .Done, target: self, action: #selector(GoodsDetailViewController.rightBtnPress(_:)))
        rightButtonItem1.tag = 1
        
        let rightButtonItem2 : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "u85"), style: .Done, target: self, action: #selector(GoodsDetailViewController.rightBtnPress(_:)))
        rightButtonItem2.tag = 2
        
        let rightButtonItem3 : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "u37"), style: .Done, target: self, action: #selector(GoodsDetailViewController.rightBtnPress(_:)))
        rightButtonItem3.tag = 3
        
        self.navigationItem.setRightBarButtonItems([rightButtonItem3,rightButtonItem2,rightButtonItem1], animated: true)
        
        self.creatScrollView()
        self.creatInfoView()
        // Do any additional setup after loading the view.
    }
    
    func rightBtnPress(sender : UIBarButtonItem) {
        switch sender.tag {
        case 1:
            print("海淘页面")
        case 2:
            print("商家页面")
        default:
            print("购物车")
        }
    }

    func creatScrollView() {
        self.scrollView = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight-64))
        self.scrollView.contentSize = CGSizeMake(0, screenHeight)
        self.scrollView.contentOffset = CGPointMake(0, 0)
        self.scrollView.backgroundColor = yojpTableViewColor
        self.view.addSubview(self.scrollView)
    }
    
    func creatInfoView() {
        
        self.cardDetail = UIView(frame: CGRectMake(0,4,screenWidth,290))
        self.cardDetail.backgroundColor = UIColor.whiteColor()
        self.scrollView.addSubview(self.cardDetail)
        
        let imageView : UIImageView = UIImageView(frame: CGRectMake(0, 0, self.cardDetail.frame.width, 220))
        imageView.image = UIImage(named: "优惠推荐2")
        self.cardDetail.addSubview(imageView)
        
        let nameLabel : UILabel = UILabel(frame: CGRectMake(16,228,200,30))
        nameLabel.text = "狂欢节99元现金券"
        nameLabel.font = font14
        nameLabel.textColor = yojpText
        nameLabel.sizeToFit()
        self.cardDetail.addSubview(nameLabel)
        
        let priceLabel : UILabel = UILabel(frame: CGRectMake(nameLabel.frame.origin.x,nameLabel.frame.size.height+nameLabel.frame.origin.y+8,30,30))
        priceLabel.text = "￥1"
        priceLabel.font = font18
        priceLabel.textColor = yojpBlue
        self.cardDetail.addSubview(priceLabel)
        
        
        let likeBtn : CallBackButton = CallBackButton(frame: CGRectMake(screenWidth-84,nameLabel.frame.origin.y+nameLabel.frame.size.height,24,24))
        likeBtn.setBackgroundImage(UIImage(named: "u22"), forState: .Normal)
        likeBtn.setupBlock()
        likeBtn.callBack = { tag in
            print("收藏")
        }
        self.cardDetail.addSubview(likeBtn)
        
        
        let shareBtn : CallBackButton = CallBackButton(frame: CGRectMake(screenWidth-44,nameLabel.frame.origin.y+nameLabel.frame.size.height,24,24))
        shareBtn.setBackgroundImage(UIImage(named: "u35"), forState: .Normal)
        shareBtn.setupBlock()
        shareBtn.callBack = { tag in
            print("分享")
        }
        self.cardDetail.addSubview(shareBtn)

        
        let useTicketLabel : UILabel = UILabel(frame: CGRectMake(32,self.cardDetail.frame.origin.y+self.cardDetail.frame.size.height+8,200,30))
        useTicketLabel.text = "已有100人领取"
        useTicketLabel.font = font13
        useTicketLabel.textColor = yojpLightText
        useTicketLabel.sizeToFit()
        self.scrollView.addSubview(useTicketLabel)
        
        let restTicketLabel : UILabel = UILabel(frame: CGRectMake(useTicketLabel.frame.origin.x+useTicketLabel.frame.size.width+30,useTicketLabel.frame.origin.y,200,30))
        restTicketLabel.text = "剩余200张"
        restTicketLabel.font = font13
        restTicketLabel.textColor = yojpLightText
        restTicketLabel.sizeToFit()
        self.scrollView.addSubview(restTicketLabel)
        
        let buyCountLabel : UILabel = UILabel(frame: CGRectMake(32,useTicketLabel.frame.origin.y+useTicketLabel.frame.size.height+20,200,35))
        buyCountLabel.text = "购买数量"
        buyCountLabel.font = font15
        buyCountLabel.textColor = yojpText
        buyCountLabel.sizeToFit()
        self.scrollView.addSubview(buyCountLabel)
        
        let reduceCallBackBtn : CallBackButton = CallBackButton(frame: CGRectMake(buyCountLabel.frame.origin.x+buyCountLabel.frame.size.width+16,useTicketLabel.frame.origin.y+useTicketLabel.frame.size.height+16,80,30))
        reduceCallBackBtn.setTitle("-", forState: .Normal)
        reduceCallBackBtn.setTitleColor(yojpText, forState: .Normal)
        reduceCallBackBtn.backgroundColor = UIColor.whiteColor()
        reduceCallBackBtn.layer.borderWidth = 1
        reduceCallBackBtn.layer.borderColor = yojpTableViewColor.CGColor
        reduceCallBackBtn.setupBlock()
        reduceCallBackBtn.callBack = { tag in
            self.count = self.count-1
        }
        self.scrollView.addSubview(reduceCallBackBtn)
        
        self.countLabel = UILabel(frame: CGRectMake(reduceCallBackBtn.frame.origin.x+reduceCallBackBtn.frame.size.width+16,useTicketLabel.frame.origin.y+useTicketLabel.frame.size.height+20,40,30))
        self.countLabel.text = String(format: "%d", self.count)
        self.countLabel.font = font15
        self.countLabel.textColor = yojpText
        self.countLabel.sizeToFit()
        self.scrollView.addSubview(self.countLabel)
        
        
        let addCallBackBtn : CallBackButton = CallBackButton(frame: CGRectMake(self.countLabel.frame.origin.x+self.countLabel.frame.size.width+16,useTicketLabel.frame.origin.y+useTicketLabel.frame.size.height+16,80,30))
        addCallBackBtn.setTitle("+", forState: .Normal)
        addCallBackBtn.backgroundColor = UIColor.whiteColor()
        addCallBackBtn.setTitleColor(yojpText, forState: .Normal)
        addCallBackBtn.layer.borderWidth = 1
        addCallBackBtn.layer.borderColor = yojpTableViewColor.CGColor
        addCallBackBtn.setupBlock()
        addCallBackBtn.callBack = { tag in
            self.count = self.count+1
        }
        self.scrollView.addSubview(addCallBackBtn)
        
        let buyCardCallBackButton : CallBackButton = CallBackButton(frame: CGRectMake(16,addCallBackBtn.frame.size.height+addCallBackBtn.frame.origin.y+16,screenWidth/2-32,35))
        buyCardCallBackButton.setTitleColor(yojpText, forState: .Normal)
        buyCardCallBackButton.setTitle("购物车", forState: .Normal)
        buyCardCallBackButton.titleLabel?.font = font15
        buyCardCallBackButton.backgroundColor = UIColor.whiteColor()
        buyCardCallBackButton.layer.borderWidth = 1
        buyCardCallBackButton.layer.borderColor = yojpTableViewColor.CGColor
        buyCardCallBackButton.setupBlock()
        buyCardCallBackButton.callBack = { tag in
            print("加入购物车")
        }
        self.scrollView.addSubview(buyCardCallBackButton)
        
        let buyCallBackButton : CallBackButton = CallBackButton(frame: CGRectMake(screenWidth/2+8,addCallBackBtn.frame.size.height+addCallBackBtn.frame.origin.y+16,screenWidth/2-32,35))
        buyCallBackButton.setTitleColor(yojpText, forState: .Normal)
        buyCallBackButton.setTitle("立即购买", forState: .Normal)
        buyCallBackButton.titleLabel?.font = font15
        buyCallBackButton.backgroundColor = UIColor.whiteColor()
        buyCallBackButton.layer.borderWidth = 1
        buyCallBackButton.layer.borderColor = yojpTableViewColor.CGColor
        buyCallBackButton.setupBlock()
        buyCallBackButton.callBack = { tag in
            
            print("立即购买")
        }
        self.scrollView.addSubview(buyCallBackButton)
        
        //使用说明
        let instructionView : UIView = UIView()
        instructionView.backgroundColor = UIColor.whiteColor()
        instructionView.layer.borderWidth = 1
        instructionView.layer.borderColor = yojpTableViewColor.CGColor
        self.scrollView.addSubview(instructionView)
        
        let instructionTitleLabel : UILabel = UILabel(frame: CGRectMake(16,8,100,30))
        instructionTitleLabel.text = "使用说明"
        instructionTitleLabel.textColor = yojpText
        instructionTitleLabel.font = font15
        instructionTitleLabel.sizeToFit()
        instructionView.addSubview(instructionTitleLabel)
        
        let line1ImageView : UIImageView = UIImageView(frame: CGRectMake(0, instructionTitleLabel.frame.size.height + 16, screenWidth, 1))
        line1ImageView.backgroundColor = yojpTableViewColor
        instructionView.addSubview(line1ImageView)
        
        let instructionContentLabel : UILabel = UILabel(frame: CGRectMake(32,line1ImageView.frame.origin.y+line1ImageView.size.height+8,screenWidth-64,100))
        instructionContentLabel.text = "１、请在指定的店铺，在有效期内消费使用；\n２、消费结账时，凭借有效优惠券信息，即可根据优惠券优惠信息，享受优惠价格；\n３、有效时间：2016-03-01至2016-12-12"
        instructionContentLabel.font = font13
        instructionContentLabel.textColor = yojpText
        instructionContentLabel.numberOfLines = 0
        instructionContentLabel.sizeToFit()
        instructionView.addSubview(instructionContentLabel)
        
        instructionView.frame = CGRectMake(0,buyCallBackButton.frame.size.height+buyCallBackButton.frame.origin.y+16,screenWidth,instructionContentLabel.frame.size.height+instructionContentLabel.frame.origin.y+8)
        //商户信息
        
        let merchantView : UIView = UIView()
        merchantView.backgroundColor = UIColor.whiteColor()
        merchantView.layer.borderWidth = 1
        merchantView.layer.borderColor = yojpTableViewColor.CGColor
        self.scrollView.addSubview(merchantView)
        
        let merchantTitleLabel : UILabel = UILabel(frame: CGRectMake(16,8,100,30))
        merchantTitleLabel.text = "商户信息"
        merchantTitleLabel.textColor = yojpText
        merchantTitleLabel.font = font15
        merchantTitleLabel.sizeToFit()
        merchantView.addSubview(merchantTitleLabel)
        
        let line2ImageView : UIImageView = UIImageView(frame: CGRectMake(0, merchantTitleLabel.frame.size.height + 16, screenWidth, 1))
        line2ImageView.backgroundColor = yojpTableViewColor
        merchantView.addSubview(line2ImageView)
        
        for i in 0..<5 {
            let chooseView : ChooseView = ChooseView(frame: CGRectMake((CGFloat(i%3)+1)*16+CGFloat(i%3)*(screenWidth-64)/3,line2ImageView.frame.origin.y + 9 + 40*CGFloat(i/3),(screenWidth-64)/3,30))
            chooseView.label.text = self.dataArray[i] as! String
            merchantView.addSubview(chooseView)
        }
        
        let line3ImageView : UIImageView = UIImageView(frame: CGRectMake(0, line2ImageView.frame.origin.y + 100, screenWidth, 1))
        line3ImageView.backgroundColor = yojpTableViewColor
        merchantView.addSubview(line3ImageView)
        
        let businessTimeLabel : UILabel = UILabel(frame: CGRectMake(16,line3ImageView.frame.origin.y+line3ImageView.frame.size.height+8,screenWidth-32,100))
        businessTimeLabel.text = "营业时间:10:00-22:00(周一至周五)\n               09:00-24:00(周六、周日)"
        businessTimeLabel.font = font13
        businessTimeLabel.textColor = yojpText
        businessTimeLabel.numberOfLines = 2
        businessTimeLabel.sizeToFit()
        merchantView.addSubview(businessTimeLabel)
        
        let line4ImageView : UIImageView = UIImageView(frame: CGRectMake(0, businessTimeLabel.frame.origin.y + businessTimeLabel.frame.size.height+8, screenWidth, 1))
        line4ImageView.backgroundColor = yojpTableViewColor
        merchantView.addSubview(line4ImageView)
        
        let locationImageView : UIImageView = UIImageView(frame: CGRectMake(16,line4ImageView.frame.origin.y + line4ImageView.frame.size.height+12, 25, 25))
        locationImageView.image = UIImage(named: "u77")
        merchantView.addSubview(locationImageView)
        
        let locationLabel : UILabel = UILabel(frame: CGRectMake(locationImageView.frame.origin.x+locationImageView.frame.size.width+4,locationImageView.frame.origin.y+4,screenWidth-100,30))
        locationLabel.text = "东京某某街某某路"
        locationLabel.textColor = yojpText
        locationLabel.font = font14
        locationLabel.sizeToFit()
        merchantView.addSubview(locationLabel)
        
        let locationCallBtn : CallBackButton = CallBackButton(frame: CGRectMake(screenWidth-100,locationImageView.frame.origin.y,80,30))
        locationCallBtn.setTitle("导航", forState: .Normal)
        locationCallBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        locationCallBtn.backgroundColor = yojpBlue
        locationCallBtn.layer.cornerRadius = 8
        merchantView.addSubview(locationCallBtn)
        
        merchantView.frame = CGRectMake(0, instructionView.frame.origin.y+instructionView.frame.size.height-1, screenWidth, locationCallBtn.frame.origin.y+locationCallBtn.frame.size.height+8)
        
        self.scrollView.contentSize = CGSizeMake(0, merchantView.frame.origin.y+merchantView.frame.size.height)
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
