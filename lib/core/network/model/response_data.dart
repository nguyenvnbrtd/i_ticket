
import '../../utils/utils_helper.dart';

/// ResponseResult : {"ErrorCode":0,"Message":null,"Result":""}

class ResponseData {
  late ResponseResult _responseResult;

  ResponseData.fromJson(dynamic json, BaseResult target) {
    _responseResult = ResponseResult.fromJson(UtilsHelper.getJsonValue(json, ["ResponseResult", "responseResult, Result"]) ?? json, target);
  }

  ResponseResult get responseResult => _responseResult;
}

class ResponseListItemData<T> {
  late T _result;

  ResponseListItemData.fromJson(dynamic json, BaseResult target) {
    _result = target.fromJson(json);
  }

  T get result => _result;
}

/// ErrorCode : 0
/// Message : null
/// Result : T

class ResponseResult<T> {

  int errorCode = -1;
  String message = "";
  T? result;

  ResponseResult({
    required this.errorCode,
    required this.message,
    required this.result,
  });

  ResponseResult.fromJson(dynamic json, BaseResult target) {
    var jsonErrorCode = UtilsHelper.getJsonValueString(json, ["ErrorCode"]);
    errorCode = int.parse(UtilsHelper.isNumeric(jsonErrorCode) ? jsonErrorCode : "-1");
    message = UtilsHelper.getJsonValueString(json, ["Message"]);
    var resultRaw = UtilsHelper.getJsonValue(json, ["Result", "Results"]);
    if(resultRaw == null){
      return;
    }
    result = target.fromJson(resultRaw);
  }

  bool hasError() {
    return errorCode != 0;
  }
}


abstract class BaseResult<T> {
  T fromJson(json);
}
