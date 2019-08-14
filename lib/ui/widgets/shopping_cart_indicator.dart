import 'package:flutter/material.dart';
import 'package:restorder/utils/uidata.dart';

Widget shoppingCartIndicator(BuildContext context) {
  return new Padding(
      padding: const EdgeInsets.all(0.0),
      child: new Container(
        child: new GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, UIData.orderRoute);
          },
          child: new Stack(
            children: <Widget>[
              new IconButton(
                iconSize: 25,
                icon: new Icon(
                  Icons.shopping_cart,
                  color: Colors.black45,
                ),
                onPressed: null,
              ),
              new Positioned(
                top: 1,
                child: new Stack(
                  children: <Widget>[
                    new Icon(Icons.brightness_1,
                        size: 22.0, color: Colors.orange),
                    new Positioned(
                        top: 5.0,
                        right: 4.0,
                        child: new Center(
                          child: new Text(
                            '00',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
}
