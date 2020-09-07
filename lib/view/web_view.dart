import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import '../model/color_pallete.dart';

class WebView extends StatefulWidget {
  final String url;
  final String newsSourceName;

  WebView(this.url, this.newsSourceName);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        backgroundColor: CssColor().defaultBarBackground,
        title: Text(widget.newsSourceName),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Share.share(widget.url);
            },
          ),
        ],
      ),
      url: widget.url,
    );
  }
}
