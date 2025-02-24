import 'dart:developer';

import 'package:flutter/cupertino.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenlayout;

  final Widget tabScreenlayout;
  final Widget mobileScreenlayout;
  ResponsiveLayout({
    super.key,
    required this.webScreenlayout,
    required this.tabScreenlayout,
    required this.mobileScreenlayout,
  });

  @override
  Widget build(BuildContext context) {
    log("Media query is= ${MediaQuery.sizeOf(context).width}");
    return LayoutBuilder(builder: (context, width) {
      if (width.maxWidth > 1101) {
        return webScreenlayout;
      } else if (width.maxWidth > 600 && width.maxWidth <= 1100) {
        return tabScreenlayout;
      } else {
        return mobileScreenlayout;
      }
    });
  }
}
