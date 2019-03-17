import 'package:dio/dio.dart';

class HttpManager {

  static const BASE_URL = "https://www.wanandroid.com";

  static final HttpManager _instance = HttpManager._internal();

  Dio _client;

  factory HttpManager() => _instance;

  HttpManager._internal() {
    if (_client ==null) {
      BaseOptions options = BaseOptions();
      options.baseUrl = BASE_URL;
      options.receiveTimeout = 1000 * 10;  // 10 秒
      options.connectTimeout = 1000 * 5;   // 5 秒
      _client = Dio(options);
    }
  }
  
  Future<Map<String, dynamic>> get(String url, [Map<String, dynamic> params]) async {
    Response<Map<String,  dynamic>> response;
    if (params != null) {
      response = await _client.get(url, queryParameters: params);
    } else {
      response = await _client.get(url);
    }
    return response.data;
  }

  // dynamic get(String url, [Map<String, dynamic> params]) async {
  //   Response response = await _client.get<String>(url, queryParameters: params);
  //   print(response.data.toString());
  // }
}