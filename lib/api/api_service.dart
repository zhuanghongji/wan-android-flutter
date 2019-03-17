import 'package:wan/http/http_manager.dart';

import 'api.dart';
import 'base_resp.dart';
import 'datas/banner.dart';

class ApiService {

  static Future<List<Banner>> getBanner() async {
      Map<String, dynamic> jsonRes = await HttpManager().get('/banner/json');
      BaseRespList<Banner> bannerRespList = BaseRespList.fromJson(jsonRes, (res) => Banner.fromJson(res));
      return bannerRespList.data;
  }
}