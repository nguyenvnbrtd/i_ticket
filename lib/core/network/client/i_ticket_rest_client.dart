import 'dart:developer';
import '../../../config/env.dart';
import 'rest_client.dart';

class ITicketRestClient{
  final client = RestClient();

  Future<RestClient> initDefaultService() async {
    //need change base to env.dart
    String baseUrl = '';
    await EnvExtension.getConfig().then((value) {
      baseUrl = value.iTicketService.url;
      log('init base service: $baseUrl');
    }).catchError((err) {
      baseUrl = ENV.production.iTicketService.url;
      log('init base service error init default: $baseUrl');
    });

    client.initDioWithBaseUrl(baseUrl);

    return client;
  }
}