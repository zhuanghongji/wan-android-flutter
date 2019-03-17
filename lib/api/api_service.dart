import 'package:wan/http/http_manager.dart';

import 'base_resp.dart';
import 'datas/banner.dart';
import 'datas/articles.dart';

class ApiService {

  static Future<T> get<T>(String path, Function buildFun, [Map<String, dynamic> params]) async {
    Map<String, dynamic> jsonRes = await HttpManager().get(path, params);
    BaseResp<T> resp = BaseResp.fromJson(jsonRes, buildFun);
    return resp.data;
  }

  static Future<List<T>> getList<T>(String path, Function buildFun, [Map<String, dynamic> params]) async {
    Map<String, dynamic> jsonRes = await HttpManager().get(path, params);
    BaseRespList<T> respList = BaseRespList.fromJson(jsonRes, buildFun);
    return respList.data;
  }

  static Future<List<Banner>> getBanner() async {
    return getList('/banner/json', (res) => Banner.fromJson(res));
  } 

  static Future<Articles> getArticles(int pageNum) async {
    return get('/article/list/$pageNum/json', (res) => Articles.fromJson(res));
  }
}