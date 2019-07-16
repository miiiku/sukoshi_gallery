import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:sukoshi_gallery/component/appbar.dart';
import 'package:sukoshi_gallery/constant/config.dart';
import 'package:sukoshi_gallery/utils/utils.dart';
import 'package:sukoshi_gallery/datas.dart';

typedef onClick = void Function();

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.type}) : super(key: key);

  final bool type;

  @override
  _DetailsPageState createState() => _DetailsPageState(type);
}

class _DetailsPageState extends State<DetailsPage> {

  _DetailsPageState(this.type);

  bool type;

  Widget _buildImageContainer() {
    if (type) {
      return Swiper(
        autoplay: false,
        itemCount: detailsInfo['images'].length,
        itemBuilder: (BuildContext contenxt, int index) {
          return Container(
            child: Image(
              image: NetworkImage(detailsInfo['images'][index]),
            ),
          );
        },
        pagination: SwiperPagination(),
      );
    } else {
      return Image.asset(S.defaultSpaceBanner);
    }
  }

  List<Widget> _buildTags() {
    final List<String> tags = detailsInfo['tags'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarContainer(),
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
                    child: _buildImageContainer(),
                  ),
                ),
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
                          detailsInfo['title'],
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
                          children: _buildTags(),
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
                                            child: Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            ),
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
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     // 图片显示区域
          //     Container(
          //       width: double.infinity,
          //       color: Colors.black12,
          //       child: AspectRatio(
          //         aspectRatio: 1920/1080,
          //         child: _buildImageContainer(),
          //       ),
          //     ),
          //     // 内容显示区域
          //     Container(
          //       padding: EdgeInsets.symmetric(horizontal: P.margin, vertical: P.margin / 2),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           // 作者相关内容
          //           Container(
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: <Widget>[
          //                 // 左侧
          //                 Container(
          //                   child: Row(
          //                     children: <Widget>[
          //                       Container(
          //                         margin: EdgeInsets.only(right: 10.0),
          //                         width: 36.0,
          //                         height: 36.0,
          //                         child: CircleAvatar(
          //                           radius: 18.0,
          //                           backgroundImage: NetworkImage(detailsInfo['avatar']),
          //                         ),
          //                       ),
          //                       Column(
          //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: <Widget>[
          //                           Text(detailsInfo['author']),
          //                           Text(
          //                             '${quantizationNumber(detailsInfo["fans"])}粉丝',
          //                             style: TextStyle(
          //                               color: Colors.grey,
          //                               fontSize: 12.0,
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 // 右侧
          //                 Container(
          //                   child: Row(
          //                     children: <Widget>[
          //                       _buildBtn('收藏', Colors.pink, Icons.favorite, (){}),
          //                       SizedBox(width: 10.0),
          //                       _buildBtn('关注', Colors.pink, Icons.add, (){}),
          //                     ],
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           // 标题
          //           Container(
          //             padding: EdgeInsets.only(top: 10.0),
          //             child: Text(
          //               detailsInfo['title'],
          //               style: TextStyle(
          //                 fontSize: F.fontSizeMax,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //           // tags
          //           Container(
          //             padding: EdgeInsets.symmetric(vertical: 10.0),
          //             child: Row(
          //               children: _buildTags(),
          //             ),
          //           ),
          //           // 时间
          //           Container(
          //             child: Text(
          //               formatDate(detailsInfo['creatDate']),
          //               style: TextStyle(
          //                 color: Colors.grey
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     // 分割线
          //     Divider(),
          //     // 作者其他相关内容
          //     Container(
          //       padding: EdgeInsets.all(P.margin),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Padding(
          //             padding: EdgeInsets.only(bottom: P.margin),
          //             child: Text(
          //               '其他作品', 
          //               style: TextStyle(
          //                 fontSize: F.fontSizeMax,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             ),
          //           ),
          //           Container(
          //             width: double.infinity,
          //             height: 120.0,
          //             child: GridView.builder(
          //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                 crossAxisCount: 3,
          //                 mainAxisSpacing: 10.0,
          //                 crossAxisSpacing: 10.0,
          //                 childAspectRatio: 1.0,
          //               ),
          //               itemCount: images.length,
          //               itemBuilder: (BuildContext context, int index) {
          //                 return Container(
          //                   child: GestureDetector(
          //                     onTap: () {},
          //                     child: ClipRRect(
          //                       borderRadius: BorderRadius.circular(16.0),
          //                       child: Stack(
          //                         fit: StackFit.expand,
          //                         children: <Widget>[
          //                           Positioned.fill(
          //                             child: Image(
          //                               image: NetworkImage(images[index]['images'][0]),
          //                               fit: BoxFit.cover,
          //                             ),
          //                           ),
          //                           Positioned(
          //                             top: 5.0,
          //                             right: 8.0,
          //                             child: Container(
          //                               padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          //                               decoration: BoxDecoration(
          //                                 borderRadius: BorderRadius.circular(8.0),
          //                                 color: Colors.black54,
          //                               ),
          //                               child: Row(
          //                                 children: <Widget>[
          //                                   Icon(
          //                                     Icons.photo_library,
          //                                     size: 12.0,
          //                                     color: Colors.white,
          //                                   ),
          //                                   Text(
          //                                     '${images[index]["images"].length}',
          //                                     style: TextStyle(
          //                                       color: Colors.white,
          //                                       fontSize: 12.0,
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                           Positioned(
          //                             right: 8.0,
          //                             bottom: 5.0,
          //                             child: Material(
          //                               color: Colors.transparent,
          //                               child: InkWell(
          //                                 child: Icon(
          //                                   Icons.favorite_border,
          //                                   color: Colors.white,
          //                                 ),
          //                               ),
          //                             ),
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 );
          //               },
          //             )
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}