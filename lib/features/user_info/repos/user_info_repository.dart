import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animation/core/utils/constants.dart';
import 'package:flutter_animation/core/utils/log_utils.dart';

import '../../../base/models/base_repository.dart';
import '../../../models/user_info.dart';

class UserInfoRepository extends BaseRepository<UserInfo>{
  //user id
  UserInfo? userInfo;

  UserInfoRepository() : super(Constants.USER, UserInfo());

  @override
  Future<void> create(UserInfo data) async {
    await collection.doc(data.id).set(data.toJson());

    // init the id
    userInfo = data;
  }

  @override
  Future<UserInfo> getById(String id) async {
    final response = await collection.doc(id).get(const GetOptions(source: Source.serverAndCache));
    final data = response.data();
    if(data != null){
      userInfo = UserInfo.fromJson(response.data());
    }else{
      userInfo = UserInfo();
    }

    LogUtils.i(message: userInfo!.toJson().toString(), tag: 'user information');

    return userInfo!;
  }

  Future<void> updateUser({required UserInfo data}) async {
    await collection.doc(userInfo?.id).set(userInfo?.copyWith(data: data).toJson());
    await getById(userInfo?.id ?? '');
  }
}