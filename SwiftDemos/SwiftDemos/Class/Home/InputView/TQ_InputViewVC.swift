//
//  TQ_InputViewVC.swift
//  SwiftDemos
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class TQ_InputViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        let inputView = TQ_InputView(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH - 50 * GET_HEI, height: 50))
        inputView.maxLenght = 6
        inputView.createInputViewWithMaxLenght()
        inputView.block = {(text) in
            
            print(text)
            } as TQ_InputViewBlock
        inputView.center = view.center
        
        self.view.addSubview(inputView)
        
    }

}
