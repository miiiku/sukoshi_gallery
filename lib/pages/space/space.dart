import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sukoshi_gallery/constant/config.dart';
import 'package:sukoshi_gallery/component/appbar.dart';
import 'package:sukoshi_gallery/utils/utils.dart';
import 'package:sukoshi_gallery/datas.dart';

class SpacePage extends StatefulWidget {
  @override
  _SpacePageState createState() => _SpacePageState();
}

class _SpacePageState extends State<SpacePage> {
  bool _isCover;
  bool _isData;

  String test() {
    return '666';
  }

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

  // 构建已发布列表区域
  Widget buildAssetsList() {
    return Container(
      child: SliverStaggeredGrid.countBuilder(
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
              child: Image.network(
                images[index]['images'][0],
                fit: BoxFit.fill,
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) {
          return StaggeredTile.fit(1);
        },
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
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
      body: CustomScrollView(
        slivers: <Widget>[
          // 信息区域
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildUserInfo(),
                Container(
                  padding: EdgeInsets.all(P.margin),
                  child: Text(
                    '已发布',
                    style: TextStyle(
                      fontSize: F.fontSizeMax,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ]
            ),
          ),

          // 内容区域
          _isData == false ? buildNotData() : buildAssetsList(),
        ],
      )
    );
  }
}