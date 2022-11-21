import '../../../core/network/model/response_data.dart';
import '../../../core/utils/utils_helper.dart';

/// id : 202
/// version : "3.8"
/// link : "http://mediamap.fpt.vn/mobimap/Android/MobiMap_v3.8.apk"

class CheckImeiResponse implements BaseResult<CheckImeiResponse> {

  CheckImeiResponse();

  CheckImeiResponse.fromJson(dynamic json) {
    _isInsideAccount = UtilsHelper.getJsonValue(json, ['isInsideAccount']);
    _username = UtilsHelper.getJsonValueString(json, ['username']);
    _simimei = UtilsHelper.getJsonValueString(json, ['simimei']);
    _deviceIMEI = UtilsHelper.getJsonValueString(json, ['deviceIMEI']);
    _isActive = UtilsHelper.getJsonValue(json, ['isActive']);
  }

  int? _isInsideAccount;
  String? _username;
  String? _simimei;
  String? _deviceIMEI;
  bool? _isActive;

  int get isInsideAccount => _isInsideAccount ?? 0;

  String get username => _username ?? "";

  String get simimei => _simimei ?? "";

  String get deviceIMEI => _deviceIMEI ?? "";

  bool get isActive => _isActive ?? false;

  @override
  CheckImeiResponse fromJson(json) {
    return CheckImeiResponse.fromJson(json);
  }

  @override
  String toString() {
    return 'isInsideAccount: $_isInsideAccount \n username: $_username \n simimei: $_simimei \n deviceIMEI: $_deviceIMEI \n isActive: $_isActive';
  }
}
