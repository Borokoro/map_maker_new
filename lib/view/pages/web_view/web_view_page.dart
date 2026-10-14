import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/color_constants.dart';
import 'package:map_maker_new/view/shared_components/widgets/back_app_bar_widget.dart';
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
  late final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (_) => _setLoading(true),
        onPageFinished: (_) => _setLoading(false),
      ),
    )
    ..loadRequest(Uri.parse(widget.url));

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBarWidget(title: widget.title),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator(color: ColorConstants.bgBrand)),
        ],
      ),
    );
  }

  void _setLoading(bool isLoading) {
    if (!mounted) return;
    setState(() => _isLoading = isLoading);
  }
}
