import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:news_app/core/shemmer.dart';
import 'package:news_app/view/screens/responsive/news_responsive.dart';
import 'package:news_app/view/screens/responsive/screens_format/tab_layout.dart';
import 'package:news_app/view/screens/responsive/screens_format/web_layout.dart';

import 'view/screens/home_page.dart';
import 'view_model/services/api_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage());
  }
}
