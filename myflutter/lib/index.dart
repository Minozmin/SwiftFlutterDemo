import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflutter/home.dart';

import 'animated.dart';
import 'tabbar.dart';
import 'snackbar.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: <Widget>[
                RaisedButton(
                  child: Text("网络请求"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return HomePage(parameters: Parameters(true),);
                    }));
                  },
                ),
                RaisedButton(
                  child: Text('AnimatedContainer Page'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return AnimatedContainerPage();
                    }));
                  },
                ),
                RaisedButton(
                  child: Text('SnackBar Page'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return SanckBarPage();
                    }));
                  },
                ),
                RaisedButton(
                  child: Text('TabBarView Page'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return TabBarPage();
                    }));
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'TextField'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'TextFormField'
                  ),
                )
              ],
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // 打开新页时需要先关闭，再跳转
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return AnimatedContainerPage();
                }));
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
