import 'package:restorder/services/abstract/api_service.dart';
import 'package:restorder/services/mock/mock_service.dart';
import 'package:restorder/services/network/network_service.dart';
import 'package:restorder/services/restclient.dart';

enum Flavor {Testing, Network}

class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) async {
    _flavor = flavor;
  }

  factory Injector() => _singleton;

  Injector._internal();

  APIService get otpService {
    switch (_flavor) {
      case Flavor.Testing:
        return MockService();
      default:
        return NetworkService(new RestClient());
    }
  }
}
