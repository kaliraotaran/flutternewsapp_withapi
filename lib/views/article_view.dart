import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogurl;
  const ArticleView({super.key, required this.blogurl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  // final controller = WebViewController()..setJavaScriptMode(JavaScriptMode.disabled)..loadRequest(Uri.parse(widget.blogurl));

  // final Completer<WebViewController> completer =Completer<WebViewController> ();
  late WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.blogurl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ezy'),
            Text(
              'News',
              style: TextStyle(
                  color: Colors.indigo[300], fontWeight: FontWeight.w700),
            )
          ],
        ),
        actions: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save)),
        ],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          // height: MediaQuery.of(context).size.height,
          height: 600,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                WebViewWidget(
                  controller: controller,
                ),
              ],
            ),
          )),
    );
  }
}
