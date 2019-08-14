import 'package:flutter/material.dart';
import 'package:restorder/ui/clipers/arc_clipper.dart';
import 'package:restorder/utils/translations.dart';
import 'package:restorder/utils/uidata.dart';

class LoginBackground extends StatelessWidget {
  final showIcon;
  final image;

  LoginBackground({this.showIcon = true, this.image});

  Widget topHalf(BuildContext context) {
    return new Flexible(
      flex: 2,
      child: ClipPath(
        clipper: new ArcClipper(),
        child: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: UIData.kitGradients,
                  )),
            ),
            showIcon
                ? new Center(child: Text(Translations.of(context).text("group_name"), style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
                color: Colors.white)),
            ): new Container()
          ],
        ),
      ),
    );
  }

  final bottomHalf = new Flexible(
    flex: 3,
    child: new Container(),
  );

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[topHalf(context), bottomHalf],
    );
  }
}
