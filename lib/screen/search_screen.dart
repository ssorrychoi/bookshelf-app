import 'package:bookshelf/entity/book_shelf_entity.dart';
import 'package:bookshelf/entity/books_entity.dart';
import 'package:bookshelf/model/search_model.dart';
import 'package:bookshelf/repository/api_result.dart';
import 'package:bookshelf/repository/book_repository.dart';
import 'package:bookshelf/widget/book_card_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchModel _model;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _scrollThreshold = 50.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = Provider.of(context, listen: false);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold && _model.isMoreLoading) {
      _model.addBooks(_searchController.text);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _searchController,
                          textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            // filled: true,
                            // fillColor: Colors.white,
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.search),
                          ),
                          onTap: () => _model.changeSearchClicked(true),
                          onFieldSubmitted: (text) {
                            _model.searchBook(text);
                            _scrollController.jumpTo(0);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Selector<SearchModel, ApiResult<List<Books>>>(
              selector: (context, data) => data.resultBooks,
              builder: (context, result, _) {
                final addingBookList = _model.bookList;

                switch (result?.status) {
                  case Status.COMPLETED:
                    if (result.data.isEmpty) {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const SizedBox(height: 24),
                            Text(
                              'No Result',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    }
                    return Selector<SearchModel, bool>(
                      selector: (context, data) => data.isMoreLoading,
                      builder: (context, isMoreLoading, _) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index >= addingBookList.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 12),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              // return Text(result.data[index]?.title);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: BookCardItem(
                                  title: result.data[index].title,
                                  subtitle: result.data[index].subtitle,
                                  imageUrl: result.data[index].image,
                                  price: result.data[index].price,
                                  isbn13: result.data[index].isbn13,
                                  url: result.data[index].url,
                                ),
                              );
                            },
                            childCount: isMoreLoading
                                ? addingBookList.length
                                : addingBookList.length + 1,
                            // childCount: addingBookList.length + 1,
                            // childCount: addingBookList.length,
                          ),
                        );
                      },
                    );
                  case Status.ERROR:
                  case Status.LOADING:
                    return SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: 24),
                        Center(child: CircularProgressIndicator()),
                      ]),
                    );
                  default:
                    return SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: 40),
                        Center(child: Text('Welcome to Send Bird!')),
                      ]),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
