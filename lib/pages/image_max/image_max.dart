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
                child: ImageDrag(url: widget.images[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ImageDrag extends StatefulWidget {
  const ImageDrag({ Key key, this.url }) : super(key: key);
  final String url;

  @override
  _ImageDragState createState() => _ImageDragState();
}

class _ImageDragState extends State<ImageDrag> with SingleTickerProviderStateMixin {
  final double minScale = 1.0;
  final double animationMinScale = 0.5;
  final double maxScale = 3.0;
  final double animationMaxScale = 3.5;
  
  AnimationController _animationController;
  Animation<double> _animationDouble;
  Animation<Offset> _animationOffset;
  Offset _offset = Offset.zero;
  Offset _normalizedOffset;
  Offset _lastFocalPoint;
  double _scale = 1.0;
  double _previousScale;
  
  Function isHorizontal;

  Offset _clampOffset(Offset offset) {
    final Size size = context.size;
    final Offset minOffset = Offset(size.width, size.height) * (1.0 - _scale);
    if (_scale >= 1.0) {
      return Offset(offset.dx.clamp(minOffset.dx, animationMinScale), offset.dy.clamp(minOffset.dy, animationMinScale));
    } else {
      return Offset(offset.dx.clamp(animationMinScale, minOffset.dx), offset.dy.clamp(animationMinScale, minOffset.dy));
    }
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    /// details.focalPoint 开始缩放时，两点之间的中心点位置
    _previousScale = _scale;
    _normalizedOffset = (details.focalPoint - _offset) / _scale;
    _animationController.stop();
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    _lastFocalPoint = details.focalPoint;
    /// details.scale 当前缩放倍率
    setState(() {
      /// 上次缩放的倍率*这次缩放的倍率（总缩放倍率）_previousScale * details.scale
      _scale = (_previousScale * details.scale).clamp(animationMinScale, animationMaxScale);
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
    });
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    /// 大于了最大缩放，或者小于了最小缩放，这里就触发动画
    if (_scale > maxScale || _scale < minScale) {
      /// 开始的值
      double startScale   = _scale;
      Offset startOffset  = _offset;
      /// 结束的值
      double endScale     = _scale.clamp(minScale, maxScale);
      Offset endOffset    = _clampOffset(_lastFocalPoint - _normalizedOffset * endScale);

      _animationDouble = Tween<double>(begin: startScale, end: endScale).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.0, 1.0,
            curve: Curves.ease,
          )
        )
      )..addListener(() {
        setState(() {
          _scale = _animationDouble.value;
        });
      });

      _animationOffset = Tween<Offset>(begin: startOffset, end: endOffset).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.0, 1.0,
            curve: Curves.ease,
          )
        )
      )..addListener(() {
        setState(() {
          _offset = _animationOffset.value;
        });
      });

      _animationController.forward().orCancel;

      if (endScale == 1.0) {
        isHorizontal = null;
      } else {
        isHorizontal = _handleOnHorizontalDragUpdate;
      }
    } else {
      _scale = _scale.clamp(minScale, maxScale);
      _offset = _clampOffset(_lastFocalPoint - _normalizedOffset * _scale);
      isHorizontal = _scale == 1.0 ? null : _handleOnHorizontalDragUpdate;
    }
  }

  void _handleOnHorizontalDragUpdate(DragUpdateDetails details) {}

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    // _animationController.addListener(() {
    //   setState(() {
    //     _offset = _animation.value;
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onScaleStart: _handleOnScaleStart,
        onScaleUpdate: _handleOnScaleUpdate,
        onScaleEnd: _handleOnScaleEnd,
        onHorizontalDragUpdate: isHorizontal,
        child: Container(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                child: Transform(
                  transform: Matrix4.identity()..translate(_offset.dx, _offset.dy)..scale(_scale),
                  child: Image(
                    image: NetworkImage(widget.url),
                  ),
                ),
              )
            ],
          ),
          // child: Transform(
          //   transform: Matrix4.identity()..translate(_offset.dx, _offset.dy)..scale(_scale),
          //   child: Image(
          //     image: NetworkImage(widget.url),
          //   ),
          // ),
        ),
      ),
    );
  }
}