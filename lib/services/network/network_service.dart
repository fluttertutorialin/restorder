import 'dart:async';
import 'dart:convert';
import 'package:restorder/models/category/category_details_response.dart';
import 'package:restorder/models/category/category_response.dart';
import 'package:restorder/models/dashboard/dashboard_response.dart';
import 'package:restorder/models/login/login_response.dart';
import 'package:restorder/services/abstract/api_service.dart';
import 'package:restorder/services/network_type.dart';
import 'package:restorder/services/network_service_response.dart';
import 'package:restorder/services/restclient.dart';

class NetworkService extends NetworkType implements APIService {
  static final _baseUrl = '';
  final _loginUrl = _baseUrl + '//';

  Map<String, String> headers = {
    "Content-Type": 'application/json',
    "AUTH_KEY": '',
  };

  NetworkService(RestClient rest) : super(rest);

  @override
  Future<NetworkServiceResponse<LoginResponse>> login(String phoneNumber,
      String password) async {
    var result = await rest.get<LoginResponse>(
        '$_loginUrl?MobileNo=$phoneNumber&Password=$password&DeviceId=""',
        headers);
    if (result.mappedResult != null) {
      var res = LoginResponse.fromJson(json.decode(result.mappedResult));
      return new NetworkServiceResponse(
        response: res,
        responseCode: result.networkServiceResponse.responseCode,
        message: result.networkServiceResponse.message,
      );
    }
    return new NetworkServiceResponse(
        responseCode: result.networkServiceResponse.responseCode,
        message: result.networkServiceResponse.message);
  }

  @override
  Future<NetworkServiceResponse<List<DashBoardResponse>>> dashboard() async {
    return null;
  }

  @override
  Future<NetworkServiceResponse<List<CategoryResponse>>> category(num dashboardId) {
    return null;
  }

  @override
  Future<NetworkServiceResponse<List<CategoryDetailsResponse>>> categoryDetails(num categoryId) {
    // TODO: implement categoryDetails
    return null;
  }

}
