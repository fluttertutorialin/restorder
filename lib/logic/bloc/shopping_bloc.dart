import 'dart:async';
import 'package:restorder/logic/blocprovider/bloc_provider.dart';
import 'package:restorder/models/myorder/my_order_response.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingBloc implements BlocBase {
  // List of all items, part of the shopping basket
  var _shoppingCart = List<MyOrder>();

  // List of all favorite items
  List<MyOrder> _favoriteItems = List<MyOrder>();

  // Stream to list of all possible items
  BehaviorSubject<List<MyOrder>> _itemsController = BehaviorSubject<List<MyOrder>>();
  Stream<List<MyOrder>> get items => _itemsController;

  BehaviorSubject<int> _shoppingCartSizeController = BehaviorSubject<int>();
  Stream<int> get shoppingBasketSize => _shoppingCartSizeController;

  BehaviorSubject<double> _shoppingCartPriceController = BehaviorSubject<double>();
  Stream<double> get shoppingBasketTotalPrice => _shoppingCartPriceController;

  // Stream to list the items part of the shopping basket
  BehaviorSubject<List<MyOrder>> _shoppingCartController = BehaviorSubject<List<MyOrder>>();
  Stream<List<MyOrder>> get shoppingCart => _shoppingCartController;

  // Stream to list favorite items
  BehaviorSubject<List<MyOrder>> _favoriteItemsController = BehaviorSubject<List<MyOrder>>();
  Stream<List<MyOrder>> get favoriteItems => _favoriteItemsController;

  BehaviorSubject<int> _favouriteItemsSizeController = BehaviorSubject<int>();
  Stream<int> get favoriteItemsSize => _favouriteItemsSizeController;

  @override
  void dispose() {
    _itemsController?.close();
    _shoppingCartSizeController?.close();
    _shoppingCartController?.close();
    _shoppingCartPriceController?.close();
    _favoriteItemsController?.close();
    _favouriteItemsSizeController?.close();
  }

  void addToFavorites(MyOrder myOrder) {
    _favoriteItems.add(myOrder);
    _postActionOnFavorites();
  }

  void removeFromFavorites(int id) {
    _favoriteItems.removeWhere((item) => item.id == id);
    _postActionOnFavorites();
  }

  void _postActionOnFavorites() {
    _favoriteItemsController.sink.add(_favoriteItems.toList());
    _favouriteItemsSizeController.sink.add(_favoriteItems.length);
  }

  void addToShoppingBasket(MyOrder myOrder) {
    _shoppingCart.add(myOrder);
    _postActionOnCart();
  }

  void removeFromShoppingBasket(int id) {
    _shoppingCart.removeWhere((item) => item.id == id);
    _postActionOnCart();
  }

  void _postActionOnCart() {
    _shoppingCartController.sink.add(_shoppingCart.toList());
    _shoppingCartSizeController.sink.add(_shoppingCart.length);
    _computeShoppingBasketTotalPrice();
  }

  void updateToOrder(int index, int value, MyOrder myOrder)
  {
    _shoppingCart[index] = myOrder.copyWith(quantity: value);
    _postActionOnCart();
    _computeShoppingBasketTotalPrice();
  }

  void _computeShoppingBasketTotalPrice() {
    double total = 0.0;

    _shoppingCart.forEach((MyOrder myOrder) {
      total += myOrder.price * myOrder.quantity;
    });

    _shoppingCartPriceController.sink.add(total);
  }
}
