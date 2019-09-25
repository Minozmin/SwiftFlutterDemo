// 与natvie的交互示例，在iOS项目中通过natvieApp打开的页面

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';

class NativeHandelPage extends StatefulWidget {
  NativeHandelPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NativeHandelPageState createState() => _NativeHandelPageState();
}

class _NativeHandelPageState extends State<NativeHandelPage> {
  String nativeBackString = 'Not return';
  static const platform =
  const MethodChannel('com.hehuimin.flutter/platform_method');
  BuildContext context1;

  @override
  Widget build(BuildContext context) {
    // flutter 注册原生监听方法
    context1 = context;
    platform.setMethodCallHandler(_handleCallback);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Native向Flutter发送消息'),
              onPressed: _invokeNativeGetResult,
            ),
            Text('$nativeBackString'),
            Container(
              margin: EdgeInsets.all(20),
              child: RaisedButton(
                child: Text('页面跳转'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 这些方法需要在原生项目中运行使用
  // Native向Flutter发送消息
  Future<void> _invokeNativeGetResult() async {
    String backString;
    try {
      var result = await platform
          .invokeMethod('NativeSendMessage', {'key': 'From Flutter Page'});
      backString = 'Native Send Message：$result';
    } on PlatformException catch (e) {
      backString = 'Failed to get natvie return: ${e.message}';
    }

    setState(() {
      nativeBackString = backString;
    });
  }

  // Flutter向Native发送消息
  Future<dynamic> _handleCallback(MethodCall methodCall) {
    // 这边打印的会在xCode中输出
    print('flutter：$methodCall.arguments');
    String backString = '';
    if (methodCall.method == 'ListenNativeBackItem') {
      backString = 'send success';
    } else {
      backString = 'send fail';
    }

    // 处理内跳转
    bool canPop = Navigator.of(context).canPop();
    if (canPop) {
      Navigator.of(context).pop();
      return Future.value("");
    }
    return Future.value(backString);
  }
}
