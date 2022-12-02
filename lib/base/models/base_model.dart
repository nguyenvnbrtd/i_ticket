import 'package:equatable/equatable.dart';

abstract class BaseModel<T> extends Equatable{
  String? id;

  BaseModel({this.id});

  T fromJson(dynamic json);

  T init();

  Map<String, dynamic> toJson();

  T copyWith({T? data});

  @override
  List<Object?> get props;
}