import 'package:bookshelf/entity/book_shelf_entity.dart';
import 'package:bookshelf/entity/books_entity.dart';
import 'package:bookshelf/model/search_model.dart';
import 'package:bookshelf/repository/api_result.dart';
import 'package:bookshelf/repository/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchModel _model;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = Provider.of(context, listen: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
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
                    // return Text('hello');
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          // return Text(result.data[index]?.title);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Card(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.network(
                                    result.data[index]?.image,
                                    width: 100,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                            result.data[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            // textAlign: TextAlign.start,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        result.data[index].subtitle == ''
                                            ? Text('Subtitle is Empty')
                                            : Text(
                                                result.data[index].subtitle,
                                                overflow: TextOverflow.ellipsis,
                                                // textAlign: TextAlign.start,
                                              ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(result.data[index].price),
                                            const SizedBox(width: 16),
                                            Expanded(
                                                child: Text(
                                                    result.data[index].isbn13)),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text('Link'))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: result?.data?.length,
                      ),
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
