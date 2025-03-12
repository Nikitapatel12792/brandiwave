import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TwitterLoginPage extends StatefulWidget {
  @override
  _TwitterLoginPageState createState() => _TwitterLoginPageState();
}

class _TwitterLoginPageState extends State<TwitterLoginPage> {
  late final WebViewController _controller;

  final String callbackUrl =
      "https://yourdomain.com/twitter-callback"; // Change this

  @override
  void initState() {
    super.initState();

    // Initialize WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.contains(callbackUrl)) {
            Uri uri = Uri.parse(request.url);
            String? oauthToken = uri.queryParameters['oauth_token'];
            String? oauthVerifier = uri.queryParameters['oauth_verifier'];

            if (oauthToken != null && oauthVerifier != null) {
              print("OAuth Token: $oauthToken");
              print("OAuth Verifier: $oauthVerifier");

              // Close WebView & return data
              Navigator.pop(
                  context, {'token': oauthToken, 'verifier': oauthVerifier});
            }
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ));

    _startTwitterLogin();
  }

  Future<void> _startTwitterLogin() async {
    final twitterAuthUrl =
        "https://api.twitter.com/oauth/authenticate?oauth_token=YOUR_OAUTH_TOKEN";

    if (await canLaunch(twitterAuthUrl)) {
      await launch(twitterAuthUrl);
    } else {
      throw 'Could not launch Twitter login';
    }

    _controller.loadRequest(Uri.parse(twitterAuthUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Twitter Login")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
