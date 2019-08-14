import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restorder/logic/bloc/category_details_bloc.dart';
import 'package:restorder/logic/bloc/product_item_bloc.dart';
import 'package:restorder/logic/bloc/shopping_bloc.dart';
import 'package:restorder/logic/blocprovider/bloc_provider.dart';
import 'package:restorder/logic/viewmodel/restaurant_view_model.dart';
import 'package:restorder/models/category/category_details_response.dart';
import 'package:restorder/models/category/category_response.dart';
import 'package:restorder/models/fetch_process.dart';
import 'package:restorder/models/myorder/my_order_response.dart';
import 'package:restorder/services/network/api_subscription.dart';
import 'package:restorder/ui/widgets/carousel.dart';
import 'package:restorder/ui/widgets/common_scaffold.dart';
import 'package:restorder/utils/uidata.dart';

class CategoryDetailsPage extends StatefulWidget {
  final CategoryResponse categoryResponse;

  CategoryDetailsPage({Key key, @required this.categoryResponse})
      : super(key: key);

  @override
  CategoryDetailsState createState() {
    return new CategoryDetailsState();
  }
}

class CategoryDetailsState extends State<CategoryDetailsPage> {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  final CategoryDetailsBloc categoryDetailsBloc = CategoryDetailsBloc();
  StreamSubscription subscription;
  StreamSubscription favouriteSubscription;
  ProductItemBloc bloc;
  ShoppingBloc shoppingBloc;

  MyOrder myOrder;

  List<String> _images = [
    UIData.imageSlider,
    UIData.imageSlider,
    UIData.imageSlider,
    UIData.imageSlider,
  ];

  @override
  void initState() {
    super.initState();

    myOrder = new MyOrder(
        id: widget.categoryResponse.id,
        name: widget.categoryResponse.title,
        picture: '',
        description: '',
        price: widget.categoryResponse.indiaPrice);

    apiSubscription(categoryDetailsBloc.categoryDetailsResult, context);
    categoryDetailsBloc.categoryDetailsSink.add(
        RestaurantViewModel.category(categoryId: widget.categoryResponse.id));
    apiSubscription(categoryDetailsBloc.categoryDetailsResult, context);

    _initBloc();
  }

  @override
  void didUpdateWidget(CategoryDetailsPage oldWidget) {
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
    bloc = ProductItemBloc(myOrder);
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

  _bodyData() {
    return ListView(physics: BouncingScrollPhysics(), children: <Widget>[
      Column(children: <Widget>[
        new Container(
            margin: EdgeInsets.only(top: 1),
            height: 200.0,
            child: Carousel(
              autoPlay: false,
              dotSize: 10.0,
              showIndicators: true,
              children: _images.map((item) {
                return Image.asset(
                  item,
                  fit: BoxFit.cover,
                );
              }).toList(),
            )),
        StreamBuilder<FetchProcess>(
            stream: categoryDetailsBloc.categoryDetailsResult,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? snapshot.data.statusCode == UIData.resCode200
                      ? _bodyList(snapshot.data.networkServiceResponse.response)
                      : Container()
                  : CircularProgressIndicator();
            })
      ])
    ]);
  }

  _bodyList(List<CategoryDetailsResponse> dashBoardResponseList) {
    return new ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: dashBoardResponseList.map((value) {
        CategoryDetailsResponse categoryDetailsResponse = value;
        return Column(children: <Widget>[
          Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      color: Colors.orange.withOpacity(.2),
                      offset: Offset(0, 4),
                    )
                  ]),
              child: new Container(
                  margin: const EdgeInsets.all(15),
                  child: new Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Align(
                            alignment: Alignment.topRight,
                            child: Column(children: <Widget>[
                              Text(
                                  '\u20B9 ${widget.categoryResponse.indiaPrice}',
                                  style: new TextStyle(
                                      fontSize: 15.0, color: Colors.black)),
                              Text(
                                  'Ratting: ${widget.categoryResponse.ratting}',
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black54.withOpacity(0.5)))
                            ])),
                        new Text('Detail',
                            style: new TextStyle(
                                fontSize: 16.0, color: Colors.black54)),
                        new Container(
                            color: Colors.black54,
                            width: 24.0,
                            height: 1.0,
                            margin: const EdgeInsets.symmetric(vertical: 1.0)),
                        new Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                '${categoryDetailsResponse.description}',
                                style: new TextStyle(
                                    fontSize: 14.0, color: Colors.black87))),
                        new Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    _favourite(),
                                    Text('Like',
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey)),
                                  ]),
                                  Row(children: <Widget>[
                                    Icon(
                                      Icons.comment,
                                      color: Color(0xFFFFCC80),
                                    ),
                                    Text('Comment',
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey)),
                                  ])
                                ]))
                      ])))
        ]);
      }).toList(),
    );
  }

  _favourite() {
    return StreamBuilder<bool>(
        stream: bloc.isInFavorites,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.data ? _removeFavourite() : _addFavourite();
        });
  }

  _addFavourite() {
    return InkWell(
      onTap: () {
        shoppingBloc.addToFavorites(myOrder);
      },
      child: Icon(Icons.favorite_border, color: Color(0xFFFFCC80)),
    );
  }

  _removeFavourite() {
    return InkWell(
        onTap: () {
          shoppingBloc.removeFromFavorites(myOrder.id);
        },
        child: Icon(Icons.favorite, color: Colors.orange));
  }

  _shoppingManage() => BottomAppBar(
      clipBehavior: Clip.antiAlias,
      shape: CircularNotchedRectangle(),
      child: Ink(
          height: 50.0,
          decoration: new BoxDecoration(
              gradient: new LinearGradient(colors: UIData.kitGradients)),
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: double.infinity,
                    child: new InkWell(
                        radius: 15.0,
                        splashColor: Colors.white,
                        onTap: () {},
                        child: Center(
                            child: StreamBuilder(
                                stream: shoppingBloc.shoppingBasketTotalPrice,
                                initialData: 0.0,
                                builder: (BuildContext context,
                                    AsyncSnapshot<double> snapshot) {
                                  return Text(
                                    'Total: ${snapshot.data}',
                                    style: new TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey),
                                  );
                                })))),
                new SizedBox(
                  width: 20.0,
                ),
                SizedBox(
                    height: double.infinity,
                    child: new InkWell(
                        onTap: () async {},
                        radius: 15.0,
                        splashColor: Colors.white,
                        child: Center(child: _addToCart())))
              ])));

  _addToCart() {
    return StreamBuilder<bool>(
        stream: bloc.isInShoppingCart,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.data
              ? _removeFromShoppingBasket()
              : _addToShoppingBasket();
        });
  }

  _addToShoppingBasket() {
    return InkWell(
        onTap: () {
          shoppingBloc.addToShoppingBasket(new MyOrder(
              id: myOrder.id,
              name: myOrder.name,
              picture: myOrder.picture,
              price: myOrder.price,
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
          shoppingBloc.removeFromShoppingBasket(myOrder.id);
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

  @override
  build(BuildContext context) {
    return CommonScaffold(
      actionFirstIcon: null,
      appTitle: widget.categoryResponse.title.toUpperCase(),
      showDrawer: false,
      scaffoldKey: _scaffoldState,
      showBottomNav: true,
      centerDocked: true,
      showFAB: true,
      bottomBar: _shoppingManage(),
      bodyData: _bodyData(),
    );
  }
}
