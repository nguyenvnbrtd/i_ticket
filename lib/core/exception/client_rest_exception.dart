import 'dart:io';

import 'package:dio/dio.dart';

import '../utils/constants.dart';

class ClientRestException implements Exception {
  final String? _message;
  final int? _code;

  const ClientRestException([this._code, this._message]);

  get message => _message ?? "";

  get code => _code ?? Constants.UNKNOWN_ERROR_CODE;

  @override
  String toString() {
    return message.toString();
  }

  static ClientRestException getDioException(error) {
    if (error is Exception) {
      try {
        ClientRestException exception;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              exception = RequestCancelledException();
              break;
            case DioErrorType.connectTimeout:
              exception = ConnectTimeoutException();
              break;
            case DioErrorType.other:
              exception = NoInternetConnectionException();
              break;
            case DioErrorType.receiveTimeout:
              exception = ReceiveTimeoutException();
              break;
            case DioErrorType.sendTimeout:
              exception = SendTimeoutException();
              break;
            case DioErrorType.response:
              switch (error.response?.statusCode) {
                case 400:
                  exception = const BadRequestException();
                  break;
                case 401:
                  exception = const UnauthorisedException();
                  break;
                case 403:
                  exception = const ForbiddenErrorException();
                  break;
                case 404:
                  exception = const NotFoundException();
                  break;
                case 405:
                  exception = const MethodNotAllowedException();
                  break;
                case 408:
                  exception = const RequestTimeoutException();
                  break;
                case 409:
                  exception = const ConflictException();
                  break;
                case 429:
                  exception = const TooManyRequestsException();
                  break;
                case 500:
                  exception = const InternalServerErrorException();
                  break;
                case 503:
                  exception = const ServiceUnavailableException();
                  break;
                default:
                  final responseCode = error.response?.statusCode;
                  exception = NetworkException(responseCode ?? 0,
                    "Received invalid status code: $responseCode",
                  );
              }
              break;
          }
        } else if (error is SocketException) {
          exception = NoInternetConnectionException();
        } else {
          exception = DefaultErrorException();
        }
        return exception;
      } on FormatException {
        return ResponseFormatException();
      } catch (e) {
        return DefaultErrorException(e.toString());
      }
    } else {
      return UnknownErrorException();
    }
  }
}

class FetchDataException extends ClientRestException {
    FetchDataException([int? code, String? message])
      : super(
      code ?? Constants.FETCH_DATA_ERROR_CODE, message ?? "FetchDataException");
}

class NetworkException extends ClientRestException {

  const NetworkException([int? code, String? message]) : super(
      code ?? Constants.NETWORK_ERROR_CODE, message ?? "NetworkException");

  @override
  String toString() {
    return message.toString();
  }
}

class UnauthorisedException extends NetworkException {
  const UnauthorisedException([String? message]) : super(
      401, message ?? "Unauthorised");
}

class BadRequestException extends NetworkException {
  const BadRequestException([String? message]) : super(
      400, message ?? "Bad request");
}

class ForbiddenErrorException extends NetworkException {
  const ForbiddenErrorException([String? message]) : super(
      403, message ?? "Forbidden Error");
}

class ConflictException extends NetworkException {
  const ConflictException([String? message]) : super(
      409, message ?? "Error due to a conflict");
}

class NotFoundException extends NetworkException {
  const NotFoundException([String? message]) : super(
      404, message ?? "Not Found");
}

class MethodNotAllowedException extends NetworkException {
  const MethodNotAllowedException([String? message]) : super(
      405, message ?? "Method Not Allowed");
}

class RequestTimeoutException extends NetworkException {
  const RequestTimeoutException([String? message]) : super(
      408, message ?? "Request Timeout");
}

class TooManyRequestsException extends NetworkException {
  const TooManyRequestsException([String? message]) : super(
      429, message ?? "Too Many Requests");
}

class InternalServerErrorException extends NetworkException {
  const InternalServerErrorException([String? message]) : super(
      500, message ?? "Internal Server Error");
}

class ServiceUnavailableException extends NetworkException {
  const ServiceUnavailableException([String? message]) : super(
      503, message ?? "Service Unavailable");
}

/// client exception
class RequestCancelledException extends FetchDataException {
   RequestCancelledException([String? message]) : super(
      Constants.REQUEST_CANCELLED_ERROR_CODE, message ?? "Request Cancelled");
}

class ConnectTimeoutException extends FetchDataException {
   ConnectTimeoutException([String? message]) : super(
      Constants.CONNECT_TIMEOUT_ERROR_CODE, message ?? "Connect Timeout");
}

class SendTimeoutException extends FetchDataException {
   SendTimeoutException([String? message]) : super(
      Constants.SEND_TIMEOUT_ERROR_CODE, message ?? "Send Timeout");
}

class ReceiveTimeoutException extends FetchDataException {
   ReceiveTimeoutException([String? message]) : super(
      Constants.RECEIVE_TIMEOUT_ERROR_CODE, message ?? "Receive Timeout");
}

class NoInternetConnectionException extends FetchDataException {
   NoInternetConnectionException([String? message]) : super(
      Constants.NO_CONNECTION_ERROR_CODE, message ?? "No Internet Connection");
}

class ResponseFormatException extends FetchDataException {
  ResponseFormatException([String? message]) : super(
      Constants.FORMAT_ERROR_CODE, message ?? "Bad Response Format!");
}

class DefaultErrorException extends FetchDataException {
  DefaultErrorException([String? message]) : super(null, message);
}

class UnknownErrorException extends FetchDataException {
  UnknownErrorException([String? message]) : super(
      Constants.UNKNOWN_ERROR_CODE, message ?? "unknown error");
}
