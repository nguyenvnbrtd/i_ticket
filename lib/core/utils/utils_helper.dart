import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as Aes;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation/core/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_animation/core/blocs/authentication/authentication_event.dart';
import 'package:flutter_animation/core/utils/recase.dart';
import 'package:flutter_animation/models/arguments_screen_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../injector.dart';
import '../../route/page_routes.dart';
import 'constants.dart';
import 'device_info.dart';
import 'dialog_utils.dart';
import 'error_handler.dart';

class UtilsHelper {
  UtilsHelper._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static bool isShowDialogException = true;
  static bool isRunningCrashlytics = true;

  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  /// lấy json object theo key và hỗ trợ multi key
  /// @json: object json nguồn
  /// @keys: danh sách keys các json có thể chứa trong json object vd ['userName', 'userNames']
  /// @isCheckAllCase = true: tự động chuyển đổi và check key theo các trường hợp camelCase, snake_case, PascalCase và param-case
  /// @return dynamic object data
  ///
  static dynamic getJsonValue(Map<String, dynamic> json, List<String> keys, {bool isCheckAllCase = true}) {
    for (int index = 0; index < keys.length; index++) {
      String key = keys[index];
      // convert key theo các trường hợp key
      if (isCheckAllCase) {
        Set<String> findByKeys = {key};
        findByKeys.add(key.camelCaseChange);
        findByKeys.add(key.snakeCase);
        findByKeys.add(key.pascalCase);
        findByKeys.add(key.paramCaseChange);
        for (var element in findByKeys) {
          if (json.containsKey(element)) {
            return json[element];
          }
        }
      } else {
        return json[key];
      }
    }
    return null;
  }

  /// lấy json string theo key và hỗ trợ multi key
  /// @json: object json nguồn
  /// @keys: danh sách keys các json có thể chứa trong json object vd ['userName', 'userNames']
  /// @isCheckAllCase = true: tự động chuyển đổi và check key theo các trường hợp camelCase, snake_case, PascalCase và param-case
  /// @return string value by json key
  ///
  static String getJsonValueString(Map<String, dynamic> json, List<String> keys, {bool isCheckAllCase = true}) {
    final data = getJsonValue(json, keys, isCheckAllCase: isCheckAllCase);
    if(data == null) return '';
    return data.toString();
  }

  /// check key có tồn tại trong json không
  static bool hasJsonKey(Map<String, dynamic> json, String key, {bool isCheckAllCase = true}) {
    Set<String> keys = {key};
    if (isCheckAllCase) {
      keys.add(key.camelCaseChange);
      keys.add(key.snakeCase);
      keys.add(key.pascalCase);
      keys.add(key.paramCaseChange);
    }
    for (var element in keys) {
      if (json.containsKey(element)) {
        return true;
      }
    }
    return false;
  }

  static double getWidth(GlobalKey keyOfWidget, double defaultValueIfNull) {
    if (keyOfWidget.currentContext != null) {
      return keyOfWidget.currentContext!.size != null ? keyOfWidget.currentContext!.size!.height : defaultValueIfNull;
    }
    return defaultValueIfNull;
  }

  static getHeight(GlobalKey keyOfWidget, double defaultValueIfNull) {
    if (keyOfWidget.currentContext != null) {
      return keyOfWidget.currentContext!.size != null ? keyOfWidget.currentContext!.size!.width : defaultValueIfNull;
    }
    return defaultValueIfNull;
  }

  static void copyStringToClipBoard({required String data}) async {
    final context = UtilsHelper.navigatorKey.currentContext;
    if (context == null) return;

    ClipboardData clipboardData = ClipboardData(text: data);
    await Clipboard.setData(clipboardData);
  }

  static String encode(String input) {
    final encrypter = Aes.Encrypter(Aes.AES(Constants.AES_KEY));
    final encrypted = encrypter.encrypt(input, iv: Constants.AES_INITIALIZATION_VECTOR);
    return encrypted.base64;
  }

  static decode(String input) {
    final encrypter = Aes.Encrypter(Aes.AES(Constants.AES_KEY));
    final decrypted = encrypter.decrypt64(input, iv: Constants.AES_INITIALIZATION_VECTOR);
    return decrypted;
  }

  /// when using it in a bloc and call a emit in function
  /// you must to await
  static Future<void> runInGuardZone(
      {required Function func, Function(Object e)? onFailed, bool isShowProgress = false, bool showLoading = true}) async {
    try {
      // DialogUtils.showLoadingDialog(isShowProgress: isShowProgress);
      await func();
      // await DialogUtils.dismissPopup();
    } catch (e) {
      // await DialogUtils.dismissPopup();
      if(onFailed != null) onFailed(e);
      pushError(e);
    }
  }

