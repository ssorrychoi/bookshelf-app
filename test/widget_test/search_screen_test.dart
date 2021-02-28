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

    testWidgets('구성요소 Test', (tester) async {
      await tester.pumpWidget(_TestSearchScreen());
      await tester.pump();

      expect(thanksForSendBird, findsOneWidget);
      expect(searchTextField, findsOneWidget);
      expect(clearBtn, findsNothing);
    });

    testWidgets('clear Button 존재여부', (tester) async {
      await tester.pumpWidget(_TestSearchScreen());
      await tester.pump();

      await tester.tap(searchTextField);
      await tester.pump();

      expect(clearBtn, findsOneWidget);
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
