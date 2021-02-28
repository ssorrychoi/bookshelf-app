import 'package:bookshelf/common/send_bird_keys.dart';
import 'package:bookshelf/entity/books_entity.dart';
import 'package:bookshelf/model/search_model.dart';
import 'package:bookshelf/repository/api_result.dart';
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: const Key(SendBirdKeys.searchTextFieldFinder),
                    controller: _searchController,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.search,
                    enabled: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onTap: () => _model.changeSearchClicked(true),
                    onFieldSubmitted: (text) {
                      if (text.trim().isEmpty) {
                        _model.changeSearchClicked(false);
                      } else {
                        _model.searchBook(text);
                        _model.changeSearchClicked(false);
                      }
                    },
                  ),
                ),
                Selector<SearchModel, bool>(
                  selector: (context, data) => data.isSearchClicked,
                  builder: (context, isSearchClicked, _) {
                    return isSearchClicked
                        ? Container(
                            width: 70,
                            child: FlatButton(
                                onPressed: () => _searchController.clear(),
                                child: Text(
                                  'Clear',
                                  key: const Key(SendBirdKeys.clearButton),
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        : Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          _model.changeSearchClicked(false);
        },
        child: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 20,
                  )
                ]),
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
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                        delegate: SliverChildListDelegate(
                          [
                            const SizedBox(height: 40),
                            Center(
                                child: Text(
                              'Thank you for giving me this opportunity :)',
                              key: const Key(SendBirdKeys.mainSentence),
                            )),
                          ],
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
