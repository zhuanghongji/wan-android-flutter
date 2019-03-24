import 'package:wan/api/base_resp.dart';
import 'package:wan/api/datas/Friend.dart';
import 'package:wan/api/datas/article.dart';
import 'package:wan/api/datas/articles.dart';
import 'package:wan/api/datas/banner.dart';
import 'package:wan/api/datas/collections.dart';
import 'package:wan/api/datas/hotkey.dart';
import 'package:wan/api/datas/login_info.dart';
import 'package:wan/api/datas/navi.dart';
import 'package:wan/api/datas/project_tree.dart';
import 'package:wan/api/datas/projects.dart';
import 'package:wan/api/datas/system_tree.dart';
import 'package:wan/api/datas/website_collection.dart';
import 'package:wan/api/datas/wx_article_s.dart';
import 'package:wan/api/datas/wx_chapter.dart';
import 'package:wan/http/http_manager.dart';


class ApiService {

  /// 在 HttpManager 上封装的 GET 请求，返回结果的 data 节点为 object
  static Future<T> get<T>(String path, Function buildFun, [Map<String, dynamic> params]) async {
    Map<String, dynamic> jsonRes = await HttpManager().get(path, params);
    BaseResp<T> resp = BaseResp.fromJson(jsonRes, buildFun);
    return resp.data;
  }

  /// 在 HttpManager 上封装的 GET 请求，返回结果的 data 节点为 List<object>
  static Future<List<T>> getList<T>(String path, Function buildFun, [Map<String, dynamic> params]) async {
    Map<String, dynamic> jsonRes = await HttpManager().get(path, params);
    BaseRespList<T> respList = BaseRespList.fromJson(jsonRes, buildFun);
    return respList.data;
  }

  // /// 在 HttpManager 上封装的 POST 请求
  // static Future<Map<String, dynamic>> post(String path, Map<String, dynamic> params) async {
  //   return await HttpManager().post(path, params);
  // }

  /// 在 HttpManager 上封装的 POST 请求，返回结果的 data 节点为 object
  static Future<T> post<T>(String path, Function buildFun, [Map<String, dynamic> params]) async {
    Map<String, dynamic> jsonRes = await HttpManager().post(path, params);
    BaseResp<T> resp = BaseResp.fromJson(jsonRes, buildFun);
    return resp.data;
  }

  /// 在 HttpManager 上封装的 POST 请求，返回结果的 data 节点为 List<object>
  static Future<List<T>> postList<T>(String path, Function buildFun, [Map<String, dynamic> params]) async {
    Map<String, dynamic> jsonRes = await HttpManager().post(path, params);
    BaseRespList<T> respList = BaseRespList.fromJson(jsonRes, buildFun);
    return respList.data;
  }

  /// 首页 Banner
  static Future<List<BannerItem>> getBanner() async {
    return getList('/banner/json', (res) => BannerItem.fromJson(res));
  } 

  /// 首页文章列表
  /// 
  /// - [pageNum] 页码，拼接在连接中，从0开始。
  /// 
  /// 其中有两个易混淆的字段:
  /// - "superChapterId": 153, 
  /// - "superChapterName": "framework", // 一级分类的名称
  /// 
  /// superChapterId其实不是一级分类id，因为要拼接跳转url，内容实际都挂在二级分类下，
  /// 所以该id实际上是一级分类的第一个子类目的id，拼接后故可正常跳转。
  static Future<Articles> getArticles(int pageNum) async {
    return get('/article/list/$pageNum/json', (res) => Articles.fromJson(res));
  }

  /// 常用网站
  static Future<List<Friend>> getFridends() async {
    return getList('/friend/json', (res) => Friend.fromJson(res));
  }

  /// 搜索热词
  /// 
  /// 即目前搜索最多的关键词。
  static Future<List<Hotkey>> getHotkeys() async {
    return getList('/hotkey/json', (res) => Hotkey.fromJson(res));
  }

  /// 体系数据
  /// 
  /// 主要标识的网站内容的体系结构，二级目录
  static Future<List<SystemTree>> getSystemTrees() async {
    return getList('/tree/json', (res) => SystemTree.fromJson(res));
  }

  /// 知识体系下的文章
  /// 
  /// - [pageNum] 页码：拼接在链接上，从0开始。
  /// - [cid] cid 分类的id，上述二级目录的 id (体系具体条目)
  static Future<Articles> getArticlesByCid(int pageNum, int cid) async {
    return get('/article/list/$pageNum/json?cid=$cid', (res) => Articles.fromJson(res));
  }

  /// 导航数据
  static Future<List<Navi>> getNavis() async {
    return getList('/navi/json', (res) => Navi.fromJson(res));
  }

