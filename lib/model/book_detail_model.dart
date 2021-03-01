import 'dart:async';

import 'package:bookshelf/entity/book_detail_entity.dart';
import 'package:bookshelf/repository/api_result.dart';
import 'package:bookshelf/repository/book_repository.dart';

import 'package:flutter/cupertino.dart';

class BookDetailModel extends ChangeNotifier {
  BookRepository _bookRepository = BookRepository();
  ApiResult<BookDetail> _resultBookDetail;
  BookDetail _bookDetail;
  String _noteText;

  final _noteTextController = StreamController<String>.broadcast();

  BookDetailModel() {
    _noteTextController.stream.listen((noteText) {
      _noteText = noteText;
      notifyListeners();
    });
  }

  ApiResult<BookDetail> get resultBookDetail => _resultBookDetail;

  BookDetail get bookDetail => _bookDetail;

  String get noteMemo => _noteText;

  Sink get inputNoteText => _noteTextController;

  Future loadBookDetail(String isbn13) async {
    _resultBookDetail = ApiResult.loading();
    notifyListeners();

    try {
      final result = await _bookRepository.getBookDetail(isbn13);
      _resultBookDetail = ApiResult.completed(result);
      _bookDetail = result;
      notifyListeners();
    } catch (e) {
      _resultBookDetail = ApiResult.error(e);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _noteTextController.close();
    super.dispose();
  }
}
