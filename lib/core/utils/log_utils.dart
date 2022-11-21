import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'utils_helper.dart';

class LogUtils{
  LogUtils._();

  static const _IS_USING_LOG = true;
  static const _IS_DEBUG_MODE = kDebugMode;

  static const String INFORMATION = 'Info';
  static const String ERROR = 'Error';
  static const String DEBUG = 'Debugging';

  /// Log information
  /// EX: LogUtils.i(tag: 'Login', message: 'Login success with token: $token');
  static void i({String tag = INFORMATION, required String message}){
    if(!_IS_USING_LOG) return;
    _log(_stringFormat(tag), message);
  }

  /// Log error
  /// EX: LogUtils.e(tag: 'Login error', functionName: 'login', message: 'Login fail', error: e);
  static void e({String tag = ERROR, String functionName = '', required String message, dynamic error}){
    if(!_IS_USING_LOG) return;
    if (!_IS_DEBUG_MODE) return;

    String tagResult = '';
    if(functionName.isNotEmpty){
      tagResult += _stringFormat(functionName) + '-';
    }
    tagResult += _stringFormat(tag);

    String messageResult = message;
    if(error != null){
      messageResult += '\n' + error.toString();
    }
    _log(tagResult, messageResult);
  }

  /// Log debug
  /// EX: LogUtils.d(tag: 'Login user name', message: 'userName: $userName');
  static void d({String tag = DEBUG, required String message}){
    if(!_IS_USING_LOG) return;
    if (!_IS_DEBUG_MODE) return;
    _log(_stringFormat(tag), message);
  }

  static void _log(String tag, String message, { bool isReport = false }){
    if(isReport){
      // report to server
    }

    log('${_stringFormat(UtilsHelper.getCurrentTime())} $tag: $message');
  }

  static String _stringFormat(String str){
    return '[$str]';
  }
}