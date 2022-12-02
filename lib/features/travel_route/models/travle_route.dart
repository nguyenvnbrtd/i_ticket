import 'package:equatable/equatable.dart';
import 'package:flutter_animation/base/models/base_model.dart';

import '../../../core/utils/utils_helper.dart';

class TravelRoute extends BaseModel<TravelRoute> {
  String? name;
  String? departureName;
  String? destinationName;
  String? departureTime;
  String? destinationTime;
  String? licensePlate;
  String? distance; // km

  TravelRoute({
    String? id,
    this.name,
    this.departureName,
    this.destinationName,
    this.departureTime,
    this.destinationTime,
    this.licensePlate,
    this.distance,
  }): super(id: id);

  TravelRoute.fromJson(dynamic json) {
    id = UtilsHelper.getJsonValueString(json, ['id']);
    name = UtilsHelper.getJsonValueString(json, ['name']);
    departureName = UtilsHelper.getJsonValueString(json, ['departureName']);
    destinationName = UtilsHelper.getJsonValueString(json, ['destinationName']);
    departureTime = UtilsHelper.getJsonValueString(json, ['departureTime']);
    destinationTime = UtilsHelper.getJsonValueString(json, ['destinationTime']);
    licensePlate = UtilsHelper.getJsonValueString(json, ['licensePlate']);
    distance = UtilsHelper.getJsonValueString(json, ['distance']);
  }

  @override
  TravelRoute fromJson(dynamic json) {
    return TravelRoute.fromJson(json);
  }

  @override
  TravelRoute init() {
    return TravelRoute();
  }

  @override
  TravelRoute copyWith({TravelRoute? data}) {
    return TravelRoute(
      id: data?.id ?? id,
      name: data?.name ?? name,
      departureName: data?.departureName ?? departureName,
      destinationName: data?.destinationName ?? destinationName,
      departureTime: data?.departureTime ?? departureTime,
      destinationTime: data?.destinationTime ?? destinationTime,
      licensePlate: data?.licensePlate ?? licensePlate,
      distance: data?.distance ?? distance,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['departureName'] = departureName;
    map['destinationName'] = destinationName;
    map['departureTime'] = departureTime;
    map['destinationTime'] = destinationTime;
    map['licensePlate'] = licensePlate;
    map['distance'] = distance;
    return map;
  }

  @override
  List<Object?> get props => [id, name, departureName, destinationName, departureTime, destinationTime, licensePlate];
}
