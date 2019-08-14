import 'dart:async';

import 'package:restorder/di/dependency_injection.dart';
import 'package:restorder/models/category/category_details_response.dart';
import 'package:restorder/models/category/category_response.dart';
import 'package:restorder/models/dashboard/dashboard_response.dart';
import 'package:restorder/models/login/login_response.dart';
import 'package:restorder/services/abstract/api_service.dart';
import 'package:restorder/services/network_service_response.dart';
import 'package:meta/meta.dart';

class RestaurantViewModel {
  int dashboardId, categoryId;
  String phoneNumber, password;

  NetworkServiceResponse apiResult;
  APIService apiService = new Injector().otpService;

  RestaurantViewModel.delivery();

  RestaurantViewModel.dashboard({this.dashboardId});
  RestaurantViewModel.category({this.categoryId});
  RestaurantViewModel.login({@required this.phoneNumber, @required this.password});

  Future<Null> getLogin(String phoneNumber, String password) async {
    NetworkServiceResponse<LoginResponse> result =
    await apiService.login(phoneNumber, password);
    this.apiResult = result;
  }

  Future<Null> getDashboard() async {
    NetworkServiceResponse<List<DashBoardResponse>> result =
    await apiService.dashboard();
    this.apiResult = result;
  }

  Future<Null> getCategory(num dashboardId) async {
    NetworkServiceResponse<List<CategoryResponse>> result =
    await apiService.category(dashboardId);
    this.apiResult = result;
  }

  Future<Null> getCategoryDetails(num categoryId) async {
    NetworkServiceResponse<List<CategoryDetailsResponse>> result =
    await apiService.categoryDetails(categoryId);
    this.apiResult = result;
  }
}
