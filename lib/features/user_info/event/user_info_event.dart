import 'package:flutter_animation/base/blocs/base_event.dart';

import '../../../models/user_info.dart';

abstract class UserInfoEvent extends BaseEvent{}

class OnInitData extends UserInfoEvent{
  final UserInfo userInfo;

  OnInitData({required this.userInfo});

  @override
  List<Object?> get props => [userInfo];
}

class OnSavePress extends UserInfoEvent{
  final UserInfo userInfo;

  OnSavePress({required this.userInfo});

  @override
  List<Object?> get props => [userInfo];
}