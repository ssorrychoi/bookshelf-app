import 'package:flutter/material.dart';

class BookDetailRow extends StatelessWidget {
  final String setting;
  final String result;

  BookDetailRow({this.setting, this.result});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 100,
            child: Text(
              setting,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              result,
            ),
          ),
        ],
      ),
    );
  }
}
