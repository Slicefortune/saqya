import 'dart:async';
import 'dart:developer';

import 'package:donation_app/resources/app_colors.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyPages extends StatefulWidget {
  const PolicyPages({super.key, required this.url, required this.title});
  final String url;
  final String title;

  @override
  State<PolicyPages> createState() => _PolicyPagesState();
}

class _PolicyPagesState extends State<PolicyPages> {
  late WebViewController controller;

  FutureOr<NavigationDecision> onNavigationRequest(NavigationRequest request) {
    log("NavigationRequest.....${request.url}");
    if (request.url.startsWith('https://www.youtube.com/')) {
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  @override
  void initState() {

    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: AppText(widget.title, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18)),
        backgroundColor: AppTheme.primaryColor,

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: HtmlWidget(widget.url),
      ),
      // body: WebViewWidget(controller: controller),
    );
  }
}
