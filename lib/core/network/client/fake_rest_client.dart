import 'rest_client.dart';

class FakeRestClient {
  final client = RestClient();

  initDefaultService() async{
    String baseUrl = 'https://gaur9zmbh5suepkofxbd3hujio93.requestly.me';

    client.initDioWithBaseUrl(baseUrl);

    return client;
  }
}