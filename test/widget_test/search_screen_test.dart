import 'package:bookshelf/common/send_bird_keys.dart';
import 'package:bookshelf/model/search_model.dart';
import 'package:bookshelf/screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('Search Screen Widget Test', () {
    final thanksForSendBird = find.byKey(Key(SendBirdKeys.mainSentence));
    final searchTextField = find.byKey(Key(SendBirdKeys.searchTextFieldFinder));
    final clearBtn = find.byKey(Key(SendBirdKeys.clearButton));
    final bookCard = find.byKey(Key(SendBirdKeys.bookCard));

    final String book = 'book';

    testWidgets('구성요소 Test', (tester) async {
      await tester.pumpWidget(_TestSearchScreen());
      await tester.pump();

      expect(thanksForSendBird, findsOneWidget);
      expect(searchTextField, findsOneWidget);
      expect(clearBtn, findsNothing);
    });

    testWidgets('clear Button 존재 여부', (tester) async {
      await tester.pumpWidget(_TestSearchScreen());
      await tester.pump();

      await tester.tap(searchTextField);
      await tester.pump();

      expect(clearBtn, findsOneWidget);
    });

    testWidgets('TextFormField & clearButton 기능', (tester) async {
      await tester.pumpWidget(_TestSearchScreen());
      await tester.pump();

      await tester.tap(searchTextField);
      await tester.enterText(searchTextField, book);

      expect(find.text(book), findsOneWidget);

      await tester.tap(clearBtn);
      expect(find.text(book), findsNothing);
    });
  });
}

class _TestSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => SearchModel(),
        child: SearchScreen(),
      ),
    );
  }
}
