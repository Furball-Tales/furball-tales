import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Memo {
  String id;
  String text;
  DateTime date;

  Memo({
    @required this.id,
    @required this.text,
    @required this.date,
  });
}

class MemoData {
  final List<Memo> memos = [
    Memo(
      id: 'm1',
      text: 'New Shoes',
      date: DateTime.now(),
    ),
    Memo(
      id: 'm2',
      text: 'Weekly Groceries',
      date: DateTime.now(),
    ),
  ];
}
