import 'package:bookshelf/model/book_detail_model.dart';
import 'package:bookshelf/model/search_model.dart';
import 'package:bookshelf/screen/book_detail_screen.dart';
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
      case Routes.bookDetail:
        final BookDetailArgs args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => BookDetailModel()..loadBookDetail(args.isbn13),
            child: BookDetailScreen(
              title: args.title,
              isbn13: args.isbn13,
              imageUrl: args.imageUrl,
            ),
          ),
        );
    }
    return null;
  }
}
