import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sukoshi_gallery/constant/config.dart';
import 'package:sukoshi_gallery/datas.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: P.margin, vertical: 30.0),
                  child: Text(
                    '今日推荐',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: F.fontSizeMax,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: P.margin, vertical: 30.0),
                  child: Text(
                    '最近发布 ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: F.fontSizeMax,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecommendCard extends StatefulWidget {
  @override
  _RecommendCardState createState() => _RecommendCardState();
}

class _RecommendCardState extends State<RecommendCard> {

  double _currentPage = recommendList.length - 1.0;

  @override
  Widget build(BuildContext context) {

    PageController controller = PageController(
      initialPage: recommendList.length - 1,
    );

    controller.addListener(() {
      setState(() {
        _currentPage = controller.page;
      });
    });

    return Stack(
      children: <Widget>[
        CardScrollWidget(_currentPage),
        Positioned.fill(
          child: PageView.builder(
            itemCount: recommendList.length,
            controller: controller,
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              return Container();
            },
          ),
        )
      ],
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  double _currentPage;
  double _cardAspectRatio;
  double _widgetAspectRatio;
  double _padding = 20.0;

  CardScrollWidget(this._currentPage);

  @override
  void initState() {
    _cardAspectRatio = 12.0 / 16.0;
    _widgetAspectRatio = _cardAspectRatio * 1.2;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _widgetAspectRatio,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints contraints) {
          var width = contraints.maxWidth;
          var height = contraints.maxHeight;

          var safeWidth = width - 2 * _padding;
          var safeHeight = height - 2 * _padding;
        },
      ),
    );
  }
}