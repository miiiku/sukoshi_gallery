import 'package:flutter/material.dart';
import 'package:sukoshi_gallery/pages/home/home.dart';
import 'package:sukoshi_gallery/pages/login/login.dart';
import 'package:sukoshi_gallery/pages/register/register.dart';
import 'package:sukoshi_gallery/pages/select_tag/select_tag.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "一点点图库",
      theme: ThemeData.light(),
      home: HomePage(),
      routes: {
        '/register': (BuildContext context) => registerPage(),
      },
    );
  }
}