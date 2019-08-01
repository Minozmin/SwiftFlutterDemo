import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'home.dart';

//通过routel打开
// void main() => runApp(MyApp());
//指定路由打开，需要引入import 'dart:ui';
void main() => runApp(MyApp(route: window.defaultRouteName));

//跳转到指定页面
//通过指定路由打开Flutter的页面都需要在MaterialApp()才可以
Widget _widgetForRoute(String route) {
  switch (route) {
    case 'myApp':
    case '/':
      return MyHomePage();
    case 'homePage':
      return HomePage();
    default:
      return Center(child: Text('Unknown route:$route'));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final String route;
  MyApp({Key key, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _widgetForRoute(route),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String nativeBackString = 'Not return';
  static const platform =
      const MethodChannel('com.hehuimin.flutter/platform_method');

  @override
  Widget build(BuildContext context) {
    //flutter 注册原生监听方法
    platform.setMethodCallHandler(_handleCallback);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Flutter调原生方法并返回结果给Flutter'),
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
            )
          ],
        ),
      ),
    );
  }

  //Flutter调原生方法并返回结果给Flutter
  Future<void> _invokeNativeGetResult() async {
    String backString;
    try {
      var result = await platform
          .invokeMethod('getNativeResult', {'key': 'From Flutter Page'});
      backString = '原生传过来的参数：$result';
    } on PlatformException catch (e) {
      backString = 'Failed to get natvie return: ${e.message}';
    }

    setState(() {
      nativeBackString = backString;
    });
  }

  //原生调用Flutter方法并返回结果给原生
  Future<dynamic> _handleCallback(MethodCall methodCall) {
    //这边打印的会在xCode中输出
    print('flutter：$methodCall.arguments');
    String backString = '';
    if (methodCall.method == 'sendMessage') {
      backString = 'send success';
    } else {
      backString = 'send fail';
    }
    return Future.value(backString);
  }
}
