//
//  FlutterVC.swift
//  iosFlutter
//
//  Created by Hehuimin on 2019/9/25.
//  Copyright © 2019 Hehuimin. All rights reserved.
//

import UIKit

class FlutterVC: FlutterViewController {

    private var methodChannel: FlutterMethodChannel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "FlutterVC";
        
        methodChannel = FlutterMethodChannel.init(name: "com.hehuimin.flutter/platform_method", binaryMessenger: self as! FlutterBinaryMessenger)
        nativeSendFlutter()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(onBackItem))
    }
    
    @objc func onBackItem() {
        self.flutterSendNative()
    }
}

/*
1.Native向Flutter发送消息，Flutter调用Native方法
  ios调用setMethodCallHandler，flutter调用invokeMethod
2.Flutter向Native发送消息，Native调用Flutter方法
  flutter调用setMethodCallHandler，ios调用invokeMethod
*/
private extension FlutterVC {
    // Native向Flutter发送消息，Flutter调用Native方法
    func nativeSendFlutter() {
        methodChannel.setMethodCallHandler { (methodCall, result) in
            if (methodCall.method == "NativeSendMessage") {
//                print(methodCall.arguments ?? "Not Result")
                if let arguments = methodCall.arguments as? Dictionary<String, Any> {
                    let key: String = arguments["key"] as? String ?? ""
                    print("nativeSendFlutter: \(key)")
                }
                
                // 返回值给Flutter
                let name:String = UIDevice.current.name
                result(name)
            }
        }
    }
    
    // Flutter向Native发送消息，Native调用Flutter方法
    func flutterSendNative() {
        methodChannel.invokeMethod("ListenNativeBackItem", arguments: ["key":"hehuimin"]) { (result) in
//            print(result ?? "Not Result")
            let value: String = result as? String ?? ""
            print("flutterSendNative: \(value)")
            
            if value.isEmpty == false {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
