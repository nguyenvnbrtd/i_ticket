import 'package:encrypt/encrypt.dart';

class Constants {
  Constants._();

  ///error code
  static const CODE_SUCCESS = 0;
  static const INCORRECT_FORMAT_CODE = -1;
  static const NO_DATA_CODE = -2;
  static const NETWORK_ERROR_CODE = -3;
  static const SEND_TIMEOUT_ERROR_CODE = -4;
  static const REQUEST_CANCELLED_ERROR_CODE = -5;
  static const NO_CONNECTION_ERROR_CODE = -6;
  static const RECEIVE_TIMEOUT_ERROR_CODE = -7;
  static const CONNECT_TIMEOUT_ERROR_CODE = -8;
  static const FORMAT_ERROR_CODE = -8;
  static const UNKNOWN_ERROR_CODE = -9;
  static const FETCH_DATA_ERROR_CODE = -10;
  static const DATA_PARSER_ERROR_CODE = -11;
  static const UNAUTHORISED_CODE = 401;
  static const CODE_FILE_EXISTED = 403;
  static const SYSTEM_ERROR_CODE = 500;
  static const BAD_REQUEST_CODE = 400;

  static const ENV_KEY = "env";

  /// AES key
  static final AES_KEY = Key.fromUtf8('Md5Pz94WwlVdF0vHMaqd3IAfKEjnIdfz');
  static final AES_INITIALIZATION_VECTOR = IV.fromUtf8('484E6248C68E8283');

  static const DATE_TIME_FORMAT = 'dd-MM-yyyy HH:mm:ss';
  static const DATE_FORMAT = 'dd-MM-yyyy';
  static const TIME_FORMAT = 'HH:mm:ss';
  static const HOUR_MINUTES_FORMAT = 'HH:mm';

  /// firebase key

  static const USER = 'user';
  static const TRAVEL_ROUTE = 'travel_route';
  static const BOOKING_DETAIL = 'booking_detail';

  /// seats
  /// List<String>.generate(24, (index) => '');
  static const defaultSeats = [
    '', '', '', '',
    '', '', '', '',
    '', '', '', '',
    '', '', '', '',
    '', '', '', '',
    '', '', '', '',
  ];

  /// price
  static const priceType = 'VND';
}
