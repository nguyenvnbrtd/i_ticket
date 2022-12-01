import 'package:equatable/equatable.dart';

abstract class BaseModel<T> extends Equatable{
  const BaseModel();

  T fromJson(json);

  T init();

  Map<String, dynamic> toJson();

  T copyWith({T? data});

  @override
  List<Object?> get props;
}