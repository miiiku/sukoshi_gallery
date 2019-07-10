import 'package:flutter/material.dart';

// 统一导航栏
AppBar buildAppBarContainer({String title = '', Color color = Colors.transparent}) {
  return AppBar(
    brightness: Brightness.light,
    backgroundColor: color,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      )
    ),
    title: Text(title),
  );
}