// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:bookshelf/entity/book_detail_entity.dart';
import 'package:bookshelf/entity/book_shelf_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;

void main() {
  final baseUrl = 'https://api.itbook.store/1.0';
  test('http getSearchBook 통신 테스트', () async {
    var response = await http.get('$baseUrl/search/mongodb');

    expect(response.statusCode, 200);
    BookShelf result = BookShelf.fromJson(json.decode(response.body));
    expect(result.error, "0");
  });

  test('http getBookDetail 통신 테스트', () async {
    var response = await http.get('$baseUrl/books/1001591779911');
    expect(response.statusCode, 200);
    BookDetail result = BookDetail.fromJson(json.decode(response.body));
    expect(result.error, '0');
  });
}
