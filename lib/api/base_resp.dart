import 'dart:convert' show json;

class BaseResp<T> {

  int errorCode;
  String errorMsg;
  T data;

  factory BaseResp(jsonStr, Function buildFun) => jsonStr is String 
      ? BaseResp.fromJson(json.decode(jsonStr), buildFun)
      : BaseResp.fromJson(jsonStr, buildFun);

  BaseResp.fromJson(jsonRes, Function buildFun) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];

    _check(errorCode, errorMsg);

    data = buildFun(jsonRes['data']);
  }
}

class BaseRespList<T> {

  int errorCode;
  String errorMsg;
  List<T> data;

  factory BaseRespList(jsonStr, Function buildFun) => jsonStr is String 
      ? BaseRespList.fromJson(json.decode(jsonStr), buildFun)
      : BaseRespList.fromJson(jsonStr, buildFun);

  BaseRespList.fromJson(jsonRes, Function buildFun) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];

    _check(errorCode, errorMsg);
    
    data = (jsonRes['data'] as List).map<T>((ele) => buildFun(ele)).toList();
  }
}

void _check(int code, String msg) {}