import 'dart:convert';

import 'package:bookshelf/entity/book_detail_entity.dart';
import 'package:bookshelf/entity/book_shelf_entity.dart';
import 'package:bookshelf/repository/api_result.dart';
import 'package:http/http.dart' as http;

class BookRepository {
  final String baseUrl = 'https://api.itbook.store/1.0';

  Future<BookShelf> getSearchBook(String bookName, {String paging}) async {
    String query = bookName;
    if (paging != null) {
      query = '$bookName/$paging';
    }
    try {
      final response = await http.get('$baseUrl/search/$query');
      if (response.statusCode == 200) {
        return BookShelf.fromJson(json.decode(response.body));
      } else {
        print('ERR Repo : ${response.statusCode}');
        throw Exception(json.decode(response.body)['error']);
      }
    } catch (e) {
      if (e is ApiException) rethrow;
    }
  }

  Future<BookDetail> getBookDetail(String isbn13) async {
    try {
      final response = await http.get('$baseUrl/books/$isbn13');

      if (response.statusCode == 200) {
        return BookDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception(json.decode(response.body)['error']);
      }
    } catch (e) {
      if (e is ApiException) rethrow;
    }
  }
}
