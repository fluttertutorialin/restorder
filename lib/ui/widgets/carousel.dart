import 'dart:async';

import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final bool autoPlay; 
  final Duration playInterval;
  final Duration playDuration; 
  final int initIndex;
  final double dotSize;
  final Curve curve;
  final bool showIndicators;
  final Axis scrollDirection;
  final double viewportFraction;
  final List<Widget> children;
  final int _length;

  Carousel(
      {@required this.children,
      this.playInterval,
      this.autoPlay = false,
      this.initIndex = 0,
      this.dotSize = 8.0,
      this.curve = Curves.fastOutSlowIn,
      this.playDuration,
      this.showIndicators = true,
      this.scrollDirection = Axis.horizontal,
      this.viewportFraction = 1.0})
      : _length = children.length,
        assert(children.length > 0),
        assert(viewportFraction > 0.0),
        assert(
            (initIndex >= 0) && (initIndex < children.length));

  @override
  CarouselState createState() {
    return new CarouselState();
  }
}

class CarouselState extends State<Carousel>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  Timer timer;
  int _currentPage;
  int _realCurrentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = 100 * widget._length + widget.initIndex;

    _realCurrentPage = widget.initIndex;
    _pageController = PageController(
        initialPage: _currentPage, viewportFraction: widget.viewportFraction);

    if (widget.autoPlay) {
      Duration playInterval = widget.playInterval ?? Duration(seconds: 3);
      Duration playDuration = widget.playDuration ?? Duration(seconds: 1);
      timer = Timer.periodic(playInterval, (Timer t) {
        int toPage = _currentPage = _currentPage + 1;
        setState(() {
          _currentPage = toPage;
        });
        _pageController.animateToPage(toPage,
            duration: playDuration, curve: widget.curve);
      });
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
            child: PageView.builder(
                controller: _pageController,
                scrollDirection: widget.scrollDirection,
                itemBuilder: (context, i) {
                  int index = i % widget._length;
                  return widget.children[index];
                },
                onPageChanged: (i) {
                  setState(() {
                    _currentPage = i;
                    _realCurrentPage = i % widget._length;
                  });
                })),
        _buildIndicators(),
      ],
    );
  }

  Widget _buildIndicators() {
    if (!widget.showIndicators) {
      return Container();
    }
    List<Widget> widgets = [];
    for (int i = 0; i < widget._length; i++) {
      Color color =
          _realCurrentPage == i ? Theme.of(context).primaryColor : Colors.white;
      widgets.add(Container(
        margin: EdgeInsets.only(right: widget.dotSize),
        width: widget.dotSize * (_realCurrentPage == i ? 2 : 1),
        height: widget.dotSize / 2,
        decoration: ShapeDecoration(shape: StadiumBorder(), color: color),
      ));
    }
    return Positioned(
      bottom: 10.0,
      right: 10.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    );
  }
}
