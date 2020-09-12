import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_bar.dart';

class MemoEdit extends StatelessWidget {
  String _current;
  Function _onChanged;

  MemoEdit(this._current, this._onChanged);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: GradientAppBar(
        "Quick Memo",
        'back',
      ),
      body: new Container(
          padding: const EdgeInsets.all(16.0),
          child: new TextField(
            controller: TextEditingController(text: _current),
            maxLines: 99,
            style: new TextStyle(color: Colors.black),
            onChanged: (text) {
              _current = text;
              _onChanged(_current);
            },
          )),
    );
  }
}