  /// 项目分类
  /// 
  /// 项目为包含一个分类，该接口返回整个分类。
  static Future<List<ProjectTree>> getProjectTrees() async {
    return getList('/project/tree/json', (res) => ProjectTree.fromJson(res));
  }

  /// 项目列表数据
  /// 
  /// 某一个分类下项目列表数据，分页展示
  /// - [pageNum] 页码：拼接在链接中，从1开始。
  /// - [cid] cid 分类的id，上面项目分类接口
  static Future<Projects> getProjectsByCid(int pageNum, int cid) async {
    return get('/project/list/$pageNum/json?cid=$cid', (res) => Projects.fromJson(res));
  }

  /// 登录
  /// 
  /// 登录后会在cookie中返回账号密码，只要在客户端做cookie持久化存储即可自动登录验证。
  static Future<LoginInfo> login(String username, String password) async {
    return post('/user/login', (res) => LoginInfo.fromJson(res), {
      'username': username,
      'password': password,
    });
  }

  /// 注册
  static Future<LoginInfo> register(String username, String password, String repassword) async {
    return post('/user/register', (res) => LoginInfo.fromJson(res), {
      'username': username,
      'password': password,
      'repassword': repassword,
    });
  }

  /// 退出登录
  /// 
  /// 访问了 logout 后，服务端会让客户端清除 Cookie（即cookie max-Age=0）
  /// 如果客户端 Cookie 实现合理，可以实现自动清理，如果本地做了用户账号密码和保存，及时清理。
  static Future<dynamic> logout() async {
    return get('/user/logout/json', () => {});
  }

  /// 收藏文章列表
  /// 
  /// - [pageNum] 页码：拼接在链接中，从0开始。
  /// 在网站上登录后，可以直接访问 https://www.wanandroid.com/lg/collect/list/0/json 查看自己收藏的文章。
  static Future<Collections> getCollections(int pageNum) async {
    return get('/lg/collect/list/$pageNum/json', (res) => Collections.fromJson(res));
  }

  /// 收藏站内文章
  /// 
  /// - [articleId] 文章id，拼接在链接中。
  /// 
  /// 意链接中的数字，为需要收藏的id.
  static Future<dynamic> collectArticle(int articleId) async {
    return post('/lg/collect/$articleId/json', null, {});
  }

  /// 收藏站外文章
  /// 
  /// - [title] 标题
  /// - [author] 作者
  /// - [link] 链接
  static Future<dynamic> collectAnotherArticle(String title, String author, String link) async {
    return post('/lg/collect/add/json', null, {
      'title': title,
      'author': author,
      'link': link,
    });
  }

  /// 取消收藏（文章列表）
  /// 
  /// - [articleId] 文章列表中文章的id
  /// 
  /// 注意，取消收藏一共有两个地方可以触发：
  /// - 文章列表 [cancelArticleCollection]
  /// - 我的收藏页面（该页面包含自己录入的内容）[uncollect]
  static Future<dynamic> cancelArticleCollection(int articleId) async {
    return post('/lg/uncollect_originId/$articleId/json', null, {});
  }

  /// 取消收藏（我的收藏页面，该页面包含自己录入的内容）
  ///
  /// 注意，取消收藏一共有两个地方可以触发：
  /// - 文章列表 [cancelArticleCollection]
  /// - 我的收藏页面（该页面包含自己录入的内容）[uncollect]
  static Future<dynamic> uncollect(int articleId) async {
    return post('/lg/uncollect/$articleId/json', null, {});
  }

  /// 收藏网站列表
  static Future<WebsiteCollection> collectUserTools() async {
    return get('/lg/collect/usertools/json', (res) => WebsiteCollection.fromJson(res));
  }

  /// 收藏网址
  /// 
  /// - [name] 网址名称
  /// - [link] 网址链接
  static Future<dynamic> collectAddTool(String name, String link) async {
    return post('/lg/collect/addtool/json', null, {
      'name': name,
      'link': link
    });
  }

  /// 编辑收藏网站
  /// 
  /// - [id] id
  /// - [name] 网址名称
  /// - [link] 网址链接
  static Future<dynamic> collectUpdateTool(int id, String name, String link) async {
    return post('/lg/collect/updatetool/json', null, {
      'id': id,
      'name': name,
      'link': link
    });
  }

  /// 删除收藏网站
  /// 
  /// - [id] id 
  static Future<dynamic> collectDeleteTools(int id) async {
    return post('/lg/collect/delete/json', null, {
      'id': id,
    });
  }

