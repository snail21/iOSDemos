//
//  ViewController.swift
//  SwiftDemos
//
//  Created by apple on 2018/11/1.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: 属性
    let cellIdentifer: String = "cell"
    var mTableview: UITableView!
    var dataAry: NSMutableArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        self.loadViewFrame()
        self.loadViewData()
    }
    
    //MARK: 加载视图
    func loadViewFrame() {
        
        //创建表格
        mTableview = UITableView(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT), style: .plain)
        mTableview.delegate = self
        mTableview.dataSource = self
        mTableview.showsVerticalScrollIndicator = false
        mTableview.showsHorizontalScrollIndicator = false
        mTableview.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifer)
        mTableview.tableFooterView = UIView()
        mTableview.rowHeight = 50 * GET_HEI
        self.view.addSubview(mTableview)
    }
    
    //MARK: 加载数据
    func loadViewData() {
        
        self.dataAry = NSMutableArray(array: ["搜索框", "图片选择器", "load倒计时"])
        self.mTableview.reloadData()
        
    }
    
    //MARK: 表格代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.dataAry != nil {
            
            return self.dataAry.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
        cell.textLabel?.text = self.dataAry[indexPath.row] as? String
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            
            break
            
        case 1:
            
            break
            
        case 2:
            
            let vc = TQ_CountDownLoadVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
            
        default:
            break
        }
    }
}

