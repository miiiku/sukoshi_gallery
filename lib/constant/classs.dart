
class ImageObjce {
  String author;

  String title;

  List<String> tags;

  List<String> images;

  int createDate;

  ImageObjce(this.author, this.title, this.tags, this.images, this.createDate);
}

class User {
  // 手机号
  final int phone;

  // 你从
  final String nickname;

  // 头像
  final String avatar;

  // banner 图
  final String banner;

  // 个人说明
  final String desc;

  // token
  final String token;

  User(this.phone, this.nickname, this.avatar, this.banner, this.desc, this.token);

  User.fromJson(Map<String, dynamic> json) : 
    phone     = json['phone'],
    nickname  = json['nickname'],
    avatar    = json['avatar'],
    banner    = json['banner'],
    desc      = json['desc'],
    token     = json['token'];

  Map<String, dynamic> toJson() => {
    'phone'   : phone,
    'nickname': nickname,
    'avatar'  : avatar,
    'banner'  : banner,
    'desc'    : desc,
    'token'   : token,
  };
}