  /// 搜索
  /// 
  /// - [pageNum] 页码：拼接在链接上，从0开始
  /// - [key] 搜索关键词
  static Future<Articles> queryArticles(int pageNum, String key) async {
    return post('/article/query/$pageNum/json', (res) => Articles.fromJson(res), {
      'k': key,
    });
  }

  /// 新增一个 Todo
  /// 
  /// - [title] 新增标题（必须）
  /// - [content] 新增详情（必须）
  /// - [date] 2018-08-01 预定完成时间（不传默认当天，建议传）
  /// - [type] 大于0的整数（可选）；
  /// - [priority] 大于0的整数（可选）；
  /// 
  /// type 可以用于，在app 中预定义几个类别：例如 工作1；生活2；娱乐3；新增的时候传入0，1，2，查询的时候，传入type 进行筛选；
  /// priority 主要用于定义优先级，在app 中预定义几个优先级：重要（1），一般（2）等，查询的时候，传入priority 进行筛选；
  static Future<dynamic> addTodo(String title, String content, [String date, int type, int priority]) async {
    return post('/lg/todo/add/json', null, {
      'title': title,
      'content': content,
      'date': date,
      'type': type,
      'priority': priority,
    });
  }

  /// 更新一个 Todo
  /// 
  /// - [id] 拼接在链接上，为唯一标识，列表数据返回时，每个 todo 都会有个 id 标识（必须）
  /// - [status] 0 为未完成，1 为完成
  /// 
  /// 如果有当前状态没有携带，会被默认值更新，
  /// 比如当前 todo status=1，更新时没有带上，会认为被重置。
  static Future<dynamic> updateTodo(int todoId, String title, String content, String date, 
      [int status, int type, int priority]) async {
    return post('/lg/todo/update/$todoId/json', null, {
      'title': title,
      'content': content,
      'date': date,
      'status': status,
      'type': type,
      'priority': priority,
    });
  }

  /// 删除一个 Todo
  /// 
  /// - [id] 拼接在链接上，为唯一标识
  static Future<dynamic> deleteTodo(int todoId) async {
    return post('/lg/todo/delete/$todoId/json', null, {});
  }

  /// 仅更新完成状态 Todo
  /// 
  /// - [id] 拼接在链接上，为唯一标识
  /// - [status] 0或1，传1代表未完成到已完成，反之则反之。
  /// 
  /// 只会变更 status，未完成->已经完成 or 已经完成->未完成。
  static Future<dynamic> doneTodo(int todoId, int status) async {
    return post('/lg/todo/done/$todoId/json', null, {});
  }

  /// Todo 列表
  /// 
  /// - [pageNum] 页码从1开始，拼接在url 上
  /// - [status] 状态， 1-完成；0未完成; 默认全部展示；
  /// - [type] 创建时传入的类型, 默认全部展示
  /// - [priority] 创建时传入的优先级；默认全部展示
  /// - [orderby] 1:完成日期顺序；2.完成日期逆序；3.创建日期顺序；4.创建日期逆序(默认)；
  static Future<dynamic> getTodos(int pageNum, int status, int type, int priority, int orderby) async {
    return post('/lg/todo/v2/list/$pageNum/json', null, {
      'status': status,
      'type': type,
      'priority': priority,
      'orderby': orderby,
    });
  }

  /// 获取公众号列表
  static Future<List<WxChapter>> getWxChapters() async {
    return getList('/wxarticle/chapters/json', (res) => WxChapter.fromJson(res));
  } 

  /// 查看某个公众号历史数据
  /// 
  /// - [chapterId] 公众号 ID：拼接在 url 中，eg:405
  /// - [pageNum] 公众号页码：拼接在url 中，eg:1
  static Future<WxArticles> getWxArticles(int chapterId, int pageNum) async {
    return get('/wxarticle/list/$chapterId/$pageNum/json', (res) => WxArticles.fromJson(res));
  } 

  /// 在某个公众号中搜索历史文章
  /// 
  /// - [chapterId] 公众号 ID：拼接在 url 中，eg:405
  /// - [pageNum] 公众号页码：拼接在url 中，eg:1
  /// - [key] k : 字符串，eg:Java
  static Future<WxArticles> searchWxArticles(int chapterId, int pageNum, String key) async {
    return get('/wxarticle/list/$chapterId/$pageNum/json?k=$key', (res) => WxArticles.fromJson(res));
  } 

  /// 最新项目tab (首页的第二个tab)
  /// 
  /// 按时间分页展示所有项目。
  /// - [pageNum] 页码，拼接在连接中，从0开始。
  static Future<Projects> listProject(int pageNum) async {
    return get('/article/listproject/$pageNum/json', (res) => Projects.fromJson(res));
  } 
}