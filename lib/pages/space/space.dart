import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sukoshi_gallery/constant/config.dart';
import 'package:sukoshi_gallery/constant/classs.dart';
import 'package:sukoshi_gallery/component/appbar.dart';
import 'package:sukoshi_gallery/utils/utils.dart';
import 'package:sukoshi_gallery/datas.dart';

typedef onClick = void Function();

class SpacePage extends StatefulWidget {
  @override
  _SpacePageState createState() => _SpacePageState();
}

class _SpacePageState extends State<SpacePage> {
  bool _isCover;
  bool _isData;

  // 个人空间背景图
  Widget returnAppBarImage() {
    if (_isCover) {
      return Image.network('https://qiniu.miiiku.xyz/src/images/banner-footer.jpg', fit: BoxFit.cover);
    } else {
      return Image.asset(S.defaultSpaceBanner, fit: BoxFit.cover);
    }
  }

  // 构建信息区域
  Widget buildUserInfo() {
    return Column(
      children: <Widget>[
        // 头部
        Container(
          height: 190.0,
          child: Stack(
            children: <Widget>[
              // 头部图片
              Container(
                child: SizedBox(
                  width: double.infinity,
                  height: 150.0,
                  child: returnAppBarImage(),
                ),
              ),
              Positioned(
                top: 110.0,
                left: P.margin,
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 4.0,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(44.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(44.0),
                    child: Image.network('https://qiniu.miiiku.xyz/src/images/64f10fbebc74e345d0333528f6f9bc4a.jpeg'),
                  ),
                ),
              ),
            ],
          ),
        ),

        // 信息主体
        Container(
          padding: EdgeInsets.all(P.margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sukoshi dayo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: F.fontSizeMax,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox( height: 10.0 ),
              Text(
                '“望咩啊，死靓仔！”',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox( height: 10.0 ),
              Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: quantizationNumber(120),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: ' 个动态',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ]
                    ),
                  ),
                  SizedBox( width: 20.0 ),
                  RichText(
                    text: TextSpan(
                      text: quantizationNumber(666123),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: ' 个喜欢',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ]
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]
    );
  }

  // 构建暂无数据区域
  Widget buildNotData() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50.0),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Divider(),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              '暂无更多信息',
              style: TextStyle(
                color: Colors.grey
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _isCover = false;
    _isData = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarContainer(title: 'Sukoshi'),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildUserInfo(),
              BlockInfo(
                '已发布',
                [
                  ImageObjce(images[0]['author'], images[0]['title'], images[0]['tags'], images[0]['images'], images[0]['createDate']),
                  ImageObjce(images[1]['author'], images[1]['title'], images[1]['tags'], images[1]['images'], images[1]['createDate']),
                  ImageObjce(images[2]['author'], images[2]['title'], images[2]['tags'], images[2]['images'], images[2]['createDate']),
                ],
                () {
                  print('click');
                }
              ),
              BlockInfo(
                '已收藏',
                [
                  ImageObjce(images[14]['author'], images[14]['title'], images[14]['tags'], images[14]['images'], images[14]['createDate']),
                  ImageObjce(images[15]['author'], images[15]['title'], images[15]['tags'], images[15]['images'], images[15]['createDate']),
                  ImageObjce(images[13]['author'], images[13]['title'], images[13]['tags'], images[13]['images'], images[13]['createDate']),
                ],
                () {
                  print('click');
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlockInfo extends StatelessWidget {
  String title;

  List<ImageObjce> images;

  onClick click;

  BlockInfo(this.title, this.images, this.click);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: P.margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: P.margin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: F.fontSizeMax,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                InkWell(
                  onTap: click,
                  child: Row(
                    children: <Widget>[
                      Text(
                        '查看更多',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                        size: 18.0,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 140.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: P.margin / 4, vertical: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image(
                      image: NetworkImage(images[index].images[0]),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}