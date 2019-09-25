//
//  ViewController.swift
//  iosFlutter
//
//  Created by Hehuimin on 2019/7/25.
//  Copyright © 2019 Hehuimin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClick(_ sender: Any) {
        let flutterVC: FlutterVC = FlutterVC.init()
        // 默认打开方式
        // flutter 通过这种方式：void main() => runApp(MyApp());
//        flutterVC.setInitialRoute("routel")
        
        //指定路由跳转
        flutterVC.setInitialRoute("natvieApp")
        self.navigationController?.pushViewController(flutterVC, animated: true)
    }
}

