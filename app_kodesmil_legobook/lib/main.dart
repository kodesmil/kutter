import 'package:flutter/material.dart';
import 'package:lib_lego/themes.dart';
import 'package:lib_lego/spaces.dart';
import 'package:lib_lego/texts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KodeSmil Lego',
      theme: MfThemeData.light(),
      home: Scaffold(
        body: LayoutBuilder(
          builder: (ctx, cns) =>
              ListView(
                children: <Widget>[
                  Container(
                    color: Colors.orange,
                    height: 20,
                  ),
                ],
              ),
        ),
      ),
    );
  }
}