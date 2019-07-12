import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sukoshi_gallery/constant/config.dart';
import 'package:sukoshi_gallery/component/router_style.dart';
import 'package:sukoshi_gallery/pages/space/space.dart';
import 'package:sukoshi_gallery/utils/utils.dart';
import 'package:sukoshi_gallery/datas.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.7),
        border: null,
        middle: GestureDetector(
          onTap: () {},
          child: Container(
            height: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 5.0),
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(150, 150, 150, 0.1),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: F.fontSizeMin
                ),
                SizedBox(
                  width: 3.0,
                ),
                Text(
                  '每天从搜索开始',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: F.fontSizeMin,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, FadeRouter(SpacePage()));
          },
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: AssetImage(S.defaultAvatar),
              ),
            ),
          ),
        ),
        trailing: GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Icon(Icons.bubble_chart),
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                HomeSwiper(),
                HomeWidgetAvatar(),
                HomeWidgetWallpaper(),
                HomeWidgetMobile(),
                HomeWidgetSpecialColumn(),
              ],
            )
          ),
        ),
      ),
    );
  }
}

typedef onClick = void Function();

class HomeSwiper extends StatelessWidget {

  Widget buildNavItem(String title, String icon, onClick click) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: click,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: SizedBox(
                  width: 25.0,
                  height: 25.0,
                  child: Image(
                    image: AssetImage(icon),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: F.fontSizeMin,
                color: Colors.black.withOpacity(0.6),
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          // 轮播图
          Container(
            height: 160.0,
            child: Swiper(
              autoplay: false,
              onTap: (int index) {},
              itemCount: bannerList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(P.margin / 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      color: Colors.red.withOpacity(0.8),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.network(bannerList[index]['image'], fit: BoxFit.cover),
                          Positioned(
                            bottom: 0, right: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0)),
                              child: Container(
                                color: Colors.red.withOpacity(0.8),
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                child: Text(
                                  bannerList[index]['tag'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              pagination: SwiperPagination(),
            ),
          ),

          // 导航栏
          Container(
            width: double.infinity,
            height: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildNavItem('今日推荐', S.bannerNavItemCalendar, () {
                  print('今日推荐');
                }),
                buildNavItem('最新更新', S.bannerNavItemUpdate, () {
                  print('最新更新');
                }),
                buildNavItem('排行榜单', S.bannerNavItemRanking, () {
                  print('排行榜单');
                }),
                buildNavItem('标签列表', S.bannerNavItemTag, () {
                  print('标签列表');
                }),
                buildNavItem('我的收藏', S.bannerNavItemCollection, () {
                  print('我的收藏');
                }),
              ],
            ),
          ),

          // 边框
          Divider(),
        ],
      )
    );
  }
}

class HomeWdigetTitle extends StatelessWidget {
  String title;
  onClick click;

  HomeWdigetTitle(this.title, this.click);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: F.fontSizeMax,
            decoration: TextDecoration.none,
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: click,
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Text(
                '去康康',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: F.fontSizeMin,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 头像栏目
class HomeWidgetAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(P.margin),
      child: Column(
        children: <Widget>[
          HomeWdigetTitle('好看头像', (){ }),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: avatarList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image(
                      image: NetworkImage(avatarList[index]['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 壁纸栏目
class HomeWidgetWallpaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(P.margin),
      child: Column(
        children: <Widget>[
          HomeWdigetTitle('推荐壁纸', () {}),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: bannerList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 100.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image(
                      image: NetworkImage(bannerList[index]['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 16/9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 手机壁纸栏目（应该会跟壁纸合成一个）
class HomeWidgetMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(P.margin),
      child: Column(
        children: <Widget>[
          HomeWdigetTitle('手机壁纸', (){}),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: mobileList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 100.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image(
                      image: NetworkImage(mobileList[index]['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 9/16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 专栏
class HomeWidgetSpecialColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.3),
      padding: EdgeInsets.symmetric(vertical: P.margin / 2),
      child: Container(
        padding: EdgeInsets.all(P.margin),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '专栏',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: F.fontSizeBasic,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.refresh,
                        ),
                        Text(
                          '获取新内容',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: F.fontSizeMin,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      '装不下的人生百态',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: F.fontSizeMin,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: AspectRatio(
                        aspectRatio: 16.0/9.0,
                        child: Image(
                          image: AssetImage(S.defaultSpaceBanner),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      '逢坂大河&钉宫理惠',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: F.fontSizeMax,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class list extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          clipBehavior: Clip.antiAlias,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                Image.network(
                  images[index]['images'][0],
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: 10.0, right: 10.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        quantizationNumber(Random().nextInt(99999)),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      InkWell(
                        onTap: () { print('like'); },
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.pink,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) {
        return StaggeredTile.fit(1);
      },
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}