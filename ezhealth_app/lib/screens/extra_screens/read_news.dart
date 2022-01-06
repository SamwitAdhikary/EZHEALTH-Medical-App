import 'package:ezhealth_app/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadNews extends StatefulWidget {
  final String url;
  final String title;
  ReadNews(this.url, this.title);

  @override
  _ReadNewsState createState() => _ReadNewsState(url, title);
}

class _ReadNewsState extends State<ReadNews> {
  final String url;
  final String title;
  _ReadNewsState(this.url, this.title);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Palette.scaffoldColor,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
