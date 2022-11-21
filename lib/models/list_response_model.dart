import '../core/network/model/response_data.dart';
import '../core/utils/utils_helper.dart';

class ListResponseModel implements BaseResult<ListResponseModel>{

  List<dynamic>? result;

  ListResponseModel();

  ListResponseModel.fromJson(json){
    result = json as List<dynamic>;
  }

  @override
  ListResponseModel fromJson(json) {
    return ListResponseModel.fromJson(json);
  }
}