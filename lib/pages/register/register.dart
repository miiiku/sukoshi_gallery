import 'package:flutter/material.dart';
import 'package:sukoshi_gallery/constant/config.dart';
import 'package:sukoshi_gallery/component/appbar.dart';
import 'package:sukoshi_gallery/component/user_submit_btn.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passWordVisible;

  @override
  void initState() {
    _passWordVisible  = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarContainer(),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: P.margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: P.margin),
                child: Text(
                  '加入我们',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: P.margin),
                child: Text(
                  '快来加入我们吧！！！！！！ \n哦梨改~',
                  style: TextStyle(
                    fontSize: F.fontSizeMin,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: '手机号/邮箱',
                        labelStyle: TextStyle(
                          fontSize: F.fontSizeMin
                        ),
                        hintText: '请输入你的常用手机号或邮箱号',
                        hintStyle: TextStyle(
                          fontSize: F.fontSizeMin
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: P.margin,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: '登陆密码',
                        labelStyle: TextStyle(
                          fontSize: F.fontSizeMin
                        ),
                        hintText: '请设置你的登陆密码',
                        hintStyle: TextStyle(
                          fontSize: F.fontSizeMin
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              this._passWordVisible = !this._passWordVisible;
                            });
                          },
                          icon: Icon(_passWordVisible ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                      obscureText: _passWordVisible,
                    ),
                    SizedBox(
                      height: P.margin,
                    ),
                    buildSubmitBtn('注册', () {
                      print('object.....');
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}