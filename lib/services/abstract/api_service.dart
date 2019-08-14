import 'dart:async';

import 'package:restorder/models/category/category_details_response.dart';
import 'package:restorder/models/category/category_response.dart';
import 'package:restorder/models/dashboard/dashboard_response.dart';
import 'package:restorder/models/login/login_response.dart';

import '../network_service_response.dart';

abstract class APIService {
  Future<NetworkServiceResponse<LoginResponse>> login(String phoneNumber, String password);

  Future<NetworkServiceResponse<List<DashBoardResponse>>> dashboard();

  Future<NetworkServiceResponse<List<CategoryResponse>>> category(num dashboardId);

  Future<NetworkServiceResponse<List<CategoryDetailsResponse>>> categoryDetails(num categoryId);
 }
