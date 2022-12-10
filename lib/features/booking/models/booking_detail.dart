import 'package:flutter_animation/base/models/base_model.dart';

import '../../../core/utils/utils_helper.dart';

class BookingDetail extends BaseModel<BookingDetail> {
  String? userId;
  String? routeId;
  String? createTime;
  String? updateTime;
  bool? isPayed;

  BookingDetail({
    String? id,
    this.userId,
    this.routeId,
    this.createTime,
    this.updateTime,
    this.isPayed = false,
  }): super(id: id);

  BookingDetail.fromJson(dynamic json) {
    id = UtilsHelper.getJsonValueString(json, ['id']);
    userId = UtilsHelper.getJsonValueString(json, ['userId']);
    routeId = UtilsHelper.getJsonValueString(json, ['routeId']);
    createTime = UtilsHelper.getJsonValueString(json, ['createTime']);
    updateTime = UtilsHelper.getJsonValueString(json, ['updateTime']);
    isPayed = UtilsHelper.getJsonValue(json, ['isPayed']) ?? false;
  }

  @override
  BookingDetail fromJson(dynamic json) {
    return BookingDetail.fromJson(json);
  }

  @override
  BookingDetail init() {
    return BookingDetail();
  }

  @override
  BookingDetail copyWith({BookingDetail? data}) {
    return BookingDetail(
      id: data?.id ?? id,
      userId: data?.userId ?? userId,
      routeId: data?.routeId ?? routeId,
      createTime: data?.createTime ?? createTime,
      updateTime: data?.updateTime ?? updateTime,
      isPayed: data?.isPayed ?? isPayed,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['userId'] = userId;
    map['routeId'] = routeId;
    map['createTime'] = createTime;
    map['updateTime'] = updateTime;
    map['isPayed'] = isPayed;
    return map;
  }

  @override
  List<Object?> get props => [id, userId, routeId, createTime, updateTime, isPayed];
}
