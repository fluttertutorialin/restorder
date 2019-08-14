import 'dart:async';
import 'package:restorder/logic/viewmodel/restaurant_view_model.dart';
import 'package:restorder/models/fetch_process.dart';
import 'package:rxdart/rxdart.dart';

class CategoryDetailsBloc {
  final categoryDetailsController = StreamController<RestaurantViewModel>();
  Sink<RestaurantViewModel> get categoryDetailsSink => categoryDetailsController.sink;
  final  categoryDetailsBehaviorSubject = BehaviorSubject<FetchProcess>();
  Stream<FetchProcess> get  categoryDetailsResult =>
      categoryDetailsBehaviorSubject.stream;

  CategoryDetailsBloc() {
    categoryDetailsController.stream.listen(categoryApi);
  }

  void categoryApi(RestaurantViewModel restaurantViewModel) async {
    FetchProcess process = new FetchProcess(loadingStatus: 1); //loading
    categoryDetailsBehaviorSubject.add(process);

    await restaurantViewModel.getCategoryDetails(restaurantViewModel.categoryId);
    process.type = ApiType.performCategory;

    process.loadingStatus = 2;

    process.networkServiceResponse = restaurantViewModel.apiResult;
    process.statusCode = restaurantViewModel.apiResult.responseCode;

    categoryDetailsBehaviorSubject.add(process);
    restaurantViewModel = null;
  }

  void dispose() {
    categoryDetailsController.close();
    categoryDetailsBehaviorSubject.close();
  }
}
