import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restorder/logic/bloc/product_item_bloc.dart';
import 'package:restorder/logic/bloc/shopping_bloc.dart';
import 'package:restorder/logic/blocprovider/bloc_provider.dart';
import 'package:restorder/models/myorder/my_order_response.dart';
import 'package:restorder/ui/pages/order/quantity.dart';

class MyOrderItems extends StatefulWidget {
  MyOrderItems({
    Key key,
    @required this.myOrder,
    this.position,
  }) : super(key: key);

  final MyOrder myOrder;
  final int position;

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrderItems> with TickerProviderStateMixin {
  StreamSubscription subscription;
  StreamSubscription favouriteSubscription;
  ProductItemBloc bloc;
  ShoppingBloc shoppingBloc;
  int counter;
  AnimationController controller;
  Animation animation;

  initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) {
      // if (status == AnimationStatus.completed) {
      //   controller.reverse();
      // } else if (status == AnimationStatus.dismissed) {
      //   controller.forward();
      // }
    });

    controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initBloc();
  }

  @override
  void didUpdateWidget(MyOrderItems oldWidget) {
    super.didUpdateWidget(oldWidget);
    /*if(oldWidget.myOrder != widget.myOrder){
      controller.reverse();
    }*/
    _disposeBloc();
    _initBloc();
  }

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  void _initBloc() {
    bloc = ProductItemBloc(widget.myOrder);
    shoppingBloc = BlocProvider.of<ShoppingBloc>(context);
    subscription = shoppingBloc.shoppingCart.listen(bloc.shoppingCart);
    favouriteSubscription =
        shoppingBloc.favoriteItems.listen(bloc.favoriteItems);
  }

  void _disposeBloc() {
    subscription?.cancel();
    favouriteSubscription?.cancel();
    bloc?.dispose();
  }

  Widget _addToCart() {
    return StreamBuilder<bool>(
      stream: bloc.isInShoppingCart,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return snapshot.data
            ? _removeFromShoppingBasket()
            : _addToShoppingBasket();
      },
    );
  }

  Widget _addToShoppingBasket() {
    return InkWell(
      onTap: () {
        shoppingBloc.addToShoppingBasket(widget.myOrder);
      },
      child: Row(children: <Widget>[
        Icon(
          Icons.delete_outline,
          color: Color(0xFFEF9A9A),
        ),
        Text('Delete',
            style: new TextStyle(fontSize: 12.0, color: Color(0xFFE57373))),
      ]),
    );
  }

  Widget _removeFromShoppingBasket() {
    return InkWell(
      onTap: () {
        shoppingBloc.removeFromShoppingBasket(widget.myOrder.id);
      },
      child: Row(children: <Widget>[
        Icon(
          Icons.delete_outline,
          color: Color(0xFFEF9A9A),
        ),
        Text('Delete',
            style: new TextStyle(fontSize: 12.0, color: Color(0xFFE57373))),
      ]),
    );
  }

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
                  new Text('${widget.myOrder.name}',
                      style:
                          new TextStyle(fontSize: 15.0, color: Colors.black)),
                  new Container(
                      color: Colors.black,
                      width: 24.0,
                      height: 1.0,
                      margin: const EdgeInsets.symmetric(vertical: 1.0)),
                  new Container(
                      margin: const EdgeInsets.only(top: 2, right: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text('Weight',
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54.withOpacity(0.5))),
                            Text('\u20B9 ${widget.myOrder.price}',
                                style: new TextStyle(
                                    fontSize: 12.0, color: Colors.orangeAccent))
                          ])),
                  new Container(
                      margin: const EdgeInsets.only(top: 5, right: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _addToCart(),
                            Quantity(
                              quantity: widget.myOrder.quantity,
                              increment: () {
                                counter = widget.myOrder.quantity + 1;

                                shoppingBloc.updateToOrder(
                                    widget.position, counter, widget.myOrder);
                              },
                              decrement: () {
                                counter = widget.myOrder.quantity - 1;

                                shoppingBloc.updateToOrder(
                                    widget.position, counter, widget.myOrder);
                              },
                            ),
                          ]))
                ])));

    return new SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
      child:Container(
        height: 100.0,
        margin: EdgeInsets.all(8.0),
        child: new Stack(children: <Widget>[
          dashboardData,
          dashBoardImage,
        ])));
  }
}
