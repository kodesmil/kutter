import 'package:app_motim_homepage/routes.dart';
import 'package:flutter/material.dart';
import 'package:lib_lego/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motim FIt',
      routes: Routes.routes,
      theme: MfThemeData.light(),
      // darkTheme: MfThemeData.dark(),
      darkTheme: MfThemeData.light(),
      initialRoute: 'login',
    );
  }
}