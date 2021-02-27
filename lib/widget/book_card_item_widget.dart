import 'package:bookshelf/routes.dart';
import 'package:bookshelf/screen/book_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookCardItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String subtitle;
  final String price;
  final String isbn13;
  final String url;

  BookCardItem(
      {this.title,
      this.imageUrl,
      this.subtitle,
      this.price,
      this.isbn13,
      this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.bookDetail,
          arguments: BookDetailArgs(
            title: title,
            imageUrl: imageUrl,
            isbn13: isbn13,
          ),
        );
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: title,
              child: Image.network(
                imageUrl,
                width: 100,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      // result.data[index].title,
                      title,
                      overflow: TextOverflow.ellipsis,
                      // textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // result.data[index].subtitle == ''
                  subtitle == ''
                      ? Text('Subtitle is Empty')
                      : Text(
                          subtitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(price),
                      const SizedBox(width: 16),
                      Expanded(child: Text(isbn13)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RaisedButton(
                    onPressed: _launchURL,
                    child: Text('Go to WebSite'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
