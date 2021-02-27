import 'package:bookshelf/entity/book_detail_entity.dart';
import 'package:bookshelf/model/book_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
          return Center(
            child: Column(
              children: [
                GestureDetector(
                  child: Hero(
                    tag: widget.title,
                    child: Image.network(widget.imageUrl),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                Stack(
                  children: [
                    bookDetail == null
                        ? CircularProgressIndicator()
                        : Column(
                            children: [
                              Text('title : ${bookDetail?.title}'),
                              Text('subtitle : ${bookDetail.subtitle}'),
                              Text('authors : ${bookDetail.authors}'),
                              Text('publisher : ${bookDetail.publisher}'),
                              Text('language : ${bookDetail.language}'),
                              Text('isbn10 : ${bookDetail.isbn10}'),
                              Text('isbn13 : ${bookDetail.isbn13}'),
                              Text('pages : ${bookDetail.pages}'),
                              Text('year : ${bookDetail.year}'),
                              Text('rating: ${bookDetail.rating}'),
                              Text('desc : ${bookDetail.desc}'),
                              Text('price: ${bookDetail.price}'),
                              RaisedButton(
                                  onPressed: () => _launchURL(bookDetail.url),
                                  child: Text('URL'))
                            ],
                          ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
