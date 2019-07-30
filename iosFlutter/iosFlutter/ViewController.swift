//
//  ViewController.swift
//  iosFlutter
//
//  Created by Hehuimin on 2019/7/25.
//  Copyright © 2019 Hehuimin. All rights reserved.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /*
     1.Flutter调原生方法并返回结果给Flutter
       flutter调用invokeMethod，ios调用setMethodCallHandler
     2.原生调用Flutter方法并返回结果给原生
       flutter调用setMethodCallHandler，ios调用invokeMethod
     */
    @IBAction func onClick(_ sender: Any) {
        let flutterVC: FlutterViewController = FlutterViewController.init()
        //默认打开方式
//        flutterVC.setInitialRoute("routel")
        //指定路由跳转
        flutterVC.setInitialRoute("myApp")
        self.navigationController?.pushViewController(flutterVC, animated: true)
        
        let methodChannel:FlutterMethodChannel = FlutterMethodChannel.init(name: "com.hehuimin.flutter/platform_method", binaryMessenger: flutterVC as! FlutterBinaryMessenger)
        methodChannel.setMethodCallHandler { [weak self] (methodCall, result) in
            guard let `self` = self else {return}
            if (methodCall.method == "getNativeResult") {
                //Flutter调原生方法并返回结果给Flutter
                
                //接收Flutter参数
                print(methodCall.arguments ?? "Not Result")
                if let arguments = methodCall.arguments as? Dictionary<String, Any> {
                    self.label1.text = arguments["key"] as? String
                }
                
                //返回值给Flutter
                let name:String = UIDevice.current.name
                result(name)
                
                //原生调用Flutter方法并返回结果给原生
                methodChannel.invokeMethod("sendMessage", arguments: ["key":"hehuimin"]) { (result) in
                    print(result ?? "Not Result")
                    let value: String = result as? String ?? ""
                    self.label2.text =  "flutter传过来的参数：" + value
                }
            }
        }
    }
}

