import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restorder/logic/bloc/product_item_bloc.dart';
import 'package:restorder/logic/bloc/shopping_bloc.dart';
import 'package:restorder/logic/blocprovider/bloc_provider.dart';
import 'package:restorder/models/category/category_response.dart';
import 'package:restorder/models/myorder/my_order_response.dart';
import 'package:restorder/ui/pages/categorydetail/category_details_page.dart';

class FavouriteItems extends StatefulWidget {
  FavouriteItems({
    Key key,
    @required this.myOrder,
  }) : super(key: key);

  final MyOrder myOrder;

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<FavouriteItems> {
  StreamSubscription subscription;
  StreamSubscription favouriteSubscription;
  ProductItemBloc bloc;
  ShoppingBloc shoppingBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initBloc();
  }

  @override
  void didUpdateWidget(FavouriteItems oldWidget) {
    super.didUpdateWidget(oldWidget);
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

  _addToShoppingBasket() {
    return InkWell(
        onTap: () {
          shoppingBloc.addToShoppingBasket(new MyOrder(
              id: widget.myOrder.id,
              name: widget.myOrder.name,
              picture: widget.myOrder.picture,
              price: widget.myOrder.price,
              quantity: 1));
        },
        child: Row(children: <Widget>[
          Icon(
            Icons.add_shopping_cart,
            color: Color(0xFFA5D6A7),
          ),
          Text('Order',
              style: new TextStyle(fontSize: 14.0, color: Color(0xFF66BB6A))),
        ]));
  }

  _removeFromShoppingBasket() {
    return InkWell(
        onTap: () {
          shoppingBloc.removeFromShoppingBasket(widget.myOrder.id);
        },
        child: Row(children: <Widget>[
          Icon(
            Icons.add_shopping_cart,
            color: Color(0xFFEF9A9A),
          ),
          Text('Delete',
              style: new TextStyle(fontSize: 14.0, color: Color(0xFFE57373))),
        ]));
  }

  Widget _favourite() {
    return StreamBuilder<bool>(
      stream: bloc.isInFavorites,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return snapshot.data ? _removeFavourite() : _addFavourite();
      },
    );
  }

  Widget _addFavourite() {
    return InkWell(
      onTap: () {
        shoppingBloc.addToFavorites(widget.myOrder);
      },
      child: Icon(Icons.favorite_border, color: Color(0xFFFFCC80)),
    );
  }

  Widget _removeFavourite() {
    return InkWell(
      onTap: () {
        shoppingBloc.removeFromFavorites(widget.myOrder.id);
      },
      child: Icon(Icons.favorite, color: Color(0xFFFFCC80)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dashBoardImage = Container(
        alignment: new FractionalOffset(0.0, 0.5),
        child: InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new CategoryDetailsPage(
                    categoryResponse: new CategoryResponse(
                        id: widget.myOrder.id,
                        title: widget.myOrder.name,
                        indiaPrice: widget.myOrder.price,
                        ratting: 0)))),
            child: new Container(
                width: 70.0,
                height: 70.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/images/fastfood.jpg'),
                    )))));

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
                            Row(children: <Widget>[
                              _favourite(),
                              Text('Like',
                                  style: new TextStyle(
                                      fontSize: 15.0, color: Colors.grey))
                            ]),
                            _addToCart(),
                          ]))
                ])));

    return new Container(
        height: 100.0,
        margin: const EdgeInsets.all(8.0),
        child: new Stack(children: <Widget>[
          dashboardData,
          dashBoardImage,
        ]));
  }
}
