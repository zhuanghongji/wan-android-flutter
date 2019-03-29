import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';


class HttpManager {

  static const BASE_URL = "https://www.wanandroid.com";

  static final HttpManager _instance = HttpManager._internal();

  Dio _client;

  factory HttpManager() => _instance;

  HttpManager._internal() {
    if (_client == null) {
      BaseOptions options = BaseOptions();
      options.baseUrl = BASE_URL;
      options.receiveTimeout = 1000 * 10;  // 10 秒
      options.connectTimeout = 1000 * 5;   // 5 秒
      _client = Dio(options);
    }
    // _client.interceptors.add(CookieInterceptor());
    _client.interceptors.add(CookieManager(CookieJar()));
    _client.interceptors.add(LogInterceptor(requestBody: true));
  }
  
  /// GET 请求
  /// 
  /// - [path] 参数是跟在 [BASE_URL] 后面的路径
  /// - [params] 参数是请求参数
  Future<Map<String, dynamic>> get(String path, [Map<String, dynamic> params]) async {
    Response<Map<String,  dynamic>> response;
    if (params != null) {
      response = await _client.get(path, queryParameters: params);
    } else {
      response = await _client.get(path);
    }
    // print('HttpManager: get, path = $path, params = $params, response = $response');
    return response.data;
  }

  /// POST 请求
  /// 
  /// - [path] 参数是跟在 [BASE_URL] 后面的路径
  /// - [params] 参数是请求参数
  Future<Map<String, dynamic>> post(String path, [Map<String, dynamic> params]) async {
    Response<Map<String,  dynamic>> response;
    if (params != null) {
      response = await _client.post(path, queryParameters: params);
    } else {
      response = await _client.post(path);
    }
    // print('HttpManager: post, path = $path, params = $params, response = $response');
    return response.data;
  }
}