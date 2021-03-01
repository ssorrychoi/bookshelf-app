import 'package:bookshelf/widget/book_detail_row.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailTable extends StatelessWidget {
  final String title;
  final String subtitle;
  final String authors;
  final String publisher;
  final String language;
  final String isbn10;
  final String isbn13;
  final String pages;
  final String year;
  final String rating;
  final String desc;
  final String price;
  final String url;

  BookDetailTable({
    this.title,
    this.subtitle,
    this.authors,
    this.publisher,
    this.language,
    this.isbn10,
    this.isbn13,
    this.pages,
    this.year,
    this.rating,
    this.desc,
    this.price,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        BookDetailRow(
          setting: 'title',
          result: title,
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        BookDetailRow(
          setting: 'subtitle',
          result: subtitle,
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        BookDetailRow(
          setting: 'authors',
          result: authors,
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        BookDetailRow(
          setting: 'publisher',
          result: publisher,
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        BookDetailRow(
          setting: 'language',
          result: language,
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        BookDetailRow(
          setting: 'isbn10',
          result: isbn10,
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        BookDetailRow(
          setting: 'isbn13',
          result: isbn13,
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        BookDetailRow(
          setting: 'pages',
          result: pages,
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        BookDetailRow(
          setting: 'year',
          result: year,
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 100,
                child: Text(
                  'rating',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(int.parse(rating).toString()),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        BookDetailRow(
          setting: 'desc',
          result: desc,
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        BookDetailRow(
          setting: 'price',
          result: price,
        ),
        const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 44),
          child: RaisedButton(
              onPressed: () => _launchURL(url), child: Text("book's URL")),
        ),
      ],
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
