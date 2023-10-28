import 'dart:developer';

import 'package:ancientmysticmusic/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  late InAppWebViewController _webViewController;

  double progress = 0;

  @override
  Widget build(BuildContext context) {
    print('https://ancientmysticmusic.com/pay/${MyApp.userid}');
    print("'https://ancientmysticmusic.com/pay/${MyApp.userid}");
    return Scaffold(
      body: Stack(
        children: [
          Column(children: <Widget>[
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      'https://ancientmysticmusic.com/pay/${MyApp.userid}'),
                  // method: 'POST',
                  // body: Uint8List.fromList(
                  //   utf8.encode("user_id=${MyApp.userid}"),
                  // ),
                ),
                onWebViewCreated: (InAppWebViewController controller) async {
                  _webViewController = controller;
                },
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                onLoadStart: (controller, url) {
                  // setState(() {
                  //   this.url = url.toString();
                  //   urlController.text = this.url;
                  // });
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
                onLoadStop: (controller, url) {
                  setState(() {
                    _webViewController = controller;
                  });
                  controller.canGoBack();
                  controller.addJavaScriptHandler(
                      handlerName: 'showToast',
                      callback: (arguments) {
                        log("message data");
                        print(arguments);
                        final String data = arguments[0];
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(data),
                          duration: const Duration(seconds: 1),
                        ));
                      });

                  print('WebView finished loading: $controller');
                },
              ),
            ),
          ]),
          progress < 1.0
              ? Center(child: CircularProgressIndicator(value: progress))
              : Container(),
        ],
      ),
    );
  }
}
