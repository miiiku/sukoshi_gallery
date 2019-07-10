import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:sukoshi_gallery/pages/login/teddy_controller.dart';
import 'package:sukoshi_gallery/pages/login/tracking_text_input.dart';
import 'package:sukoshi_gallery/component/router_style.dart';
import 'package:sukoshi_gallery/component/user_submit_btn.dart';
import 'package:sukoshi_gallery/constant/config.dart';

import 'package:sukoshi_gallery/pages/register/register.dart';
import 'package:sukoshi_gallery/pages/retrieve/retrieve.dart';
import 'package:sukoshi_gallery/pages/space/space.dart';

class LoginPage extends StatefulWidget {
  LoginPage({ Key key, this.title }) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TeddyController _teddyController;
  String _accountnumber;
  String _password;

  void _onSubmit() {
    if (_accountnumber == "sukoshi" && _password == "111") {
      _teddyController.onSuccess();
      Navigator.push(context, FadeRouter(SpacePage()));
    } else {
      _teddyController.onFail();
    }
  }

  @override
  void initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      appBar: AppBar(
        title: Text(
          '登陆',
          style: TextStyle(
            fontSize: F.fontSizeBasic,
            letterSpacing: F.letterSpacing,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 150.0,
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: FlareActor(
                        'assets/flr/teddy.flr',
                        shouldClip: false,
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.contain,
                        controller: _teddyController,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(P.margin),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TrackingTextInput(
                                label: '手机号/邮箱',
                                hint: '输入手机号或邮箱号',
                                onCaretMoved: (Offset caret) {
                                  _teddyController.lookAt(caret);
                                },
                                onTextChanged: (String value) {
                                  setState(() => _accountnumber = value);
                                },
                              ),
                              TrackingTextInput(
                                label: '密码',
                                hint: '输入登陆密码',
                                isObscured: true,
                                onCaretMoved: (Offset caret) {
                                  _teddyController.coverEyes(caret != null);
                                  _teddyController.lookAt(caret);
                                },
                                onTextChanged: (String value) {
                                  setState(() => _password = value);
                                },
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
                            ],
                          ),
                        ),
                      ),
                    ),
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
                                  color: Colors.white,
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
                                  Navigator.push(context, FadeRouter(registerPage()));
                                },
                              ),
                            ]
                          )
                        ),
                        // child: Text('@Sukoshi 2016 - 2019', style: TextStyle(
                        //   color: Colors.white,
                        //   fontWeight: FontWeight.bold,
                        // )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}