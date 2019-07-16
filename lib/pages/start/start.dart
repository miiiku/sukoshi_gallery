import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'package:sukoshi_gallery/constant/config.dart';
import 'package:sukoshi_gallery/component/router_style.dart';
import 'package:sukoshi_gallery/component/user_submit_btn.dart';

import 'package:sukoshi_gallery/pages/home/home.dart';
import 'package:sukoshi_gallery/pages/register/register.dart';
import 'package:sukoshi_gallery/pages/login/login.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(S.loginVideo)
    // 在初始化完成后必须更新界面
      ..initialize().then((_) {
        setState(() {
          // 视频为播放状态
          _videoController.setVolume(0.5);
          _videoController.play();
          // 循环播放
          _videoController.setLooping(true);
        });
      });
  }

  @override
  dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }
    
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            // 背景图
            Positioned.fill(
              child: Image.asset(S.loginImage, fit: BoxFit.cover),
            ),
            // 背景视频
            Positioned.fill(
              child: _videoController.value.initialized
                ? AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                ) : Container(),
            ),
            // 内容
            Positioned.fill(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // 文案区域
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: P.margin, vertical: 60.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '插画交流网站 [pixiv]',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: F.fontSizeMax,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox( height: P.margin ),
                            Text(
                              'pixiv是提供插画等作品的投稿、阅览服务的「插画交流网站」。这里有各种各样不同风格的投稿作品，我们还会举办官方、用户企画的各种比赛。',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: F.fontSizeMin,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      // 按钮区域
                      Container(
                        padding: EdgeInsets.all(P.margin),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: buildSubmitBtn('登陆', () {
                                Navigator.push(context, FadeRouter(LoginPage()));
                              }),
                            ),
                            SizedBox( width: P.margin ),
                            Expanded(
                              child: buildSubmitBtn('注册', () {
                                Navigator.push(context, FadeRouter(RegisterPage()));
                              }),
                            ),
                          ],
                        ),
                      ),
                      // 底部区域
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: P.margin, vertical: 30.0),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: '嫌太麻烦？',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: ' 点击跳过（○｀ 3′○）',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(160, 92, 147, 1.0),
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                    Navigator.push(context, FadeRouter(HomePage()));
                                    _videoController.pause();
                                  },
                                ),
                              ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}