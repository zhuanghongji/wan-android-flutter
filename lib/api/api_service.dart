import 'package:wan/http/http_manager.dart';

import 'api.dart';
import 'base_resp.dart';
import 'datas/banner.dart';

class ApiService {
  
  static void getBanner(Function callback) async {
    HttpManager().get('/banner/json');
  }
}