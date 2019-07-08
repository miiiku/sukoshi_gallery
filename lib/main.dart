import 'package:flutter/material.dart';
import 'package:sukoshi_gallery/pages/login/login.dart';
import 'package:sukoshi_gallery/pages/register/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "一点点图库",
      theme: ThemeData.light(),
      home: loginPage(),
      routes: {
        '/register': (BuildContext context) => registerPage(),
      },
    );
  }
}