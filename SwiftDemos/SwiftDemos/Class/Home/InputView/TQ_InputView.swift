//
//  TQ_InputView.swift
//  SwiftDemos
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

typealias TQ_InputViewBlock = (_ text: String) -> ()

class TQ_InputView: UIView, UITextViewDelegate {
    
    //方格、选中颜色、未选中颜色
    var maxLenght: CGFloat!
    var selectColor: UIColor!
    var defaulterColor: UIColor!
    
    //背景视图、textView
    var contairView: UIView!
    var textBgView: UITextView!
    
    //视图、竖线、文本
    var viewAry: NSMutableArray!
    var labelAry: NSMutableArray!
    var pointLineAry: NSMutableArray!
    
    var block: TQ_InputViewBlock?
    

    override init(frame: CGRect) {
    
        super.init(frame: frame)
        
        loadViewFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 加载视图
    func loadViewFrame() {
        
        //默认值
        self.maxLenght = 4
        self.selectColor = UIColor(red: 255/255.0, green: 70/255.0, blue: 62/255.0, alpha: 1)
        self.defaulterColor = UIColor(red: 228/255.0, green: 228/255.0, blue: 228/255.0, alpha: 1)
        
        self.backgroundColor = UIColor.clear
        
        
        self.pointLineAry = NSMutableArray()
        self.viewAry = NSMutableArray()
        self.labelAry = NSMutableArray()
    }
    
    /// 创建视图
    func createInputViewWithMaxLenght() {
        
        //创建输入验证码的视图
        if maxLenght <= 0 {
            
            return
        }
        
        if (contairView != nil) {
            
            contairView.removeFromSuperview()
        }
        
        //背景视图
        contairView = UIView(frame: self.bounds)
        contairView.backgroundColor = UIColor.clear
        self.addSubview(contairView)
        
        //textView
        textBgView = UITextView(frame: contairView.bounds)
        textBgView.delegate = self
        textBgView.textColor = UIColor.clear
        textBgView.tintColor = UIColor.clear
        textBgView.backgroundColor = UIColor.clear
        textBgView.keyboardType = UIKeyboardType.numberPad
        contairView.addSubview(textBgView)
        
        startEdit()
        
        //计算方格间的间隔/ 方块的宽/高 = s视图的高
        let padding = (self.frame.width - maxLenght * self.frame.height) / (maxLenght - 1)
        
        //创建显示的方块视图
        
        for index in 0..<Int(maxLenght) {
            
            let subView = UIView(frame: CGRect(x: padding * CGFloat(index) + self.frame.height * CGFloat(index), y: 0, width: self.frame.height, height: self.frame.height))
            subView.backgroundColor = UIColor.white
            subView.layer.cornerRadius = 4
            subView.layer.borderWidth = 0.5
            subView.isUserInteractionEnabled = false
            contairView.addSubview(subView)
            
            let subLab = UILabel(frame: subView.bounds)
            subLab.textAlignment = .center
            subLab.font = UIFont.systemFont(ofSize: 20)
            subView.addSubview(subLab)
      
            //绘制中间闪烁条
            let path = UIBezierPath(rect: CGRect(x: (subView.width - 2.0) / 2.0, y: 5, width: 2, height: self.frame.height - 10))
            let line = CAShapeLayer()
            line.path = path.cgPath
            line.fillColor = selectColor.cgColor
            subView.layer.addSublayer(line)
            
            //初始化第一个为选中z状态
            if index == 0 {
                
                line.add(opacityAnimation(), forKey: "kOpacityAnimation")
                line.isHidden = false
                subView.layer.borderColor = selectColor.cgColor
            }
            else {
                
                line.isHidden = true
                line.borderColor = defaulterColor.cgColor
                
            }
            
            self.viewAry.add(subView)
            self.labelAry.add(subLab)
            self.pointLineAry.add(line)
        }
    }
    
    //MARK: UITextView Delegate
   
    //开始响应编辑
    func startEdit() {
        
        self.textBgView.becomeFirstResponder()
    }
    //结束响应编辑
    func endEidt() {
        
      self.textBgView.resignFirstResponder()
    }
    
    //输入过后
    func textViewDidChange(_ textView: UITextView) {
        
        var textStr: String = textView.text
        
        //去空格
        textStr = textStr.replacingOccurrences(of: " ", with: "")
        
        if textStr.count >= Int(maxLenght) {
            
            textStr = String(textStr.prefix(Int(maxLenght)))
            self.endEidt()
        }
        //获取当前输入了什么值
        textView.text = textStr
        
        //把值传送回上一个界面
        if (self.block != nil) {
            
            self.block!(textStr)
        }
        
        //显示或隐藏光标
        self.viewAry.enumerateObjects { (objc, index, stop) in
            
            let lab: UILabel = self.labelAry?[index] as! UILabel
            
            if index < textStr.count {
                
                changeViewLayerIndex(index: index, hidden: true)
                let str: NSString = textStr as NSString
                lab.text = str.substring(with: NSMakeRange(index, 1))
            }
            else {
                
                changeViewLayerIndex(index: index, hidden: index == textStr.count ? false : true)
                
                if textStr.count == 0 {
                    
                    changeViewLayerIndex(index: 0, hidden: false)
                }
                lab.text = ""
            }
        }
    }
    
    func changeViewLayerIndex(index: Int, hidden: Bool) {
        
        //对应背景图
        let view:UIView = self.viewAry[index] as! UIView
        view.layer.borderColor = hidden ? defaulterColor.cgColor : selectColor.cgColor
        
        //每个视图的光标
        let line: CAShapeLayer = self.pointLineAry[index] as! CAShapeLayer
        
        if hidden {
            line.removeAnimation(forKey: "kOpacityAnimation")
        }
        else {
            line.add(opacityAnimation(), forKey: "kOpacityAnimation")
        }
        line.isHidden = hidden
    }
    
    //MARK: 光标h闪烁动画
    func opacityAnimation() -> CABasicAnimation {
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = 0.9
        opacityAnimation.repeatCount = HUGE
        opacityAnimation.isRemovedOnCompletion = true
        opacityAnimation.fillMode = .forwards
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        return opacityAnimation
    }
    
}
