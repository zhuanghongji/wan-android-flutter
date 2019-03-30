import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wan/base/base_page.dart';


/// 通用 Web 页面
class WebPage extends BasePage {
  final String title;
  final String url;

  WebPage({this.title, this.url});

  @override
  BasePageState<BasePage> getPageState() => _WebPageState();
}

class _WebPageState extends BasePageState<WebPage> {
  final _webViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    _webViewPlugin.onStateChanged.listen((state){
      if (state.type == WebViewState.finishLoad) {
        showContent();
      } else if (state.type == WebViewState.startLoad) {
        showLoading();
      }
    });
  }

  @override
  Widget buildAppBar() {
    return AppBar(
      elevation: 0.4,
      title: Text(widget.title),
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}