import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class article_view extends StatefulWidget {
  final blogUrl;
  const article_view({Key? key, this.blogUrl}) : super(key: key);
  @override
  _article_viewState createState() => _article_viewState();
}

class _article_viewState extends State<article_view> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      body: WebView(
        onWebViewCreated: (WebViewController c) {
          _controller.complete(c);
        },
        initialUrl: widget.blogUrl,
      ),
    );
  }
}
