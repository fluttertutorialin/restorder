import 'package:restorder/logic/blocprovider/bloc_provider.dart';
import 'package:restorder/models/myorder/my_order_response.dart';
import 'package:rxdart/rxdart.dart';

class ProductItemBloc extends BlocBase{

  // Stream to notify if the ProductItemWidget is part of the shopping basket
  BehaviorSubject<bool> _isInShoppingCartController = BehaviorSubject<bool>();
  Stream<bool> get isInShoppingCart=> _isInShoppingCartController;

    // Stream that receives the list of all items, part of the shopping basket
  PublishSubject<List<MyOrder>> _shoppingCartController = PublishSubject<List<MyOrder>>();
  Function(List<MyOrder>) get shoppingCart=> _shoppingCartController.sink.add;

      // Stream to notify if the ProductItemWidget is part of the favorites items
  BehaviorSubject<bool> _isInFavoritesController = BehaviorSubject<bool>();
  Stream<bool> get isInFavorites=> _isInFavoritesController;

      // Stream that receives the list of favorite items
  PublishSubject<List<MyOrder>> _favoriteItemsController = PublishSubject<List<MyOrder>>();
  Function(List<MyOrder>) get favoriteItems=> _favoriteItemsController.sink.add;

  // Constructor with the 'identity' of the product
  ProductItemBloc(MyOrder product){
    // Each time a variation of the content of the shopping cart
    _shoppingCartController.stream
                          // we check if this product is part of the shopping basket
                           .map( (list){return list.any((MyOrder item)=>item.id==product.id);} )
                          // if it is part
                          .listen((isInShoppingCart)
                              // we notify the ProductWidget 
                            => _isInShoppingCartController.add(isInShoppingCart));

     // Each time a variation of the content of favorites items
    _favoriteItemsController.stream
                            .map( (list){return list.any((MyOrder item)=>item.id==product.id);} )
                            .listen((isInFavorites)
                            =>_isInFavoritesController.add(isInFavorites));
  }

  @override
  void dispose() {
    _isInShoppingCartController?.close();
    _shoppingCartController?.close();
    _favoriteItemsController?.close();
    _isInFavoritesController?.close();
  }

}