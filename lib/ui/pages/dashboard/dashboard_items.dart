import 'package:flutter/material.dart';
import 'package:restorder/models/dashboard/dashboard_response.dart';
import 'package:restorder/ui/widgets/rate_star.dart';

class DashBoardItems extends StatelessWidget {
  final DashBoardResponse dashBoardResponse;

  const DashBoardItems({Key key, this.dashBoardResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashBoardImage = new Container(
        alignment: new FractionalOffset(0.0, 0.5),
        child: new Container(
            width: 70.0,
            height: 70.0,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new AssetImage('assets/images/fastfood.jpg'),
                ))));

    final dashboardData = new Container(
      margin: const EdgeInsets.only(left: 30.0, right: 0.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              color: Colors.orange.withOpacity(.2),
              offset: Offset(0, 4),
            )
          ]),
      child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 50.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(dashBoardResponse.title.toUpperCase(),
                style: new TextStyle(fontSize: 15.0, color: Colors.black)),
            new Container(
                color: Colors.black,
                width: 24.0,
                height: 1.0,
                margin: const EdgeInsets.symmetric(vertical: 1.0)),
            new Container(
                margin: const EdgeInsets.only(top: 10),
                child: StarRating(
                  rating: dashBoardResponse.ratting,
                  onRatingChanged: (double rate) {
                    print(rate);
                  },
                )),
            new Container(
                margin: const EdgeInsets.only(top: 2),
                child: Text(
                    'Total Items: ${dashBoardResponse.totalItems}',
                    style: new TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54.withOpacity(0.5)))),
          ],
        ),
      ),
    );

    return new Container(
        height: 100.0,
        margin: const EdgeInsets.all(8.0),
        child: new Stack(children: <Widget>[

          dashboardData,
          dashBoardImage,
        ]));
  }
}
