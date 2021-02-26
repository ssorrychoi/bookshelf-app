import 'package:bookshelf/model/search_model.dart';
import 'package:bookshelf/screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes {
  static const main = '/';
  static const home = '/home';
  static const bookDetail = '/bookDetail';
}

class RouteGenerator {
  RouteGenerator();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.main:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => SearchModel(),
            child: SearchScreen(),
          ),
        );
    }
    return null;
  }
}
