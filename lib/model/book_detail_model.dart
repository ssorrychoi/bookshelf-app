import 'package:bookshelf/entity/book_detail_entity.dart';
import 'package:bookshelf/repository/api_result.dart';
import 'package:bookshelf/repository/book_repository.dart';

import 'package:flutter/cupertino.dart';

class BookDetailModel extends ChangeNotifier {
  BookRepository _bookRepository = BookRepository();
  ApiResult<BookDetail> _resultBookDetail;
  BookDetail _bookDetail;

  ApiResult<BookDetail> get resultBookDetail => _resultBookDetail;

  BookDetail get bookDetail => _bookDetail;

  Future loadBookDetail(String isbn13) async {
    _resultBookDetail = ApiResult.loading();
    notifyListeners();

    try {
      final result = await _bookRepository.getBookDetail(isbn13);
      _resultBookDetail = ApiResult.completed(result);
      _bookDetail = result;
      print('model : ${result.title}');
      notifyListeners();
    } catch (e) {
      _resultBookDetail = ApiResult.error(e);
    }
  }
}
