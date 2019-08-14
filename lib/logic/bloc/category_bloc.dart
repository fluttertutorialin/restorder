import 'dart:async';
import 'package:restorder/logic/viewmodel/restaurant_view_model.dart';
import 'package:restorder/models/fetch_process.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc {
  final categoryListController = StreamController<RestaurantViewModel>();
  Sink<RestaurantViewModel> get categoryListSink => categoryListController.sink;
  final categoryListBehaviorSubject = BehaviorSubject<FetchProcess>();
  Stream<FetchProcess> get categoryListResult =>
      categoryListBehaviorSubject.stream;

  CategoryBloc() {
    categoryListController.stream.listen(categoryApi);
  }

  void categoryApi(RestaurantViewModel restaurantViewModel) async {
    FetchProcess process = new FetchProcess(loadingStatus: 1); //loading
    categoryListBehaviorSubject.add(process);

    await restaurantViewModel.getCategory(restaurantViewModel.dashboardId);
    process.type = ApiType.performCategory;

    process.loadingStatus = 2;

    process.networkServiceResponse = restaurantViewModel.apiResult;
    process.statusCode = restaurantViewModel.apiResult.responseCode;

    categoryListBehaviorSubject.add(process);
    restaurantViewModel = null;
  }

  void dispose() {
    categoryListController.close();
    categoryListBehaviorSubject.close();
  }
}
