
import 'package:flutter/material.dart';
import 'package:wan/pages/about/about_page.dart';
import 'package:wan/pages/board/white_board_page.dart';
import 'package:wan/pages/collections/my_collections_page.dart';
import 'package:wan/pages/friend/friend_website_page.dart';
import 'package:wan/pages/login/login_page.dart';
import 'package:wan/pages/project_list/project_list_page.dart';
import 'package:wan/pages/register/register_page.dart';
import 'package:wan/pages/search/search_page.dart';
import 'package:wan/pages/settings/settings_page.dart';
import 'package:wan/pages/system_articles/system_articles_page.dart';
import 'package:wan/pages/template/template_page.dart';
import 'package:wan/pages/web/web_page.dart';
import 'package:wan/pages/wx_chapter_articles/wx_chapter_articles.dart';

class WRouter {

  /// 跳转到：白板页面
  static void gotoWhiteBoardPage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return WhiteBoardPage();
    }));
  }

  /// 跳转到：搜索页面
  static void gotoSearchPage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return SearchPage();
    }));
  }

  /// 跳转到：设置页面
  static void gotoSettingsPage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return SettingsPage();
    }));
  }

  /// 跳转到：登录页面
  static void gotoLoginPage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return LoginPage();
    }));
  }

  /// 跳转到：注册页面
  static void gotoRegisterPage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return RegisterPage();
    }));
  }

  /// 跳转到：关于页面
  static void gotoAboutPage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return AboutPage();
    }));
  }

  /// 跳转到：我的收藏页面
  static void gotoMyCollectionsPage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return MyCollectionsPage();
    }));
  }

  /// 跳转到：模板页面
  static void gotoTemplatePage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return TemplatePage();
    }));
  }

  /// 跳转到：常用网站页面
  static void gotoFriendWebsitePage(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return FriendWebsitePage();
    }));
  }

  /// 跳转到：通用网页页面
  /// 
  /// - 参数 [title] 是网页标题
  /// - 参数 [url] 是网页链接
  static void gotoWebPage(BuildContext context, String title, String url) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return WebPage(title: title, url: url,);
    }));
  }
  
  /// 跳转到：体系文章列表页面
  /// 
  /// - 参数 [title] 是体系具体分支的 title
  /// - 参数 [cid] 是体系具体分支的 id
  static void gotoSystemArticlesPage(BuildContext context, String title, int cid) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return SystemArticlesPage(title: title, cid: cid);
    }));
  }

  /// 跳转到：微信公众号文章列表页面
  static void gotoWxChapterArticlesPage(BuildContext context, String chapterName, int chapterId) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return WxChapterArticlesPage(chapterName: chapterName, chapterId: chapterId);
    }));
  }

  /// 跳转到：项目列表页面
  static void gotoProjectListPage(BuildContext context, String projectTreeName, int projectTreeId) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ProjectListPage(projectTreeName: projectTreeName, projectTreeId: projectTreeId);
    }));
  }
}