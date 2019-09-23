import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SanckBarPage extends StatefulWidget {
  _SnackBarPageState createState() => _SnackBarPageState();
}

class _SnackBarPageState extends State<SanckBarPage> {
  // 需要设置Scaffold的key才能弹出SnackBar
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置key处理SnackBar，这里一定要设置，否则弹窗不显示
      key: _scaffoldkey,
      body: Center(
        child: RaisedButton(
          child: Text('Show SnackBar'),
          onPressed: () {
            final snackBar = SnackBar(
              content: Text('Yay, A SnackBar!'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  print('Click Undo');
                },
              ),
            );
            _scaffoldkey.currentState.showSnackBar(snackBar);
            // 下面这种方法是不可用的(当BuildContext在Scaffold之前时，调用Scaffold.of(context)会报错)
            // Scaffold.of(context).showSnackBar(snackBar);
          },
        ),
      ),
    );
  }
}
