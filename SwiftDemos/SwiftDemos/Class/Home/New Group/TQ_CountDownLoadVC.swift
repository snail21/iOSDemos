//
//  TQ_CountDownLoadVC.swift
//  SwiftDemos
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class TQ_CountDownLoadVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        let ruandView = TQ_CountDownLoadView(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        self.view.addSubview(ruandView)
        
        ruandView.show(time: 30)
    }

}
