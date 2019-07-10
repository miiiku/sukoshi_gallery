import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sukoshi_gallery/constant/config.dart';
import 'package:sukoshi_gallery/component/user_submit_btn.dart';

class SelectTagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 标题
            Container(
              padding: EdgeInsets.symmetric(horizontal: P.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '选择一个',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '照片分类',
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // 分类内容
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: ImageTagBoxSize.width,
                height: ImageTagBoxSize.height,
                padding: EdgeInsets.all(P.margin),
                child: SelectImageTag(),
              ),
            ),

            // 按钮
            Container(
              padding: EdgeInsets.symmetric(horizontal: P.margin),
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 120.0,
                child: buildSubmitBtn('提交', () {
                  print('object');
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectImageTag extends StatefulWidget {
  @override
  _SelectImageTagState createState() => _SelectImageTagState();
}

class _SelectImageTagState extends State<SelectImageTag> {
  final _random = Random();
  Set<int> _likes = {};
  LinearGradient _linearGradient;

  @override
  void initState() {
    print(_random);
    print('object');
    _linearGradient = LinearGradient(
      colors: [
        Color.fromRGBO(223, 227, 142, 1),
        Color.fromRGBO(127, 231, 204, 1),
      ]
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List <Widget> Paopao = [];

    ImageTags.forEach((type) {
      Widget item = Positioned(
        top: type['top'],
        left: type['left'],
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: _likes.contains(type['tid']) ? _linearGradient : null,
              borderRadius: BorderRadius.circular(type['size']/2),
              boxShadow: C.btnShadow
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(type['size']/2),
            child: InkWell(
              borderRadius: BorderRadius.circular(type['size']/2),
              onTap: () {
                // 给喜欢的类型改变状态
                setState(() {
                  if (_likes.contains(type['tid'])) {
                    _likes.remove(type['tid']);
                  } else {
                    _likes.add(type['tid']);
                  }
                });
              },
              child: Container(
                width: type['size'],
                height: type['size'],
                child: Center(
                  child: Text(
                    type['value'],
                    style: TextStyle(
                      color: _likes.contains(type['tid']) ? Colors.white : Color.fromRGBO(24, 29, 40, 0.87),
                      fontSize: F.fontSizeBasic,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      Paopao.add(item);
    });

    return Stack(
      children: Paopao,
    );
  }
}