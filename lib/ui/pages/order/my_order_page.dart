import 'package:flutter/material.dart';
import 'package:restorder/logic/bloc/shopping_bloc.dart';
import 'package:restorder/logic/blocprovider/bloc_provider.dart';
import 'package:restorder/models/myorder/my_order_response.dart';
import 'package:restorder/ui/widgets/common_scaffold.dart';
import 'package:restorder/utils/translations.dart';
import 'package:restorder/utils/uidata.dart';

import 'my_order_items.dart';

class MyOrderPage extends StatefulWidget {
  @override
  MyOrderWidgetState createState() {
    return new MyOrderWidgetState();
  }
}

class MyOrderWidgetState extends State<MyOrderPage> {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  ShoppingBloc _shoppingBloc;

  @override
  void initState() {
    super.initState();

    _shoppingBloc = BlocProvider.of<ShoppingBloc>(context);
  }

  _bodyData() {
    return ListView(physics: BouncingScrollPhysics(), children: <Widget>[
      Column(children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          StreamBuilder(
              stream: _shoppingBloc.shoppingCart,
              builder: (context, AsyncSnapshot<List<MyOrder>> snapshot) {
                return snapshot.hasData
                    ? _bodyList(snapshot.data)
                    : Container();
              })
        ])
      ])
    ]);
  }

  _bodyList(List<MyOrder> myOrderList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: myOrderList.length,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, position) {
          return MyOrderItems(
              myOrder: myOrderList[position], position: position);
        });
  }

  _checkOut() => Container(
      padding: EdgeInsets.only(left: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
          Widget>[
        StreamBuilder(
            stream: _shoppingBloc.shoppingBasketTotalPrice,
            initialData: 0.0,
            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
              return Text(
                'Total: ${snapshot.data}',
                style: new TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              );
            }),
        Container(
            height: 35,
            width: 150,
            padding: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: UIData.drawerArrowGradients,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(left: 10)),
                  Text("Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ))
                ]))
      ]));

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: Translations.of(context).text("drawer_my_order").toUpperCase(),
      showDrawer: false,
      scaffoldKey: _scaffoldState,
      bodyData: _bodyData(),
      bottomBar: _checkOut(),
      showBottomNav: true,
    );
  }
}
