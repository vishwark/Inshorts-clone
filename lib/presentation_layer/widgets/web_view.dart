import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_clone/business_layer/cubit/offset_cubit.dart';
import 'package:inshorts_clone/business_layer/cubit/current_page_source_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late final WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      );
    // Access initial URL state
    final initialUrl = context.read<CurrentPageSourceCubit>().state.uri;
    if (initialUrl.isNotEmpty) {
      controller.loadRequest(Uri.parse(initialUrl));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.cancel)),
      ),
      body: BlocListener<CurrentPageSourceCubit, CurrentPageUriState>(
        listener: (context, state) {
          final url = state.uri;
          if (url.isNotEmpty) {
            controller.loadRequest(Uri.parse(url));
          }
        },
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
