import 'package:bookshelf/entity/book_detail_entity.dart';
import 'package:bookshelf/model/book_detail_model.dart';
import 'package:bookshelf/widget/book_detail_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailArgs {
  final String title;
  final String isbn13;
  final String imageUrl;

  BookDetailArgs({this.title, this.isbn13, this.imageUrl});
}

class BookDetailScreen extends StatefulWidget {
  final String title;
  final String isbn13;
  final String imageUrl;

  BookDetailScreen({this.title, this.isbn13, this.imageUrl});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Selector<BookDetailModel, BookDetail>(
        selector: (context, data) => data.bookDetail,
        builder: (context, bookDetail, _) {
          return
              // Center(
              // child:
              SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    child: Hero(
                      tag: widget.title,
                      // ),
                      child: Image.network(widget.imageUrl),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Stack(
                  children: [
                    bookDetail == null
                        ? CircularProgressIndicator()
                        : BookDetailTable(
                            title: bookDetail.title,
                            subtitle: bookDetail.subtitle,
                            authors: bookDetail.authors,
                            publisher: bookDetail.publisher,
                            language: bookDetail.language,
                            isbn10: bookDetail.isbn10,
                            isbn13: bookDetail.isbn13,
                            pages: bookDetail.pages,
                            year: bookDetail.year,
                            rating: bookDetail.rating,
                            desc: bookDetail.desc,
                            price: bookDetail.price,
                            url: bookDetail.url,
                          )
                  ],
                ),
              ],
            ),
            // ),
          );
        },
      ),
    );
  }
}
