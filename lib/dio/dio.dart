import 'package:dio/dio.dart';

class api_test {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        }));
  }

  static Future<Response> get({
    required String url,
    dynamic query,
    dynamic token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      "Authorization": token ?? "",
      'lang': 'en',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> post({
    required String url,
    required dynamic data,
    dynamic query,
    dynamic token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio!.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> put({
    required String url,
    required dynamic data,
    dynamic query,
    dynamic token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio!.put(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