  static void pushError(Object errorOrCode) {
    it<ErrorHandler>().pushError(errorOrCode);
  }

  static void showError(Object e) {
    final String error = UtilsHelper.getErrorMessage(e);
    if (error.isNotEmpty) {
      DialogUtils.showToast(error);
    }
  }

  static String getErrorMessage(Object error) {
    final context = UtilsHelper.navigatorKey.currentContext;
    if (context == null) return "";

    final lang = AppLocalizations.of(context)!;

    final code = error.toString();

    switch (code) {
      // case Constants.USERNAME_EMPTY:
      //   return lang.userNameIsNotEmpty;

      default:
        return '';
    }
  }

  static void dismissKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static bool pop() {
    Navigator.pop(navigatorKey.currentContext!);
    return true;
  }

  static bool popUntil(RoutePredicate predicate) {
    Navigator.popUntil(navigatorKey.currentContext!, predicate);
    return true;
  }

  static bool popUntilName(String routeName) {
    Navigator.popUntil(navigatorKey.currentContext!, (route) => route.settings.name == routeName);
    return true;
  }

  static void popToLogin(){
    UtilsHelper.popUntil((route) => route.settings.name == Routes.login);
  }

  static void pushNamed(String route, [Object? data]) {
    final arg = ArgumentsScreenModel(title: route, data: data);
    Navigator.pushNamed(navigatorKey.currentContext!, route, arguments: arg);
  }

  static void popAllAndPushNamed(String route) {
    Navigator.restorablePopAndPushNamed(navigatorKey.currentContext!, route);
  }

  static void login(String userId) {
    navigatorKey.currentContext!.read<AuthenticationBloc>().add(AuthenticationEventLoggingIn(userId: userId));
  }

  static void logout() {
    navigatorKey.currentContext!.read<AuthenticationBloc>().add(AuthenticationEventLoggingOut());
  }

  static String formatTime(DateTime date){
    DateFormat format = DateFormat(Constants.DATE_TIME_FORMAT);
    return format.format(date);
  }

  static String formatDate(DateTime date){
    DateFormat format = DateFormat(Constants.DATE_FORMAT);
    return format.format(date);
  }

  static String getCurrentDateTime() {
    final time = DateTime.now();
    DateFormat format = DateFormat(Constants.DATE_TIME_FORMAT);
    return format.format(time);
  }

  static String getCurrentTime() {
    final time = DateTime.now();
    DateFormat format = DateFormat(Constants.TIME_FORMAT);
    return format.format(time);
  }

  static String getTimeFromString(String date) {
    try{
      DateFormat format = DateFormat(Constants.HOUR_MINUTES_FORMAT);
      DateTime time = DateFormat(Constants.DATE_TIME_FORMAT).parse(date);
      return format.format(time);
    }catch(e){
      return 'none';
    }
  }

  static String getDateFromString(String date) {
    try{
      DateFormat format = DateFormat(Constants.DATE_FORMAT);
      DateTime time = DateFormat(Constants.DATE_TIME_FORMAT).parse(date);
      return format.format(time);
    }catch(e){
      return 'none';
    }
  }

  // minute
  static int getDiffFromTwo(String h1, String h2){
    try{
      DateTime hour1 = DateFormat(Constants.DATE_TIME_FORMAT).parse(h1);
      DateTime hour2 = DateFormat(Constants.DATE_TIME_FORMAT).parse(h2);

      return hour1.difference(hour2).inMinutes;
    }catch(e){
      return 0;
    }
  }

  static String getDiffHoursFromTwo(String h1, String h2){
    try{
      String result = '';
      final diff = getDiffFromTwo(h1, h2).abs();

      if(diff ~/ (60 * 24) >= 1){
        final day = diff ~/ (60 * 24);
        result += '$day day${day > 1 ? 's' : ''} ';
      }
      if(diff ~/ 60 >= 1){
        final hour = diff % (60 * 24);
        final hourRemain = hour ~/ 60;
        result += '$hourRemain hour${hourRemain > 1 ? 's' : ''} ';
      }
      if(diff % 60 > 0){
        final minute = diff % 60;
        result += '$minute minutes';
      }

      return result;
    }catch(e){
      return '0 hour';
    }
  }

  // copy the element of target where it not empty
  static List<T> copyElementList<T>({required List<T> defaultList, required List<T> targetList, required T emptyValue}){
    List<T> result = [];
    for(int i = 0; i < defaultList.length ; i++){
      if(targetList.length <= i){
        result.add(defaultList[i]);
        continue;
      }
      final item = targetList[i];
      if(item != emptyValue){
        result.add(item);
      }else{
        result.add(defaultList[i]);
      }
    }
    return result;
  }
}
