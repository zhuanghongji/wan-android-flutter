
import 'package:flutter/material.dart';
import 'package:wan/pages/about/about_page.dart';
import 'package:wan/pages/board/white_board_page.dart';
import 'package:wan/pages/collections/my_collections_page.dart';
import 'package:wan/pages/friend/friend_website_page.dart';
import 'package:wan/pages/login/login_page.dart';
import 'package:wan/pages/main/main_page.dart';
import 'package:wan/pages/project_list/project_list_page.dart';
import 'package:wan/pages/register/register_page.dart';
import 'package:wan/pages/search/search_page.dart';
import 'package:wan/pages/setting_avatar/SettingAvatarPage.dart';
import 'package:wan/pages/settings/settings_page.dart';
import 'package:wan/pages/system_articles/system_articles_page.dart';
import 'package:wan/pages/template/template_page.dart';
import 'package:wan/pages/web/web_page.dart';
import 'package:wan/pages/wx_chapter_articles/wx_chapter_articles.dart';

class WRouter {

  // MARK: wrap methods.

  static Future<MaterialPageRoute> push(BuildContext context, Widget page) async {
    return await Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static Future<MaterialPageRoute> pushReplacement(BuildContext context, Widget page) async {
    return await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  static Future<MaterialPageRoute> pushAndRemoveUntil(BuildContext context, Widget page, 
      bool Function(Route<dynamic>) predicate) async {
    return await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => page), 
      predicate);
  }

  static Future<bool> maybePop<T extends Object>(BuildContext context, [T result]) {
    return Navigator.maybePop<T>(context, result);
  }


  // MARK: concrete methods.

  /// 跳转到：白板页面
  static Future<MaterialPageRoute> pushWhiteBoardPage(BuildContext context) async {
    return await push(context, WhiteBoardPage());
  }

  /// 跳转到：搜索页面
  static Future<MaterialPageRoute> pushSearchPage(BuildContext context) async {
    return await push(context, SearchPage());
  }

  /// 跳转到：设置页面
  static Future<MaterialPageRoute> pushSettingsPage(BuildContext context) async {
    return await push(context, SettingsPage());
  }

  /// 跳转到：登录页面
  static Future<MaterialPageRoute> pushLoginPage(BuildContext context) async {
    return await push(context, LoginPage());
  }

  /// 跳转到：登录页面
  static Future<MaterialPageRoute> pushReplacementLoginPage(BuildContext context) async {
    return await pushReplacement(context, LoginPage());
  }

  /// 跳转到：登录页面
  static Future<MaterialPageRoute> pushAndRemoveUntilLoginPage(BuildContext context) async {
    return await pushAndRemoveUntil(context, LoginPage(), (router) => router == null);
  }

  /// 跳转到：注册页面
  static Future<MaterialPageRoute> pushRegisterPage(BuildContext context) async {
    return await push(context, RegisterPage());
  }

  /// 跳转到：主页面
  static Future<MaterialPageRoute> pushMainPage(BuildContext context) async {
    return await push(context, MainPage());
  }

  /// 跳转到：主页面
  static Future<MaterialPageRoute> pushReplacementMainPage(BuildContext context) async {
    return await pushReplacement(context, MainPage());
  }

  /// 跳转到：主页面
  static Future<MaterialPageRoute> pushAndRemoveUntilMainPage(BuildContext context) async {
    return await pushAndRemoveUntil(context, MainPage(), (router) => router == null);
  }

  /// 跳转到：关于页面
  static Future<MaterialPageRoute> pushAboutPage(BuildContext context) async {
    return await push(context, AboutPage());
  }

  /// 跳转到：我的收藏页面
  static Future<MaterialPageRoute> pushMyCollectionsPage(BuildContext context) async {
    return await push(context, MyCollectionsPage());
  }

  /// 跳转到：模板页面
  static Future<MaterialPageRoute> pushTemplatePage(BuildContext context) async {
    return await push(context, TemplatePage());
  }

  /// 跳转到：常用网站页面
  static Future<MaterialPageRoute> pushFriendWebsitePage(BuildContext context) async {
    return await push(context, FriendWebsitePage());
  }

  /// 跳转到：通用网页页面
  /// 
  /// - 参数 [title] 是网页标题
  /// - 参数 [url] 是网页链接
  static Future<MaterialPageRoute> pushWebPage(BuildContext context, 
      String title, String url) async {
    return await push(context, WebPage(title: title, url: url));
  }
  
  /// 跳转到：体系文章列表页面
  /// 
  /// - 参数 [title] 是体系具体分支的 title
  /// - 参数 [cid] 是体系具体分支的 id
  static Future<MaterialPageRoute> pushSystemArticlesPage(BuildContext context, 
      String title, int cid) async {
    return await push(context, SystemArticlesPage(title: title, cid: cid));
  }

  /// 跳转到：微信公众号文章列表页面
  static Future<MaterialPageRoute> pushWxChapterArticlesPage(BuildContext context, 
      String chapterName, int chapterId) async {
    return await push(context, 
      WxChapterArticlesPage(chapterName: chapterName, chapterId: chapterId));
  }

  /// 跳转到：项目列表页面
  static Future<MaterialPageRoute> pushProjectListPage(BuildContext context, 
      String projectTreeName, int projectTreeId) async {
    return await push(context, 
      ProjectListPage(projectTreeName: projectTreeName, projectTreeId: projectTreeId));
  }

  /// 跳转到：设置头像地址页面
  static Future<MaterialPageRoute> pushSettingAvatarPage(BuildContext context) async {
    return await push(context, SettingAvatarPage());
  }
}