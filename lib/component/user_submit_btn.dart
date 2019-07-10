import 'package:flutter/material.dart';
import 'package:sukoshi_gallery/constant/config.dart';

// 注册/登陆/找回密码按钮事件
typedef onLoginBtnTap = void Function();

// 大的，主要的跳按钮统一样式
Widget buildSubmitBtn(String title, onLoginBtnTap func) {
  return Container(
    width: double.infinity,
    height: 50.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      gradient: LinearGradient(
        colors: <Color>[
          Color.fromRGBO(160, 92, 147, 1.0),
          Color.fromRGBO(115, 82, 135, 1.0),
        ],
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: func,
        borderRadius: BorderRadius.circular(25.0),
        child: Center(
          child: Text(title, style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: F.fontSizeBasic,
            letterSpacing: F.letterSpacing,
          ),),
        ),
      ),
    )
  );
}