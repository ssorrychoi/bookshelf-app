import 'package:bookshelf/entity/books_entity.dart';
import 'package:bookshelf/repository/api_result.dart';
import 'package:bookshelf/repository/book_repository.dart';
import 'package:flutter/cupertino.dart';

class SearchModel extends ChangeNotifier {
  BookRepository _bookRepository = BookRepository();
  ApiResult<List<Books>> _resultBooks;
  List<Books> _bookList = [];
  String _paging = '1';
  bool _isMoreLoading = false;

  bool _isSearchClicked = false;

  ApiResult<List<Books>> get resultBooks => _resultBooks;

  List<Books> get bookList => _bookList;

  bool get isSearchClicked => _isSearchClicked;

  String get paging => _paging;

  bool get isMoreLoading => !_isMoreLoading;

  Future searchBook(String bookName, {String paging}) async {
    _resultBooks = ApiResult.loading();
    notifyListeners();

    try {
      final result =
          await _bookRepository.getSearchBook(bookName, paging: paging);
      _resultBooks = ApiResult.completed(result.books);
      _paging = (int.parse(result.page) + 1).toString();
      _bookList = result.books;
      notifyListeners();
    } catch (e) {
      _resultBooks = ApiResult.error(e);
      notifyListeners();
    }
  }

  void changeSearchClicked(bool value) {
    _isSearchClicked = value;
    notifyListeners();
  }

  Future addBooks(String bookName) async {
    _isMoreLoading = true;
    notifyListeners();
    try {
      final result =
          await _bookRepository.getSearchBook(bookName, paging: _paging);
      _bookList.addAll(result.books);
      _paging = (int.parse(result.page) + 1).toString();
      notifyListeners();
    } catch (e) {
      if (e is ApiException) {
        _resultBooks = ApiResult.error(e);
      }
    } finally {
      _isMoreLoading = false;
      notifyListeners();
    }
  }
}
