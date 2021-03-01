import 'dart:convert';
import 'dart:io';

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
      print(response.statusCode);
      if (response.statusCode == 200) {
        return BookShelf.fromJson(json.decode(response.body));
      } else if (response.statusCode < 500) {
        throw ApiException({'code': '${response.statusCode}'});
      } else {
        throw ApiException({'code': '${response.statusCode}'});
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException({'code': '502'});
    }
  }

  Future<BookDetail> getBookDetail(String isbn13) async {
    try {
      final response = await http.get('$baseUrl/books/$isbn13');

      if (response.statusCode < 400) {
        return BookDetail.fromJson(json.decode(response.body));
      } else if (response.statusCode < 500) {
        throw ApiException({'code': '${response.statusCode}'});
      } else {
        throw ApiException({'code': '${response.statusCode}'});
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException({'code': '502'});
    }
  }
}
