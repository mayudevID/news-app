import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({super.key, required this.newsModelDatum});
  final Datum newsModelDatum;

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(widget.newsModelDatum.link!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.newsModelDatum.title!,
        ),
      ),
      backgroundColor: Colors.white,
      body: WebViewWidget(controller: controller),
    );
  }
}
