import 'package:bookshelf/entity/books_entity.dart';
import 'package:bookshelf/repository/api_result.dart';
import 'package:bookshelf/repository/book_repository.dart';
import 'package:flutter/cupertino.dart';

class SearchModel extends ChangeNotifier {
  BookRepository _bookRepository = BookRepository();
  ApiResult<List<Books>> _resultBooks;
  List<Books> _bookList = [];
  String _paging = '1';

  bool _isSearchClicked = false;

  ApiResult<List<Books>> get resultBooks => _resultBooks;

  List<Books> get bookList => _bookList;

  bool get isSearchClicked => _isSearchClicked;

  String get paging => _paging;

  Future searchBook(String bookName, {String paging}) async {
    _resultBooks = ApiResult.loading();
    notifyListeners();

    try {
      print('clicked model');
      final result =
          await _bookRepository.getSearchBook(bookName, paging: paging);
      print(result);
      _resultBooks = ApiResult.completed(result.books);
      _paging = (int.parse(result.page) + 1).toString();
      _bookList = result.books;
      notifyListeners();
    } catch (e) {
      _resultBooks = ApiResult.error(e);
    }
  }

  void changeSearchClicked(bool value) {
    _isSearchClicked = value;
    notifyListeners();
  }
}
