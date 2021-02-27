import 'package:flutter/material.dart';

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
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            // result.data[index]?.image,
            imageUrl,
            width: 100,
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
                        // result.data[index].subtitle,
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        // textAlign: TextAlign.start,
                      ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Text(result.data[index].price),
                    Text(price),
                    const SizedBox(width: 16),
                    // Expanded(child: Text(result.data[index].isbn13)),
                    Expanded(child: Text(isbn13)),
                    Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text('Link'))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
