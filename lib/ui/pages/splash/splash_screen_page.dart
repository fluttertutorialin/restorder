import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restorder/ui/pages/login/login_page.dart';
import 'package:restorder/utils/translations.dart';

Color colorOne = Colors.orangeAccent;
Color colorTwo = Colors.orange[300];
Color colorThree = Colors.orange[100];

final appTheme = ThemeData(
  primarySwatch: Colors.orange,
);

class SplashScreenPage extends StatefulWidget {
  @override
  createState() => new _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Duration five;
  Timer t2;
  String routeName;

  @override
  void initState() {
    super.initState();
    five = const Duration(seconds: 3);
    t2 = new Timer(five, () {
      getCredential();
    });
  }

  @override
  void dispose() {
    if (this.mounted)
    super.dispose();
    t2.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          HeaderBar(),
          Container(
              height: double.infinity,
              width: double.infinity,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: new Text(
                        Translations.of(context).text("app_name"),
                      style: new TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ],
              )),
        ],
      ),
      bottomNavigationBar: new Container(
          width: MediaQuery.of(context).size.width, child: companyName()),
    );
  }

  companyName() => Padding(
    padding: EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Text('Release: 14-08-2019',
            style: TextStyle( color: Colors.black45,
                fontSize: 13.0,
                fontWeight: FontWeight.bold)),
      ],
    ),
  );

  getCredential() async {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => new LoginPage()));
  }
}

class HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 300.0,
      ),
      painter: CurvePainter(),
    );
  }
}

class CurvePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(0, size.height *0.75);
    path.quadraticBezierTo(size.width* 0.10, size.height*0.70,   size.width*0.17, size.height*0.90);
    path.quadraticBezierTo(size.width*0.20, size.height, size.width*0.25, size.height*0.90);
    path.quadraticBezierTo(size.width*0.40, size.height*0.40, size.width*0.50, size.height*0.70);
    path.quadraticBezierTo(size.width*0.60, size.height*0.85, size.width*0.65, size.height*0.65);
    path.quadraticBezierTo(size.width*0.70, size.height*0.90, size.width, 0);
    path.close();

    paint.color = colorThree;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height*0.50);
    path.quadraticBezierTo(size.width*0.10, size.height*0.80, size.width*0.15, size.height*0.60);
    path.quadraticBezierTo(size.width*0.20, size.height*0.45, size.width*0.27, size.height*0.60);
    path.quadraticBezierTo(size.width*0.45, size.height, size.width*0.50, size.height*0.80);
    path.quadraticBezierTo(size.width*0.55, size.height*0.45, size.width*0.75, size.height*0.75);
    path.quadraticBezierTo(size.width*0.85, size.height*0.93, size.width, size.height*0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorTwo;
    canvas.drawPath(path, paint);

    path =Path();
    path.lineTo(0, size.height*0.75);
    path.quadraticBezierTo(size.width*0.10, size.height*0.55, size.width*0.22, size.height*0.70);
    path.quadraticBezierTo(size.width*0.30, size.height*0.90, size.width*0.40, size.height*0.75);
    path.quadraticBezierTo(size.width*0.52, size.height*0.50, size.width*0.65, size.height*0.70);
    path.quadraticBezierTo(size.width*0.75, size.height*0.85, size.width, size.height*0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorOne;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

}