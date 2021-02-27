import 'dart:convert';

import 'package:bookshelf/entity/book_detail_entity.dart';
import 'package:bookshelf/entity/book_shelf_entity.dart';
import 'package:http/http.dart' as http;

class BookRepository {
  final String baseUrl = 'https://api.itbook.store/1.0';

  @override
  Future<BookShelf> getSearchBook(String bookName, {String paging}) async {
    String query = bookName;
    if (paging != null) {
      query = '$bookName/$paging';
    }
    try {
      final response = await http.get('$baseUrl/search/$query');
      print(response.body);
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

  @override
  Future<BookDetail> getBookDetail(String isbn13) async {
    try {
      final response = await http.get('$baseUrl/books/$isbn13');

      if (response.statusCode == 200) {
        print(BookDetail.fromJson(json.decode(response.body)).title);
        return BookDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception(json.decode(response.body)['error']);
      }
    } catch (e) {
      throw Exception();
    }
  }
}
