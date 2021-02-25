import 'dart:convert';

import 'package:bookshelf/entity/book_shelf_entity.dart';
import 'package:http/http.dart' as http;

class BookRepository {
  final String baseUrl = 'https://api.itbook.store/1.0/search/mongoDB';

  @override
  Future<BookShelf> getSearchBook() async {
    try {
      final response = await http.get('$baseUrl');
      if (response.statusCode == 200) {
        print(BookShelf.fromJson(json.decode(response.body)).total);
        return BookShelf.fromJson(json.decode(response.body));
      } else {
        throw Exception(json.decode(response.body)['error']);
      }
    } catch (e) {
      throw Exception();
    }
  }
}
