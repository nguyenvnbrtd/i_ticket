import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animation/core/utils/constants.dart';
import 'package:flutter_animation/core/utils/log_utils.dart';

import '../../../models/user_info.dart';

class UserInfoRepository{
  //user id
  UserInfo? userInfo;

  UserInfoRepository();

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection(Constants.USER);

  Future<void> initUser(String id) async {
    final response = await userCollection.doc(id).get(const GetOptions(source: Source.serverAndCache));
    userInfo = UserInfo.fromJson(response.data());
    LogUtils.i(message: userInfo!.toJson().toString(), tag: 'user information');
  }

  Future<void> updateUserData({required UserInfo userInfo}) async {
    await userCollection.doc(this.userInfo?.id).set(this.userInfo?.copyWith(userInfo: userInfo).toJson());
  }
}