import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


/// 通用 Web 页面
class WebPage extends StatefulWidget {

  final String title;
  final String url;

  WebPage({this.title, this.url});

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  bool isLoading = false;

  final webViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    webViewPlugin.onStateChanged.listen((state){
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoading = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        elevation: 0.4,
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: isLoading ? LinearProgressIndicator() : Divider(
            height: 1.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}