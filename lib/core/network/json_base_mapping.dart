import '../../models/list_response_model.dart';
import '../exception/data_parser_exception.dart';
import '../utils/utils_helper.dart';
import 'model/response_data.dart';

mixin JsonBaseMapping {
  T map<T extends BaseResult>(Map<String, dynamic> json, T target) {
    try {
      if (UtilsHelper.hasJsonKey(json, "ResponseResult") || UtilsHelper.hasJsonKey(json, "Result")) {
        ResponseData responseData = ResponseData.fromJson(json, target);
        if (!responseData.responseResult.hasError()) {
          T? result = responseData.responseResult.result;
          if (result == null) {
            throw NoDataException(responseData.responseResult.message);
          }
          return result;
        } else {
          throw ParseDataErrorException(responseData.responseResult.errorCode, responseData.responseResult.message);
        }
      } else {
        throw IncorrectFormatException("Incorrect format json ResponseData: $json");
      }
    } catch (e) {
      UtilsHelper.pushError(e);
      rethrow;
    }
  }

  List<T> mapList<T extends BaseResult>(Map<String, dynamic> json, T target) {
    try {
      if (UtilsHelper.hasJsonKey(json, "ResponseResult") || UtilsHelper.hasJsonKey(json, "Result")) {
        ResponseData responseData = ResponseData.fromJson(json, ListResponseModel());
        if (!responseData.responseResult.hasError()) {
          dynamic result = responseData.responseResult.result.result;

          if (result == null) {
            throw NoDataException(responseData.responseResult.message);
          }

          List<T> dataList = [];

          for (Map<String, dynamic> item in result) {
            dataList.add(ResponseListItemData<T>.fromJson(item, target).result);
          }

          return dataList;
        } else {
          throw ParseDataErrorException(responseData.responseResult.errorCode, responseData.responseResult.message);
        }
      } else {
        throw IncorrectFormatException("Incorrect format json ResponseData: $json");
      }
    } catch (e) {
      UtilsHelper.pushError(e);
      rethrow;
    }
  }
}
