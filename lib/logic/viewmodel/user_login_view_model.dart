import 'dart:async';

import 'package:restorder/di/dependency_injection.dart';
import 'package:restorder/models/login/login_response.dart';
import 'package:restorder/services/abstract/api_service.dart';
import 'package:restorder/services/network_service_response.dart';
import 'package:meta/meta.dart';

class UserLoginViewModel {
  String userId, phoneNumber, password;
  NetworkServiceResponse apiResult;
  APIService apiService = new Injector().otpService;

  UserLoginViewModel.pickUp({@required this.userId});

  UserLoginViewModel.login({@required this.phoneNumber, @required this.password});

  Future<Null> getLogin(String phoneNumber, String password) async {
    NetworkServiceResponse<LoginResponse> result =
    await apiService.login(phoneNumber, password);
    this.apiResult = result;
  }
}
