import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:sukoshi_gallery/component/appbar.dart';
import 'package:sukoshi_gallery/component/router_style.dart';
import 'package:sukoshi_gallery/constant/config.dart';
import 'package:sukoshi_gallery/utils/utils.dart';
import 'package:sukoshi_gallery/datas.dart';

import 'package:sukoshi_gallery/pages/image_max/image_max.dart';

typedef onClick = void Function();

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.sid}) : super(key: key);

  final int sid;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  String play = 'unfavorite';
  SwiperController controller;

  void goImagePage(BuildContext context, List<String> images, int index) async {
    Navigator.push(context, FadeRouter(ImageMaxPage(images: images, index: index)))
      .then((index) {
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
        if (index == null) return;
        setState(() {
          controller.move(index, animation: false);
        });
      });
  }

  // 获取数据
  Future<Map<String, dynamic>> _fetchData(int sid) async {
    Map<String, dynamic> data;
    switch (sid) {
      case 0:
        data = largeList;
        break;
      case 1:
        data = mobileList;
        break;
      case 2:
        data = avatarList;
        break;
      case 3:
        data = onlyData;
        break;
      default:
        data = largeList;
    }

    // 模拟获取数据的时间
    await Future.delayed(const Duration(milliseconds: 500));

    return data;
  }

  // 构建图片显示区域
  Widget _buildSwiperContainer(BuildContext context, List<String> images) {
    if (images.length > 1) {
      return Swiper(
        autoplay: false,
        onTap: (int index) {
          goImagePage(context, images, index);
        },
        controller: controller,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Image(
              image: NetworkImage(images[index]),
            ),
          );
        },
        pagination: SwiperPagination(),
      );
    } else {
      return Container(
        child: GestureDetector(
          onTap: () {
            goImagePage(context, images, 0);
          },
          child: Image.network(images[0]),
        ),
      );
    }
  }

  // 构建标签列表
  List<Widget> _buildTags(List<String> tags) {
    return tags.map((item) {
      return Container(
        margin: EdgeInsets.only(right: 10.0),
        child: Text(
          '#$item',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      );
    }).toList();
  }

  // 构建收藏/关注按钮
  Widget _buildBtn(String title, Color color, IconData icon, onClick click) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: click,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 12.0,
                color: Colors.white,
              ),
              SizedBox(width: 2.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建loading
  Widget _buildLoading() {
    return Container(
      color: Colors.pink,
      child: Center(
        child: Text('loading...'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = SwiperController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(widget.sid),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> data) {
        if (data.hasData) {
          Map<String, dynamic> dataInfo = data.data;
          return Scaffold(
            appBar: buildAppBarContainer(title: detailsInfo['title']),
            body: Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      // 图片显示区域
                      Container(
                        width: double.infinity,
                        color: Colors.black12,
                        child: AspectRatio(
                          aspectRatio: 1920/1080,
                          child: _buildSwiperContainer(context, dataInfo['images']),
                        ),
                      ),
                      // 内容详情
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: P.margin, vertical: P.margin / 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // 作者相关内容
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // 左侧
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 10.0),
                                          width: 36.0,
                                          height: 36.0,
                                          child: CircleAvatar(
                                            radius: 18.0,
                                            backgroundImage: NetworkImage(detailsInfo['avatar']),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(detailsInfo['author']),
                                            Text(
                                              '${quantizationNumber(detailsInfo["fans"])}粉丝',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // 右侧
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 20.0,
                                          height: 20.0,
                                          margin: EdgeInsets.only(right: 10.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              /// 调用IOS震动反馈
                                              InterfaceInfo.onShock();
                                              if (play == 'favoriteStatic') {
                                                setState(() {
                                                  play = 'unfavorite';
                                                });
                                              } else {
                                                setState(() {
                                                  play = 'favorite';
                                                });
                                              }
                                            },
                                            child: FlareActor(
                                              S.favorite,
                                              animation: play,
                                              fit: BoxFit.contain,
                                              callback: (animationName) {
                                                if (animationName == "favorite") {
                                                  setState(() {
                                                    play = 'favoriteStatic';
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        _buildBtn('收藏', Colors.pink, Icons.favorite, (){}),
                                        SizedBox(width: 10.0),
                                        _buildBtn('关注', Colors.pink, Icons.add, (){}),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 标题
                            Container(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                dataInfo['title'],
                                style: TextStyle(
                                  fontSize: F.fontSizeMax,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // tags
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: _buildTags(dataInfo['tags']),
                              ),
                            ),
                            // 时间
                            Container(
                              child: Text(
                                formatDate(detailsInfo['creatDate']),
                                style: TextStyle(
                                  color: Colors.grey
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 分割线
                      Divider(),
                      // 其他作品
                      Padding(
                        padding: EdgeInsets.all(P.margin),
                        child: Text(
                          '其他作品', 
                          style: TextStyle(
                            fontSize: F.fontSizeMax,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1/1.2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Container(
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    child: AspectRatio(
                                      aspectRatio: 1.0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6.0),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: <Widget>[
                                            Positioned.fill(
                                              child: Image(
                                                image: NetworkImage(images[index]['images'][0]),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              top: 5.0,
                                              right: 8.0,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  color: Colors.black54,
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.photo_library,
                                                      size: 12.0,
                                                      color: Colors.white,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(left: 2.0),
                                                      child: Text(
                                                        '${images[index]["images"].length}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 8.0,
                                              bottom: 5.0,
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  child: Container(
                                                    width: 20.0,
                                                    height: 20.0,
                                                    child: FlareActor(
                                                      S.favorite,
                                                      animation: 'unfavorite',
                                                    ),
                                                  ),
                                                  // child: Icon(
                                                  //   Icons.favorite_border,
                                                  //   color: Colors.white,
                                                  // ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: AspectRatio(
                                      aspectRatio: 1/0.2,
                                      child: Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          images[index]['title'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: F.fontSizeMin,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: 9
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return _buildLoading();
        }
      },
    );
  }
}