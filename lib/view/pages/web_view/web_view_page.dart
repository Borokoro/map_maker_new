import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/view/shared_components/widgets/back_app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage(name: "WebViewRoute")
class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.title, required this.url});

  final String title;
  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  static const String _allowedScheme = "https";
  static const List<String> _externalSchemes = ["https", "http", "mailto", "tel"];

  late final Uri _initialUri = Uri.parse(widget.url);
  late final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (_) => _setLoading(true),
        onPageFinished: (_) => _setLoading(false),
        onNavigationRequest: _onNavigationRequest,
      ),
    )
    ..loadRequest(_initialUri);

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBarWidget(title: widget.title),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) ...{
            const Center(child: CircularProgressIndicator(color: ColorConstants.bgBrand)),
          },
        ],
      ),
    );
  }

  NavigationDecision _onNavigationRequest(NavigationRequest request) {
    final Uri? uri = Uri.tryParse(request.url);
    if (uri == null) return NavigationDecision.prevent;
    if (_isAllowedInWebView(uri)) return NavigationDecision.navigate;
    if (request.isMainFrame && _externalSchemes.contains(uri.scheme)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return NavigationDecision.prevent;
  }

  bool _isAllowedInWebView(Uri uri) {
    return uri.scheme == _allowedScheme && uri.host == _initialUri.host;
  }

  void _setLoading(bool isLoading) {
    if (!mounted) return;
    setState(() => _isLoading = isLoading);
  }
}
