import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({
    super.key,
    this.url,
    this.html,
  });
  final String? url;
  final String? html;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xffffffff))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('Page progress: $progress');
          },
          onPageStarted: (String url) {
            // App.showLoading();
            debugPrint('Page onPageStarted: $url');
          },
          onPageFinished: (String url) {
            double fullWidth =
                MediaQuery.of(context).size.width; // Full screen width
            print("fullWidth $fullWidth");
            double physicalWidth = MediaQuery.of(context).size.width *
                MediaQuery.of(context).devicePixelRatio;
            print("physicalWidth $physicalWidth");

            double currentWidth = 611.999991; // Current element width
            double scaleFactor = physicalWidth / currentWidth - 0.2;
            // print(scaleFactor);
            // debugPrint('Page finished loading: $url');
            controller
                ?.runJavaScript('document.body.style.zoom = "$scaleFactor";');
            // App.hideLoading();
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Page onHttpError error: $error');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Page onWebResourceError error: $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );
    if (widget.html != null) {
      //
      controller?.loadHtmlString(widget.html ?? "");
    }
    if (widget.url != null) {
      //
      controller?.loadRequest(Uri.parse(widget.url ?? ""));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.clearLocalStorage();
    controller?.clearCache();
    debugPrint('ProcessWebview dispose:');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thư mời tư vấn",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: context.myTheme.textThemeT1.title.copyWith(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.mainColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
      body: Container(
        child: controller != null
            ? WebViewWidget(
                controller: controller!,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
