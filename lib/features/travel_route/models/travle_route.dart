import 'package:equatable/equatable.dart';
import 'package:flutter_animation/base/models/base_model.dart';
import 'package:flutter_animation/core/utils/constants.dart';

import '../../../core/utils/utils_helper.dart';

class TravelRoute extends BaseModel<TravelRoute> {
  String? name;
  String? departureName;
  String? destinationName;
  String? departureTime;
  String? destinationTime;
  String? licensePlate;
  double? price;
  String? distance; // km
  List<String>? seats; // km

  TravelRoute({
    String? id,
    this.name,
    this.departureName,
    this.destinationName,
    this.departureTime,
    this.destinationTime,
    this.licensePlate,
    this.price,
    this.distance,
    this.seats = Constants.defaultSeats,
  }): super(id: id);

  TravelRoute.fromJson(dynamic json) {
    id = UtilsHelper.getJsonValueString(json, ['id']);
    name = UtilsHelper.getJsonValueString(json, ['name']);
    departureName = UtilsHelper.getJsonValueString(json, ['departureName']);
    destinationName = UtilsHelper.getJsonValueString(json, ['destinationName']);
    departureTime = UtilsHelper.getJsonValueString(json, ['departureTime']);
    destinationTime = UtilsHelper.getJsonValueString(json, ['destinationTime']);
    licensePlate = UtilsHelper.getJsonValueString(json, ['licensePlate']);
    price = UtilsHelper.getJsonValue(json, ['price']);
    distance = UtilsHelper.getJsonValueString(json, ['distance']);
    try{
      seats = List<String>.from(json["seats"].map((x) => x));
    }catch(e){
      seats = Constants.defaultSeats;
    }
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
      price: data?.price ?? price,
      distance: data?.distance ?? distance,
      seats: UtilsHelper.copyElementList<String>(defaultList: seats ?? Constants.defaultSeats, targetList: data?.seats ?? [], emptyValue: ''),
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
    map['price'] = price;
    map['distance'] = distance;
    map['seats'] = seats;
    return map;
  }

  @override
  List<Object?> get props => [id, name, departureName, destinationName, departureTime, destinationTime, licensePlate, price, seats];
}
