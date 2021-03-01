import 'package:bookshelf/entity/book_detail_entity.dart';
import 'package:bookshelf/model/book_detail_model.dart';
import 'package:bookshelf/repository/api_result.dart';
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
  TextEditingController _userNoteController = TextEditingController();
  BookDetailModel _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = Provider.of<BookDetailModel>(context, listen: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _userNoteController.dispose();
    super.dispose();
  }

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
          return SingleChildScrollView(
            child: GestureDetector(
              onTap: () =>
                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        child: Hero(
                          tag: widget.title,
                          child: Image.network(widget.imageUrl),
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    TextField(
                      controller: _userNoteController,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.newline,
                      enabled: true,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'You can note something...',
                        contentPadding: const EdgeInsets.all(8),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        prefixIcon: Icon(Icons.edit),
                      ),
                      onChanged: (text) {
                        _model.inputNoteText.add(text);
                      },
                    ),
                    const SizedBox(height: 12),
                    Selector<BookDetailModel, String>(
                      selector: (context, data) => data.noteMemo,
                      builder: (context, noteMemo, _) {
                        return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(noteMemo ?? 'User write memo'));
                      },
                    ),
                    const SizedBox(height: 24),
                    Stack(
                      children: [
                        Selector<BookDetailModel, ApiResult<BookDetail>>(
                          selector: (context, data) => data.resultBookDetail,
                          builder: (context, result, _) {
                            switch (result?.status) {
                              case Status.COMPLETED:
                                return BookDetailTable(
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
                                );

                              case Status.ERROR:
                                return Text(result.error.toString());
                              case Status.LOADING:
                              default:
                                return CircularProgressIndicator();
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
