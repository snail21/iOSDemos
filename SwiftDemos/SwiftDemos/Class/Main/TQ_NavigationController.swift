//
//  TQ_NavigationController.swift
//  SwiftDemos
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class TQ_NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //设置导航栏背景颜色
        UINavigationBar.appearance() .setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance() .shadowImage = UIImage()
        UINavigationBar.appearance() .titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(hexString: "#6D6971") ?? UIColor.white,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize:18)]
        //        setShadowLayer(view: self.navigationBar)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    fileprivate func setShadowLayer(view : UIView) {
        //  给导航栏视图添加阴影层
        let layer = view.layer
        layer.shadowOffset = CGSize.init(width: 0, height: 2)
        layer.shadowRadius = 3.0 //默认为3.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //重写父类方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: animated)
        
        if (viewController.navigationController?.responds(to: #selector(getter: interactivePopGestureRecognizer)))! {
            
            viewController.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            viewController.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
        }
        //viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count > 1
        //不是第一层控制器的时候
        if viewController != self.children[0]{
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: self.leftBarBtn)
            
            viewController.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            //如果push进来的不是第一个控制器
            //当push的时候 隐藏tabbar
//            UIView.animate(withDuration: 0.2, animations: {
//
//                viewController.tabBarController?.tabBar.ND_Y = kSCREEN_HEIGHT+__Y(y: 25)
//            }) { (finished) in
//
//            }
        }
    }
    
    
    fileprivate lazy var leftBarBtn : UIButton = {
        let leftView = UIButton.init(type: UIButton.ButtonType.custom)
        leftView.frame = __setCGRECT(x: 0, y: 0, width: __X(x: 55), height: __X(x: 26))
        leftView.addTarget(self, action: #selector(popself), for: UIControl.Event.touchUpInside)
        
        let img1 = UIImageView.init(image: __setImageName(name: "fanhui_black"))
        leftView.addSubview(img1)
        img1.contentMode = UIView.ContentMode.center
        img1.frame = __setCGRECT(x: 0, y: 5, width: __X(x: 20), height: __X(x: 22))
        
        return leftView
    }()
    
    @objc fileprivate func popself() {
        self.popViewController(animated: true)
    }
}
