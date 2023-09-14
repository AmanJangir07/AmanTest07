import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/view/basewidget/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpecificationScreen extends StatelessWidget {
  final String specification;
  SpecificationScreen({required this.specification});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      body: Column(children: [
        CustomAppBar(title: getTranslated('specification', context)),
        Expanded(child: Html(data: specification)
            /*  WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(specification))}',
        ) */
            ),
      ]),
    );
  }
}
