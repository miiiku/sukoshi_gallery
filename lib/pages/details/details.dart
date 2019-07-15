import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:sukoshi_gallery/component/appbar.dart';
import 'package:sukoshi_gallery/constant/config.dart';
import 'package:sukoshi_gallery/datas.dart';

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
      print(item);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarContainer(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 图片显示区域
              Container(
                width: double.infinity,
                color: Colors.black26,
                child: AspectRatio(
                  aspectRatio: 1920/1080,
                  child: _buildImageContainer(),
                ),
              ),
              // 内容显示区域
              Container(
                padding: EdgeInsets.symmetric(horizontal: P.margin, vertical: P.margin / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      detailsInfo['title'],
                      style: TextStyle(
                        fontSize: F.fontSizeMax,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: _buildTags(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}