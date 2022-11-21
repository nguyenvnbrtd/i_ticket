import '../utils/constants.dart';
import 'client_rest_exception.dart';

abstract class DataParserException extends ClientRestException {
  DataParserException([int? code, String? message])
      : super(code ?? Constants.DATA_PARSER_ERROR_CODE, message ?? "FetchDataException");
}

class NoDataException extends DataParserException {
  NoDataException([String? message]) : super(Constants.NO_DATA_CODE, message ?? "No data");
}

class ParseDataErrorException extends DataParserException{
  ParseDataErrorException([int? code, String? message]) : super(code, message ?? "Parse data fail");
}

class IncorrectFormatException extends DataParserException{
  IncorrectFormatException([String? message]) : super(Constants.INCORRECT_FORMAT_CODE, message ?? "Incorrect format");
}