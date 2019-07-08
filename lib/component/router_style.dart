import 'package:flutter/material.dart';

class FadeRouter extends PageRouteBuilder {
  final Widget widget;

  FadeRouter(this.widget) : super(
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: Tween(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
        )),
        child: child,
      );
    },
  );
}