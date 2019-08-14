import 'dart:async';
import 'package:restorder/models/drawer/drawer_response.dart';

class DrawerBloc {
  final userController = StreamController<DrawerResponse>();

  Stream<DrawerResponse> get user => userController.stream;

  DrawerBloc() {
    userData();
  }

  void userData() async {
    //var sharedPreferences = await SharedPreferences.getInstance();
    //String photoPath = sharedPreferences.getString("profile");

    userController.add(DrawerResponse(
      username: 'Flutter Tutorial',
      email: 'https://fluttertutorial.in',
      photo: null,
    ));
  }
}
