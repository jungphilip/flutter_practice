import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  WebViewController? controller;

  HomeScreen({super.key});

  void _onTapHome() {
    if (controller == null) {
      return;
    } else {
      controller!.loadUrl('https://github.com/jungphilip');
    }
  }

  void _onTapBack() {
    if (controller == null) {
      return;
    } else {
      controller!.goBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF161B22),
          title: GestureDetector(
            onTap: _onTapHome,
            child: const Text('GitHub'),
          ),
          leading: IconButton(
            onPressed: _onTapBack,
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: _onTapHome,
                  icon: const Icon(Icons.home),
                ),
              ],
            ),
          ],
        ),
        body: WebView(
          onWebViewCreated: (WebViewController controller) {
            this.controller = controller;
          },
          initialUrl: 'https://github.com/jungphilip',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
