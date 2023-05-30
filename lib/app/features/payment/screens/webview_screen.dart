import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/values/strings.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({Key? key, required this.initUrl}) : super(key: key);
  final String initUrl;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  final viewController = WebViewController();

  @override
  void initState() {
    viewController.loadRequest(Uri.parse(widget.initUrl));
    viewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    viewController.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {},
        onPageFinished: (url) {
          if (url.contains(
              "$api_url/account/deposit/confirm")) {
            Get.back(result: true);
          }
          if (url.contains(
              "$api_url/payment/confirm")) {
            Get.back(result: true);
          }
          if (url.contains(
              "$api_url/account/withdraw/confirm")) {
            Get.back(result: true);
          }
        },
        onProgress: (progress) {},
        onWebResourceError: (error) {},
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller: viewController,
      ),
    );
  }
}
