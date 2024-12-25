import 'dart:async';
import 'dart:developer';

import 'package:donation_app/controller/app_config_controller.dart';
import 'package:donation_app/repository/api_urls.dart';
import 'package:donation_app/resources/app_colors.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'success_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.paymentUrl});
  final String paymentUrl;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late WebViewController controller;

  FutureOr<NavigationDecision> onNavigationRequest(NavigationRequest request) {
    log("NavigationRequest.....${request.url}");
    _pageRedirect(request.url);
    _pageRedirect(request.url);
    if (request.url.startsWith('https://www.youtube.com/')) {
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  void _pageRedirect(String url) {
    print('--------URL------${url}');
    bool isSuccess = url.contains('success') || url.contains('approved');
    bool isFailed = url.contains('fail') || url.contains('error');
    bool isCancel = url.contains('cancel');
    if (isFailed || isCancel) {
      if (mounted) {
        Get.back();
        return;
      }
    }
    if (isSuccess) {
      print('--------APPROVED------${url}');

      Get.to(() => SuccessScreen());
    }
  }

  RxDouble progress = 0.0.obs;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int pp) {
            double p = pp / 100;
            if (p > progress.value) {
              progress.value = p;
              setState(() {});
            }
            log("progress....  ${progress}");
          },
          onPageStarted: (String url) {
            log("onPageStarted....   ${url}");
            _pageRedirect(url);
          },
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: onNavigationRequest,
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
    // if(kDebugMode){
    //   Future.delayed(5.seconds).then((v){
    //     Get.to(()=> SuccessScreen());
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: AppText("Complete Payment",style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18)),
        backgroundColor: AppTheme.primaryColor,

      ),
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Stack(
          children: [
            Positioned.fill(child: WebViewWidget(controller: controller)),
            if (progress.value < .9)
              Positioned.fill(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
          ],
        ),
      ),
    );
  }
}
