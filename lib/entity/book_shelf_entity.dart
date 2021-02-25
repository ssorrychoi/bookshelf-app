import 'package:bookshelf/entity/books_entity.dart';

class BookShelf {
  String error;
  String total;
  String page;
  List<Books> books;

  BookShelf({this.error, this.total, this.page, this.books});

  BookShelf.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    total = json['total'];
    page = json['page'];
    if (json['books'] != null) {
      books = new List<Books>();
      json['books'].forEach((v) {
        books.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['total'] = this.total;
    data['page'] = this.page;
    if (this.books != null) {
      data['books'] = this.books.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
