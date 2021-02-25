// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:bookshelf/entity/book_shelf_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bookshelf/main.dart';
import 'package:http/http.dart' as http;

void main() {
  test('http 통신 테스트', () async {
    var response =
        await http.get('https://api.itbook.store/1.0/search/mongodb');

    expect(response.statusCode, 200);
    BookShelf result = BookShelf.fromJson(json.decode(response.body));
    expect(result.error, "0");
  });
}
