import 'package:flutter/material.dart';
import 'package:sukoshi_gallery/pages/home/home.dart';
import 'package:sukoshi_gallery/pages/login/login.dart';
import 'package:sukoshi_gallery/pages/register/register.dart';
import 'package:sukoshi_gallery/pages/retrieve/retrieve.dart';
import 'package:sukoshi_gallery/pages/start/start.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "一点点图库",
      theme: ThemeData.light(),
      home: StartPage(),
      routes: {
        '/start'    : (BuildContext context) => StartPage(),
        '/home'     : (BuildContext context) => HomePage(),
        '/login'    : (BuildContext context) => LoginPage(),
        '/retrieve' : (BuildContext context) => RetrievePage(),
        '/register' : (BuildContext context) => RegisterPage(),
      },
    );
  }
}