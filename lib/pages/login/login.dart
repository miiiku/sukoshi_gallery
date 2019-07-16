import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sukoshi_gallery/component/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sukoshi_gallery/component/router_style.dart';
import 'package:sukoshi_gallery/component/user_submit_btn.dart';
import 'package:sukoshi_gallery/constant/config.dart';
import 'package:sukoshi_gallery/constant/classs.dart';

import 'package:sukoshi_gallery/pages/register/register.dart';
import 'package:sukoshi_gallery/pages/retrieve/retrieve.dart';
import 'package:sukoshi_gallery/pages/home/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({ Key key, this.title }) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _accountnumber;
  TextEditingController _password;
  bool _passWordVisible;

  void _onSubmit() async {
    if (_accountnumber.value.text == "sukoshi" && _password.value.text == "111") {
      print('succss');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      User user = User(
        18380440709,
        'Sukoshi',
        'https://qiniu.miiiku.xyz/src/images/64f10fbebc74e345d0333528f6f9bc4a.jpeg',
        'https://qiniu.miiiku.xyz/src/images/banner-footer.jpg',
        '“望咩啊，死靓仔！”',
        'token'
      );
      prefs.setString('UserInfo', jsonEncode(user));
      Navigator.push(context, FadeRouter(HomePage()));
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    super.initState();
    _accountnumber    = TextEditingController();
    _password         = TextEditingController();
    _passWordVisible  = true;
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
                  '欢迎回来',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: P.margin),
                child: Text(
                  '欢迎回来，哦概里！',
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
                    Padding(
                      padding: EdgeInsets.only(bottom: P.margin),
                      child: TextFormField(
                        controller: _accountnumber,
                        decoration: InputDecoration(
                          labelText: '手机号',
                          labelStyle: TextStyle(
                            fontSize: F.fontSizeMin
                          ),
                          hintText: '请输入你的手机号',
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: P.margin),
                      child: TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                          labelText: '登陆密码',
                          labelStyle: TextStyle(
                            fontSize: F.fontSizeMin
                          ),
                          hintText: '请输入你的登陆密码',
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
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20.0),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, FadeRouter(RetrievePage()));
                        },
                        child: Text(
                          '忘记密码？',
                          style: TextStyle(
                            fontSize: F.fontSizeMin,
                            color: Color.fromRGBO(115, 82, 135, 1.0),
                          )
                        ),
                      ),
                    ),
                    buildSubmitBtn('登陆', () {
                      _onSubmit();
                    }),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '还没有账号？',
                                style: TextStyle(
                                  fontSize: F.fontSizeMin,
                                  color: Colors.grey,
                                ),
                              ),
                              TextSpan(
                                text: '立即注册',
                                style: TextStyle(
                                  fontSize: F.fontSizeMin,
                                  color: Color.fromRGBO(115, 82, 135, 1.0),
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  // Navigator.of(context).pushNamed('/register');
                                  Navigator.push(context, FadeRouter(RegisterPage()));
                                },
                              ),
                            ]
                          )
                        ),
                      ),
                    ),
                    Text('@Sukoshi 2016 - 2019', style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}