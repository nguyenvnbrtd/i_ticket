import 'package:flutter_animation/base/models/base_model.dart';
import '../core/utils/utils_helper.dart';

class UserInfo extends BaseModel<UserInfo> {
  String? role;
  String? email;
  String? avatar;
  String? name;
  String? phone;
  String? address;
  bool? acceptTerms;

  UserInfo({String? id, this.role, this.email, this.avatar, this.name, this.phone, this.address, this.acceptTerms}) : super(id: id);

  UserInfo.fromJson(dynamic json) {
    id = UtilsHelper.getJsonValueString(json, ['id']);
    role = UtilsHelper.getJsonValueString(json, ['role']);
    email = UtilsHelper.getJsonValueString(json, ['email']);
    avatar = UtilsHelper.getJsonValueString(json, ['avatar']);
    name = UtilsHelper.getJsonValueString(json, ['name']);
    phone = UtilsHelper.getJsonValueString(json, ['phone']);
    address = UtilsHelper.getJsonValueString(json, ['address']);
    acceptTerms = UtilsHelper.getJsonValue(json, ['acceptTerms']) ?? false;
  }

  @override
  UserInfo fromJson(json) {
    return UserInfo.fromJson(json);
  }

  @override
  UserInfo init() {
    return UserInfo();
  }

  @override
  UserInfo copyWith({UserInfo? data}) {
    return UserInfo(
      id: data?.id ?? id,
      name: data?.name ?? name,
      phone: data?.phone ?? phone,
      email: data?.email ?? email,
      address: data?.address ?? address,
      role: data?.role ?? role,
      avatar: data?.avatar ?? avatar,
      acceptTerms: data?.acceptTerms ?? acceptTerms,
    );
  }

  @override
  Map<String, dynamic> toJson(){
    Map<String, dynamic> map ={};
    map['id'] = id;
    map['role'] = role;
    map['email'] = email;
    map['avatar'] = avatar;
    map['name'] = name;
    map['phone'] = phone;
    map['address'] = address;
    map['acceptTerms'] = acceptTerms;
    return map;
  }

  @override
  List<Object?> get props => [id, role, email, avatar, name, phone, address, acceptTerms];
}