import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'custom_overlay.dart';
import 'widget/loading_widget.dart';

class ProcessWebviewDialog {
  ProcessWebviewDialog._();
  static final instance = ProcessWebviewDialog._();

  CustomOverlay? overlay;

  void show(BuildContext contextOverlay, String url,
      Function(String urlFinish) onFinish) {
    overlay = CustomOverlay(
      context: contextOverlay,
      child: ProcessWebview(
        url: url,
        onDone: (urlFinish) {
          debugPrint('ProcessWebview onDone');
          onFinish.call(urlFinish);
        },
      ),
      barrierDismissible: false,
      isProcessDialog: true,
    );
    overlay?.showOverlay();
  }

  void hide() {
    overlay?.hideOverlay();
    overlay = null;
  }

  void openGoogleMapRoadToUrlAddress(String url) {
    ProcessWebviewDialog.instance.show(Get.overlayContext!, url, (url) async {
      ///
      await openGoogleMapsLink(url);
      // if (rs == true) {
      ProcessWebviewDialog.instance.hide();
      // }
    });
  }
}

class ProcessWebview extends StatefulWidget {
  const ProcessWebview({
    super.key,
    required this.url,
    this.onDone,
  });
  final String url;
  final Function(String url)? onDone;

  @override
  State<ProcessWebview> createState() => _ProcessWebviewState();
}

class _ProcessWebviewState extends State<ProcessWebview> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
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
            debugPrint('Page finished loading: $url');
            widget.onDone?.call(url);
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
      )
      ..loadRequest(Uri.parse(widget.url));
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
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Container(
    //     child: controller != null
    //         ? WebViewWidget(
    //             controller: controller!,
    //           )
    //         : const SizedBox.shrink(),
    //   ),
    // );

    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          controller != null
              ? Opacity(
                  opacity: 0,
                  child: WebViewWidget(
                    controller: controller!,
                  ),
                )
              : const SizedBox.shrink(),
          const Align(alignment: Alignment.center, child: AppLoadingWidget())
        ],
      ),
    );
  }
}

Future<bool?> openGoogleMapsLink(String shortUrl) async {
  try {
    // Check if the request redirected to a full Google Maps URL
    print('shortUrl   $shortUrl');
    final redirectedUrl = shortUrl;

    // Step 2: Extract latitude and longitude from the redirected URL
    final latLonRegex = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
    final match = latLonRegex.firstMatch(redirectedUrl);

    if (match != null) {
      final destLat = double.parse(match.group(1)!);
      final destLon = double.parse(match.group(2)!);

      // Step 3: Construct a Google Maps directions URL
      final directionsUrl = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&origin=&destination=$destLat,$destLon',
      );
      print('directionsUrl found $directionsUrl');
      // Step 4: Open the Google Maps directions URL
      // if (await canLaunchUrl(directionsUrl)) {
      launchUrl(directionsUrl, mode: LaunchMode.externalApplication);
      return true;
      // } else {
      //   launchUrl(Uri.parse(shortUrl), mode: LaunchMode.externalApplication);
      //   print('Could not launch Google Maps directions URL');
      // }
    } else {
      launchUrl(Uri.parse(shortUrl), mode: LaunchMode.externalApplication);
      print('No coordinates found in the redirected URL');
    }
  } catch (e) {
    launchUrl(Uri.parse(shortUrl), mode: LaunchMode.externalApplication);
    print('Error: $e');
  }
  return false;
}
