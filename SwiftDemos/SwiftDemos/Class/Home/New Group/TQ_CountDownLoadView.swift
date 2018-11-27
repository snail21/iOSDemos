//
//  TQ_CountDownLoadView.swift
//  SwiftDemos
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class TQ_CountDownLoadView: UIView {
    
    var ruandImg: UIImageView!
    var numLab : UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        loadViewFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 创建视图
    func loadViewFrame() {
        
        //背景
        let bgView:UIView = UIView(frame: self.bounds)
        bgView.backgroundColor = UIColor.white
        self.addSubview(bgView)
        
        //转圈的背景图
        let imgView = UIImageView(image: UIImage(named: ""))
        imgView.backgroundColor = UIColor.red
        //        imgView.layer.masksToBounds = true
        //        imgView.layer.cornerRadius = bgView.width / 2
        imgView.frame = bgView.bounds
        self.ruandImg = imgView
        bgView.addSubview(imgView)
        
        
        //倒计时数字
        let numLab = UILabel()
        numLab.text = "3"
        numLab.textColor = UIColor(hexString: "222222")
        numLab.font = UIFont.systemFont(ofSize: 25)
        self.numLab = numLab
        bgView.addSubview(numLab)
        
        numLab.snp.makeConstraints { (make) in
            
            make.center.equalTo(bgView)
        }
        
        
        //单位（S）
        let untilLab = UILabel()
        untilLab.text = "s"
        untilLab.textColor = UIColor(hexString: "6B696B")
        untilLab.font = UIFont.systemFont(ofSize: 15)
        bgView.addSubview(untilLab)
        
        untilLab.snp.makeConstraints { (make) in
            
            make.bottom.equalTo(numLab)
            make.left.equalTo(numLab.snp.right).offset(1)
        }
    }
    
    
    /// 旋转
    func startAnimation() {
        
        let rotationAnimation: CABasicAnimation!
        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(floatLiteral: M_PI * 2)
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = HUGE
        self.ruandImg.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
    }
    
    
    
    //MARK: 倒计时设置
    func countDown(_ timeOut: Int, lab: UILabel ){
        //倒计时时间
        var timeout = timeOut
        let queue:DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        let _timer:DispatchSource = DispatchSource.makeTimerSource(flags: [], queue: queue) as! DispatchSource
        _timer.schedule(wallDeadline: DispatchWallTime.now(), repeating: .seconds(1))
        //每秒执行
        _timer.setEventHandler(handler: { () -> Void in
            if(timeout<=0){ //倒计时结束，关闭
                _timer.cancel();
                DispatchQueue.main.sync(execute: { () -> Void in
                    lab.text = "0"
                    self.ruandImg.layer.removeAllAnimations()//停止动画
                })
            }else{//正在倒计时
                let seconds = timeout
                let strTime = NSString.localizedStringWithFormat("%d", seconds)
                DispatchQueue.main.sync(execute: { () -> Void in
                    lab.text = strTime as String
                })
                timeout -= 1;
            }
        })
        _timer.resume()
    }
    
    
    /// 开始
    ///
    /// - Parameter time: 倒计时时间
    func show(time: Int) {
        
        self.numLab.text = time.description
        
        self.startAnimation()
        self.countDown(time, lab: self.numLab)
        
    }
    
}
