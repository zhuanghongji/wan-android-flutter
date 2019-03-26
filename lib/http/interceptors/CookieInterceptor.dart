
import 'package:dio/dio.dart';
import 'package:wan/manager/user_manager.dart';

const _TAG = 'CookieInterceptor:';

/// 自定义拦截器：处理 WAN ANDROID OPEN API 的 Cookie
class CookieInterceptor extends Interceptor {

  @override
  onRequest(RequestOptions options) {
    // List<String> cookies = UserManager().getCookies();
    // print('options = $options');
    // print('cookies = $cookies');
    // Map<String, String> entries = Map();
    // for (var cookie in cookies) {
    //   var entries = Map<String, String>();
    //   entries['Cookie'] = cookie;
    //   options.headers.addAll(entries);
    // }

    // for (var cookieStr in cookies) {
    //   options.cookies.add(Cookie.fromSetCookieValue(cookieStr));
    // }
    // options.headers.addEntries(newEntries)
    return super.onRequest(options);
  }
  
  @override
  onResponse(Response response) {
    // String uriStr = response.request.uri.toString();
    // if (uriStr.contains('login') || uriStr.contains('register')) {
    //   UserManager().saveCookies(response);
    // }
    return super.onResponse(response);
  }
}