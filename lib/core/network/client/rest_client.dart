import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../injector.dart';
import '../../exception/client_rest_exception.dart';
import '../../utils/utils_helper.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class RestClient {
  Dio? dio;
  String token = '';

  Map<String, dynamic> headersDefault = {
    'Content-Type': 'application/json',
    'Access-Control_Allow_Origin': '*',
    'Accept': 'application/json',
    'Connection': 'keep-alive'
  };

  setAuthorizationHeader(String token) async {
    if(token.isEmpty){
      removeAuthorizationHeader();
      return;
    }
    if (dio != null) {
      dio?.options.headers['Authorization'] = "Bearer " + token;
      this.token = token;
    }
  }

  removeAuthorizationHeader() async {
    if (dio != null) {
      dio?.options.headers.remove('Authorization');
      token = '';
    }
  }

  initDioWithBaseUrl(String baseUrl, {Map<String, dynamic>? headers, Interceptors? interceptors}) {
    if (dio == null || dio?.options.baseUrl != baseUrl) {
      dio = Dio(
        BaseOptions(
          contentType: 'Application/json',
          responseType: ResponseType.json,
          followRedirects: false,
          baseUrl: baseUrl,
          connectTimeout: 30000,
          receiveTimeout: 30000,
        ),
      );
      log('init new service: $baseUrl');
    }
    dio?.options.headers = headers ?? headersDefault;
    if (dio?.options.headers['Authorization'] == null && token.isNotEmpty) {
      setAuthorizationHeader(token);
    }
    initInterceptors(interceptors: interceptors);
    return this;
  }

  void initInterceptors({Interceptors? interceptors}) {
    if (interceptors != null) {
      dio?.interceptors.addAll(interceptors);
    }
  }

  Future<Map<String, dynamic>> request(
      String url, Method method, Map<String, dynamic>? params, {bool isIgnoreHttpCode = false, Function(Response response)? onResponse}) async {
    Response response;
    final options = Options(validateStatus: (status) => isIgnoreHttpCode ? true : httpStatusCodeError(status));

    try {
      log('request: ${dio!.options.baseUrl}');
      if (method == Method.POST) {
        response = await dio!.post(url, data: params, options: options);
      } else if (method == Method.PUT) {
        response = await dio!.put(url, data: params, options: options);
      } else if (method == Method.DELETE) {
        response = await dio!.delete(url, data: params, options: options);
      } else if (method == Method.PATCH) {
        response = await dio!.patch(url, data: params, options: options);
      } else {
        response = await dio!.get(
          url,
          queryParameters: params,
            options: options
        );
      }
      final Map<String, dynamic> responseData = classifyResponse(response);
      if(onResponse != null) onResponse(response);
      return responseData;
    } catch (error) {
      final exception = ClientRestException.getDioException(error);
      UtilsHelper.pushError(exception);
      throw exception;
    }
  }

  Future<Map<String, dynamic>> post(
      String endPoint, Map<String, dynamic> body) async {
    return request(endPoint, Method.POST, body);
  }

  Future<Response> postWithDynamicBody(String endPoint, dynamic body) async {
    return await dio!.post(endPoint, data: body);
  }

  Map<String, dynamic> classifyResponse(Response response) {
    Map<String, dynamic> responseData;
    try {
      responseData = jsonDecode(response.data.toString());
    } catch (e) {
      responseData = response.data as Map<String, dynamic>;
    }
    return responseData;
  }

  bool httpStatusCodeError(int? status) {
    status = status ?? 400;
    return !(400 <= status && status <= 599);
  }
}
