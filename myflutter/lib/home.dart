import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'request.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Scaffold(
    //     body: SafeArea(
    //       child: Text('data'),
    //     ),
    //   ),
    // );

    return HomePageFul();
  }
}

class HomePageFul extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageFul> {
  String errmsg = 'errmsg:';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //水平左对齐
          children: <Widget>[
            RaisedButton(
              child: Text('返回'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: RaisedButton(
                child: Text('dio网络请求'),
                onPressed: _httpReqeust,
              ),
            ),
            Text('$errmsg'),
            Container(
              margin: EdgeInsets.all(20),
              child: RaisedButton(
                child: Text('Flutter原生网络请求'),
                onPressed: _flutterReuest,
              )
            )
          ],
        )
      ),
    );
  }

  //dio网络请求（推荐）
  _httpReqeust() {
    var request = DioHttpRequest.getReqeust('/common/index_v2');
    request.then((response) {
      if (response.errno == 0) {
        //成功
        print('成功');
      } else {
        //失败
        print('失败');
      }
      setState(() {
        errmsg += response.errmsg;
      });
    });
  }

  //flutter原生网络请求，简单处理get请求
  _flutterReuest() async {
    var httpClient = HttpClient();

    try {
      var uri = Uri.http('m.devapi.haoshiqi.net', '/common/index_v2');
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        print(data);
      }
    } catch (e) {
      print(e);
    }
  }
}
