import 'package:flutter/material.dart';
import 'package:sukoshi_gallery/constant/config.dart';
import 'package:sukoshi_gallery/component/appbar.dart';
import 'package:sukoshi_gallery/component/router_style.dart';
import 'package:sukoshi_gallery/component/user_submit_btn.dart';

class RetrievePage extends StatelessWidget {
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
                  '忘记密码',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: P.margin),
                child: Text(
                  '请在下方输入你的手机号或邮箱地址，接收我们的重制密码邮件！',
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
                        hintText: '请输入你的手机号或邮箱号',
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
                    buildSubmitBtn('发送', () {
                      Navigator.push(context, FadeRouter(RetrieveNextPage()));
                    }),
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

class RetrieveNextPage extends StatefulWidget {
  @override
  _RetrieveNextPageState createState() => _RetrieveNextPageState();
}

class _RetrieveNextPageState extends State<RetrieveNextPage> {
  bool _passWordVisible;

  @override
  void initState() {
    _passWordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: P.margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: P.margin),
                child: Text(
                  '重置密码',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: P.margin),
                child: Text(
                  '重置代码已经发送至你的邮箱，请在下方输入代码并重置你的密码。',
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
                        labelText: '代码',
                        labelStyle: TextStyle(
                          fontSize: F.fontSizeMin
                        ),
                        hintText: '请输入你收到的重置代码',
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
                        hintText: '请重新设置你的登陆密码',
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
                    buildSubmitBtn('更改密码', () {
                      print('object.....');
                    }),
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