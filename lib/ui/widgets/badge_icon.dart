library badge;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Badge extends StatefulWidget {
  //the target widget
  final Widget child;

  //the badge text
  final String value;

  //the badge border width
  final double borderSize;

  //the badge position if it's not in the right place
  final double positionTop;
  final double positionRight;
  final double positionLeft;
  final double positionBottom;

  //if the badge is inside we have to set [_before]
  bool _inside = false;
  //if the badge is before or after the child
  bool _before;
  //we can set the space between the badge and the child
  double spacing;

  Badge({
    Key key,
    @required this.child,
    this.value = "0",
    this.borderSize = 2.0,
    this.positionTop =  -9.0,
    this.positionRight = 10.0,
    this.positionLeft,
    this.positionBottom,
  }) : super(key: key);

  //create a badge in the left corner of the child in a Stack
  Badge.left({
    Key key,
    @required this.child,
    this.value = "0",
    this.borderSize = 2.0,
    this.positionTop = -9.0,
    this.positionRight = 10.0,
    this.positionLeft,
    this.positionBottom,
  }) : super(key: key);

  @override
  _BadgeState createState() => new _BadgeState();
}

class _BadgeState extends State<Badge> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));

    _animation =
        new CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _animation.addListener(() => this.setState(() {}));

    _controller.forward();
  }

  @override
  void didUpdateWidget(Badge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget._inside) {
      return createBadgeInside();
    } else {
      return createBadgeCorner();
    }
  }

  //create the badge after/before the child
  Row createBadgeInside() {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        widget._before == true ? null : widget.child,
        new Container(
          margin: widget._before == true
              ? new EdgeInsets.only(right: widget.spacing)
              : new EdgeInsets.only(left: widget.spacing),
          child: Center(
              child: Text('${widget.value}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                  ))),
        ),
        widget._before == true ? widget.child : null,
      ].where((l) => l != null).toList(),
    );
  }

  //create the badge in the right/left corner of the child
  Stack createBadgeCorner() {
    return new Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        widget.child,
        new Positioned(
            top: widget.positionTop * _animation.value,
            right: widget.positionRight * _animation.value,
            left: widget.positionLeft,
            bottom: widget.positionBottom,
            child: new Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFFB74D),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                    child: Text('${widget.value}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )))))
      ],
    );
  }
}
