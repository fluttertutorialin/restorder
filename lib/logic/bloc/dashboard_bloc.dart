import 'dart:async';
import 'package:restorder/logic/blocprovider/bloc_provider.dart';
import 'package:restorder/logic/viewmodel/restaurant_view_model.dart';
import 'package:restorder/models/dashboard/dashboard_response.dart';
import 'package:restorder/models/fetch_process.dart';
import 'package:restorder/services/network_service_response.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc implements BlocBase{

  final dashboardListController = StreamController<RestaurantViewModel>();
  Sink<RestaurantViewModel> get dashboardListSink => dashboardListController.sink;
  final dashboardListBehaviorSubject = BehaviorSubject<FetchProcess>();
  Stream<FetchProcess> get dashboardListResult => dashboardListBehaviorSubject.stream;

  BehaviorSubject<String> _sortingController = BehaviorSubject<String>();
  Stream<String> get sortingName => _sortingController;

  List<DashBoardResponse> pickUpList;
  FetchProcess process;

  DashboardBloc() {
    dashboardListController.stream.listen(dashboardPickUpApi);
    listSorting('asc');
  }

  void dashboardPickUpApi(RestaurantViewModel restaurantViewModel) async {
    final FetchProcess process = new FetchProcess(loadingStatus: 1); //loading
    dashboardListBehaviorSubject.add(process);

    await restaurantViewModel.getDashboard();
    process.type = ApiType.performDashboard;

    process.loadingStatus = 2;

    process.networkServiceResponse = restaurantViewModel.apiResult;
    process.statusCode = restaurantViewModel.apiResult.responseCode;

    pickUpList = process.networkServiceResponse.response;

    dashboardListBehaviorSubject.add(process);
    restaurantViewModel = null;
  }

  void listSorting(String sortingName)
  {
    _sortingController.sink.add(sortingName);
  }

  void dispose() {
    dashboardListController.close();
    dashboardListBehaviorSubject.close();
    _sortingController.close();
  }
}
