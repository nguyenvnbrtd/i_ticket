import 'package:flutter_animation/base/models/base_repository.dart';

import '../../../core/utils/constants.dart';
import '../models/travle_route.dart';

class TravelRouteRepository extends BaseRepository<TravelRoute>{
  TravelRouteRepository() : super(Constants.TRAVEL_ROUTE, TravelRoute());
}