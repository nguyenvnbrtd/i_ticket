import '../utils/constants.dart';

class RemoteException implements Exception {
  final String? _message;
  final int? _code;

  RemoteException([this._code, this._message]);

  get message => _message ?? "";

  get code => _code ?? Constants.SYSTEM_ERROR_CODE;

  @override
  String toString() {
    return message.toString();
  }
}

class FetchDataException extends RemoteException {
  FetchDataException([int? code, String? message])
      : super(Constants.SYSTEM_ERROR_CODE, message ?? "FetchDataException");
}

class BadRequestException extends RemoteException {
  BadRequestException([String? message])
      : super(Constants.BAD_REQUEST_CODE, message ?? "BadRequestException");
}

class UnauthorisedException extends RemoteException {
  UnauthorisedException([String? message])
      : super(Constants.UNAUTHORISED_CODE, message ?? "UnauthorisedException");
}

class NetworkException extends RemoteException {
  NetworkException([String? message])
      : super(Constants.NETWORK_ERROR_CODE, message ?? "Lost Connection");
}
