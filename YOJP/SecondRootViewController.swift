//
//  SecondRootViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/13.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class SecondRootViewController: UIViewController, UIScrollViewDelegate {
    
    /**  标题栏  */
    var titleScrollView = UIScrollView()
    /**  内容  */
    var contentScrollView = UIScrollView()
    /**  被选中的 button  */
    var selTitleButton = UIButton()
    /**  所有 button  */
    var buttons:Array<UIButton> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        // 设置头部标题栏
        setupTitleScrollView()
        // 设置内容
        setupContentScrollView()
        // 添加子控制器
        addChildViewController()
        // 设置标题
        setupTitle()
        // 阻止 tableView 上面的空白
        automaticallyAdjustsScrollViewInsets = false
        // 设置内容视图的 contentSize
        contentScrollView.contentSize = CGSizeMake(CGFloat(childViewControllers.count) * screenWidth, 0)
        // 设置整屏滑动
        contentScrollView.pagingEnabled = true
        // 隐藏滚动条
        contentScrollView.showsHorizontalScrollIndicator = false
        // 设置代理(必须先遵守协议!)
        contentScrollView.delegate = self
        
    }
    
    
    
    /**  设置头部标题栏  */
    func setupTitleScrollView(){
        // 判断是否存在导航视图控制器来判断 Y 值
        // let y = (navigationController != nil) ? navBarH : 0
        
        let y : CGFloat = 0
        // 设置标题栏的 frame
        let rect:CGRect = CGRectMake(0, y, screenWidth, titleH)
        let scrollView = UIScrollView()
        scrollView.frame = rect;
        scrollView.backgroundColor = UIColor.whiteColor()
        view.addSubview(scrollView)
        titleScrollView = scrollView;
    }
    
    
    /**  设置内容  */
    func setupContentScrollView(){
        // 设置内容的 frame
        let y:CGFloat = CGRectGetMaxY(titleScrollView.frame)
        let rect:CGRect = CGRectMake(0, y, screenWidth, screenHeight - navBarH)
        let scrollView = UIScrollView()
        scrollView.frame = rect
        view.addSubview(scrollView)
        contentScrollView.backgroundColor = UIColor.blackColor()
        contentScrollView = scrollView
    }
    
    /**  添加子控制器  */
    func addChildViewController(){
        let vc1 = FeatureSecondViewController()
        vc1.title = "精选"
        
        let vc2 = FeatureSecondViewController()
        vc2.title = "美妆"
        
        let vc3 = FeatureSecondViewController()
        vc3.title = "美食"
        
        let vc4 = FeatureSecondViewController()
        vc4.title = "爱美"
        
        let vc5 = FeatureSecondViewController()
        vc5.title = "格调"
        
        let vc6 = FeatureSecondViewController()
        vc6.title = "优惠"
        
        addChildViewController(vc1)
        addChildViewController(vc2)
        addChildViewController(vc3)
        addChildViewController(vc4)
        addChildViewController(vc5)
        addChildViewController(vc6)
    }
    
    
    /**  设置标题  */
    func setupTitle(){
        /**  子视图控制器的数量  */
        let count:Int = childViewControllers.count
        /**  标题偏移量  */
        var x:CGFloat = 0
        /**  标题宽度  */
        let w:CGFloat = 80
        /**  标题高度  */
        let h:CGFloat = titleH
        // 循环
        for var i = 0; i < count; i++ {
            // 找到子视图控制器
            let vc = childViewControllers[i]
            // 设置标题偏移量
            x = w * CGFloat(i)
            // 设置 frame
            let rect = CGRectMake(x, 0, w, h)
            // 创建 button
            let button = UIButton(type: .System) as UIButton
            button.frame = rect
            // 设置 title
            button.setTitle(vc.title, forState: .Normal)
            // 设置 btn 的 tag 值
            button.tag = i
            // 颜色
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            // 字体大小
            button.titleLabel?.font = UIFont.systemFontOfSize(15)
            // 添加点击事件
            button.addTarget(self, action:"btAction:" , forControlEvents:UIControlEvents.TouchUpInside)
            // 数组添加 button
            buttons.append(button)
            // 添加子视图
            titleScrollView.addSubview(button)
            // 如果没有点击默认第一个
            if i == 0 {
                btAction(button)
            }
        }
        // 设置 scrollView 的 contentSize
        titleScrollView.contentSize = CGSizeMake(CGFloat(count) * w, 0)
        // 隐藏滚动条
        titleScrollView.showsHorizontalScrollIndicator = false;
    }
    
    
    
    /**  btn 的点击事件  */
    func btAction(btn:UIButton){
        // 执行选中按钮的状态
        selTitleBtn(btn)
        // 当前是第几个 btn
        let i:Int = btn.tag
        // 要显示控制器的偏移量
        let x:CGFloat = CGFloat(i) * screenWidth
        // 设置 i 个 btn 所在的视图控制器
        setUpOneChildViewController(i)
        // 把偏移量赋值给内容视图
        contentScrollView.contentOffset = CGPointMake(x, 0)
    }
    
    
    
    
    /**  选中按钮  */
    func selTitleBtn(btn:UIButton){
        // 让上一个被选中的 btn 恢复黑色
        selTitleButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        // 让上一个被选中的 btn 恢复 transform
        selTitleButton.transform = CGAffineTransformIdentity
        // 设置当前选中 btn 的颜色
        btn.setTitleColor(UIColor.redColor(), forState: .Normal)
        // 设置 transform
        btn.transform = CGAffineTransformMakeScale(maxTitleScale, maxTitleScale)
        // 给属性赋值
        selTitleButton = btn
        // 让被选中的 btn 居中
        setupTitleCenter(btn)
    }
    
    
    /**  让 button 居中显示  */
    func setupTitleCenter(btn:UIButton){
        // 计算偏移量
        var offset = btn.center.x - screenWidth * 0.5
        // 让偏移量不为负数
        if offset < 0 {
            offset = 0
        }
        // 计算偏移量的最大值
        let maxOffset = titleScrollView.contentSize.width - screenWidth
        // 不能超出偏移量最大值
        if offset > maxOffset {
            offset = maxOffset
        }
        // 把偏移量给标题栏赋值
        titleScrollView.setContentOffset(CGPointMake(offset, 0), animated: true)
    }
    
    func setUpOneChildViewController(i:Int){
        // 显示当前 btn 个数对应的偏移量
        let x:CGFloat = CGFloat(i) * screenWidth
        // 得到 btn 对应的控制器
        let vc = childViewControllers[i]
        // 如果视图存在结束函数
        if vc.view.superview != nil{
            return
        }
        // 设置当前视图控制器视图的 frame
        vc.view.frame = CGRectMake(x, 0, screenWidth, screenHeight - self.contentScrollView.frame.origin.y)
        // 添加当前视图控制器的视图
        contentScrollView.addSubview(vc.view)
    }
    
    
    
    
    
    // 内存警告!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // 代理里的方法
    // 结束就会触发
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView == self.contentScrollView {
            let i:Int = Int(self.contentScrollView.contentOffset.x / screenWidth)
            selTitleBtn(buttons[i])
            setUpOneChildViewController(i)
            
        }
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
