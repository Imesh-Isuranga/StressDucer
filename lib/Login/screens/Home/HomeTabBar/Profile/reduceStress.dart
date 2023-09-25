import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/Transition/maintransition.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReduceStress extends StatefulWidget {
  const ReduceStress({Key? key}) : super(key: key);

  @override
  State<ReduceStress> createState() => _ReduceStressState();
}

class _ReduceStressState extends State<ReduceStress> {
  bool _isLoading = true;

  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            // Page starts loading, set isLoading to true
            Future.delayed(Duration.zero, () {
              if (mounted) {
                setState(() {
                  _isLoading = true;
                });
              }
            });
          },
          onPageFinished: (String url) {
            // Page finished loading, set isLoading to false
            Future.delayed(Duration.zero, () {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            });
          },
        ),
      )
      ..loadRequest(Uri.parse("https://www.health.harvard.edu/staying-healthy/top-ways-to-reduce-daily-stress"));
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? const TextTransitionNew() : Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: WebViewWidget(
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }
}
