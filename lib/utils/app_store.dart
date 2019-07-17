import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sukoshi_gallery/constant/classs.dart';

class AppStore {
  // 查询本地用户数据
  static Future<User> userInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userInfo = prefs.getString('UserInfo');
    return userInfo == null ? null : User.fromJson(jsonDecode(userInfo));
  }
}