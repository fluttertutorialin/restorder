import 'package:flutter/material.dart';

class Quantity extends StatelessWidget {
  const Quantity({this.quantity, this.increment, this.decrement});

  final int quantity;
  final VoidCallback increment;
  final VoidCallback decrement;

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Container(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
          new Container(
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                new Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 16,
                          color: Colors.black.withOpacity(.2),
                          offset: Offset(0, 4),
                        )
                      ]),
                  child: Container(
                      child: InkWell(
                          onTap: () {
                            quantity == 1 ? null  : decrement();
                          },
                          child: SizedBox(
                              width: 35.0,
                              height: 35.0,
                              child: new Center(
                                child: new Text('-',
                                    style: new TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                    textAlign: TextAlign.center),
                              )))),
                ),
                new Container(
                  child: new SizedBox(
                    width: 30.0,
                    child: new Center(
                        child: new Text('$quantity',
                            style: new TextStyle(
                                fontSize: 15.0, color: Colors.black54),
                            textAlign: TextAlign.center)),
                  ),
                ),
                new Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 16,
                          color: Colors.black.withOpacity(.2),
                          offset: Offset(0, 4),
                        )
                      ]),
                  child: Container(
                      child: InkWell(
                          onTap: () {
                            increment();
                          },
                          child: SizedBox(
                              width: 35.0,
                              height: 35.0,
                              child: new Center(
                                child: new Text('+',
                                    style: new TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                    textAlign: TextAlign.center),
                              )))),
                )
              ]))
        ])));
  }
}
