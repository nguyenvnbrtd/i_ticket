import 'package:equatable/equatable.dart';

class BaseState extends Equatable {
  final bool isLoading;

  const BaseState({this.isLoading = false});

  @override
  List<Object?> get props => [isLoading];
}
