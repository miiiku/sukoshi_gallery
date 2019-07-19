import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 选择图片标签tag的容器大小
final Size ImageTagBoxSize = Size(412.0, 390.0);

// 图片标签
final List<Map<String, dynamic>> ImageTags = [
  {
    'left': 25.0,
    'top': 15.0,
    'size': 97.64,
    'value': '壁纸',
    'tid': 1,
    'gradient': null
  },
  {
    'left': 60.0,
    'top': 130.0,
    'size': 72.92,
    'value': '头像',
    'tid': 2,
    'gradient': null
  },
  {
    'left': 4.0,
    'top': 220.0,
    'size': 115.86,
    'value': '表情包',
    'tid': 3,
    'gradient': null
  },
  {
    'left': 145.0,
    'top': 20.0,
    'size': 160.14,
    'value': '动漫',
    'tid': 4,
    'gradient': null
  },
  {
    'left': 130.0,
    'top': 204.0,
    'size': 115.88,
    'value': '卡通',
    'tid': 5,
    'gradient': null
  },
  {
    'left': 255.0,
    'top': 270.0,
    'size': 67.08,
    'value': '风景',
    'tid': 6,
    'gradient': null
  },
  {
    'left': 285.0,
    'top': 170.0,
    'size': 85.92,
    'value': '颜色',
    'tid': 7,
    'gradient': null
  },
];

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

class S {
  // 默认头像
  static const String defaultAvatar = 'assets/images/default_avatar.jpg';
  // 默认空间banner图
  static const String defaultSpaceBanner = 'assets/images/default_space_banner.jpg';
  // 首页banner导航栏图
  static const String bannerNavItemCalendar   = 'assets/images/banner_calendar.png';
  static const String bannerNavItemUpdate     = 'assets/images/banner_update.png';
  static const String bannerNavItemRanking    = 'assets/images/banner_ranking.png';
  static const String bannerNavItemTag        = 'assets/images/banner_tag.png';
  static const String bannerNavItemCollection = 'assets/images/banner_collection.png';
  // 登陆背景
  static const String loginVideo = 'assets/video/login.mp4';
  static const String loginImage = 'assets/images/login.png';

  // 分享
  static const String share     = 'assets/images/share.png';
  // 下载
  static const String download  = 'assets/images/download.png';

  // 动画
  // 收藏
  static const String favorite = 'assets/flrs/favorite.flr';
}

class P {
  static double margin = 20.0;
}

class C {
  // 灰色
  static const Color gray = Color.fromRGBO(151, 151, 151, 1.0);
  // 按钮阴影
  static List<BoxShadow> btnShadow = [BoxShadow(color: Color.fromRGBO(159, 210, 243, 0.35), blurRadius: 24.0, spreadRadius: 0.0, offset: Offset(0.0, 12.0),)];
}

class InterfaceInfo {
  static const platform = const MethodChannel('sukoshi.flutter.io/battery');

  // ios震动反馈系统
  static Future<Null> onShock() async {
    try {
      await platform.invokeMethod('onShock');
      print('震动成功');
    } on PlatformException catch (e) {
      print(e);
      print('震动失败');
    }
  }
}