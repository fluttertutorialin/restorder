import 'dart:async';
import 'package:restorder/logic/viewmodel/restaurant_view_model.dart';
import 'package:restorder/models/fetch_process.dart';
import 'package:restorder/models/login/login_response.dart';
import 'package:restorder/utils/uidata.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc {
  final loginController = StreamController<RestaurantViewModel>();

  Sink<RestaurantViewModel> get loginSink => loginController.sink;
  final loginSubject = BehaviorSubject<FetchProcess>();

  Stream<FetchProcess> get apiResult => loginSubject.stream;

  LoginBloc() {
    loginController.stream.listen(apiCall);
  }

  void apiCall(RestaurantViewModel restaurantViewModel) async {
    FetchProcess process = new FetchProcess(loadingStatus: 1); //loading
    loginSubject.add(process);

    await restaurantViewModel.getLogin(restaurantViewModel.phoneNumber, restaurantViewModel.password);
    process.type = ApiType.performLogin;

    process.loadingStatus = 2;
    process.networkServiceResponse = restaurantViewModel.apiResult;
    process.statusCode = restaurantViewModel.apiResult.responseCode;

    if (process.statusCode == UIData.resCode200) {
      LoginResponse loginResponse = process.networkServiceResponse.response;
      DateTime nowDateTime = DateTime.now();
      String patternDateTime = DateFormat('yyyy-MM-dd kk:mm a').format(nowDateTime);

      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('profile', "");

      sharedPreferences.setString('mobile', loginResponse.empMobile);
      sharedPreferences.setString('userName', loginResponse.empName);
      sharedPreferences.setInt('id', loginResponse.empId);
      sharedPreferences.setString('loginTime', patternDateTime);
    }

    loginSubject.add(process);
    restaurantViewModel = null;
  }

  void dispose() {
    loginController.close();
    loginSubject.close();
  }
}
