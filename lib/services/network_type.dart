import 'package:restorder/services/restclient.dart';

abstract class NetworkType {
  RestClient rest;
  NetworkType(this.rest);
}
