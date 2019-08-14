import 'package:flutter/material.dart';
import 'package:restorder/logic/bloc/shopping_bloc.dart';
import 'package:restorder/logic/blocprovider/bloc_provider.dart';

import 'badge_icon.dart';

class BasketIcon extends StatefulWidget{
  
  final VoidCallback onCartPressed;
  BasketIcon(this.onCartPressed);

  @override
  BasketIconState createState() => new BasketIconState();
}

class BasketIconState extends State<BasketIcon> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    ShoppingBloc bloc = BlocProvider.of<ShoppingBloc>(context);
    return new StreamBuilder(
      stream: bloc.shoppingBasketSize,
      initialData: 0,
      builder: (context, snapshot) {
        return new IconButton(
          icon: new Badge.left(
            child: new Icon(Icons.shopping_cart, color: Colors.black54),
            value: snapshot.data.toString(),
          ),
          onPressed: () => widget.onCartPressed(),
        );
      },
    );
  }

}
