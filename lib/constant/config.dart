

import 'package:flutter/material.dart';

// 注册/登陆/找回密码按钮事件
typedef onLoginBtnTap = void Function();

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

class F {
  // 字体间距
  static double letterSpacing = 8.0;
  // 基本字体大小
  static double fontSizeBasic = 16.0;
  // 较小号字体
  static double fontSizeMin = 14.0;
  // 教大号字体
  static double fontSizeMax = 18.0;
}

class P {
  static double margin = 20.0;
}


class C {
  // 灰色
  static const Color gray = Color.fromRGBO(151, 151, 151, 1.0);
}