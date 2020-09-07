import 'package:flutter/material.dart';
import './ItemCard.dart';
import 'package:flutter/services.dart';
import './memo.dart';
import './grid_dashboard.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class ItemNameInputField extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    final newTextLength = newText.length;

    if (newText == '0') {
      return oldValue;
    }

    return newValue;
  }
}

class _DashboardState extends State<Dashboard> {
  List<Widget> list = <Widget>[
    Container(child: ItemCard()),
  ];

  List<Widget> _items = <Widget>[];

  void initState() {
    super.initState();
    _items = list;
  }

  void addCardButtonPressed() {
    list.add(
      Container(child: ItemCard()),
    );

    setState(() {
      _items = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(child: GridDashboard()),
          Container(height: 60, child: MemoList())
        ],
      ),
    );
  }
}
