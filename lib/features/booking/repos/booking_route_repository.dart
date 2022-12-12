import 'package:flutter_animation/base/models/base_repository.dart';

import '../../../core/utils/constants.dart';
import '../models/booking_detail.dart';

class BookingRouteRepository extends BaseRepository<BookingDetail>{
  BookingRouteRepository() : super(Constants.BOOKING_DETAIL, BookingDetail());

  Stream<List<BookingDetail>> getAllWithUserId (String uid) {
    return collection.snapshots().map(convert).map((item) => item.where((element) => element.userId == uid).toList());
  }

  @override
  int sort(BookingDetail a, BookingDetail b) => b.updateTime?.compareTo(a.updateTime ?? '') ?? 0;
}