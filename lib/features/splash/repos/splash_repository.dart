import '../../../core/network/client/i_ticket_rest_client.dart';
import '../../../core/network/json_base_mapping.dart';
import '../../../injector.dart';

class SplashRepository with JsonBaseMapping {
  final ITicketRestClient apiProvider = it();

}