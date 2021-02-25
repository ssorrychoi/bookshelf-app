import 'package:bookshelf/repository/book_repository.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  BookRepository bookRepository = BookRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: Column(
        children: [
          FlatButton(
            onPressed: () async {
              print('clicked GET');
              bookRepository.getSearchBook();
              // print('res : $res');
            },
            child: Text(
              'GET',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.pink,
          )
        ],
      ),
    );
  }
}
