import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:sukoshi_gallery/constant/config.dart';

class ImageMaxPage extends StatefulWidget {
  final List<String> images;
  final int index;

  ImageMaxPage({Key key, this.images, this.index}) : super(key: key);

  @override
  _ImageMaxPageState createState() => _ImageMaxPageState();
}

class _ImageMaxPageState extends State<ImageMaxPage> {

  Widget _buildModalBottom(String title, String icon, Function click) {
    return Container(
      width: 50.0,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Material(
              child: InkWell(
                onTap: click,
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  child: Image(
                    image: AssetImage(icon),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7.0),
            child: Text(title),
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color.fromRGBO(232, 232, 232, 1),
      builder: (BuildContext context) {
        return Container(
          height: 180.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // 内容区域
              Container(
                padding: EdgeInsets.all(P.margin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildModalBottom('下载', S.download, (){

                    }),
                    _buildModalBottom('分享', S.share, () {

                    }),                
                  ],
                ),
              ),
              // 取消
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    // 隐藏
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Text(
                      '取消',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 这里如果不延迟执行，会感觉上一个页面有明显的向上抖动
    // 这里延迟时间设置成跟FadeRouter路由动画时间一样
    Future.delayed(const Duration(milliseconds: 200), () => SystemChrome.setEnabledSystemUIOverlays([]));
    return Scaffold(
      body: Container(
        child: Swiper(
          loop: false,
          index: widget.index,
          autoplay: false,
          itemCount: widget.images.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, index);
                },
                onLongPress: () {
                  _showModalBottomSheet(context);
                },
                child: Image(
                  image: NetworkImage(widget.images[index]),
                ),
              ),
            );
          },
          pagination: SwiperPagination(
            alignment: Alignment.topCenter,
            builder: SwiperPagination.fraction
          ),
        ),
      ),
    );
  }
}