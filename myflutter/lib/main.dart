import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'index.dart';
import 'native.dart';

// 通过routel打开
// void main() => runApp(MyApp());
// 指定路由打开，需要引入import 'dart:ui';
void main() => runApp(MyApp(route: window.defaultRouteName));

// 跳转到指定页面
// 通过指定路由打开Flutter的页面都需要在MaterialApp()才可以
Widget _widgetForRoute(String route) {
  switch (route) {
    case 'natvieApp': // 通过xCode运行项目，涉及与native交互
      return NativeHandelPage();
    case '/': // 用vsCode运行，不涉及与native交互
      return IndexPage();
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
      debugShowCheckedModeBanner: false, // 不显示Debug标签
    );
  }
}
