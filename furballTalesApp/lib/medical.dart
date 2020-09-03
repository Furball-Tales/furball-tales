import 'package:flutter/material.dart';
import './ItemCard.dart';
import 'package:flutter/services.dart';

class Medical extends StatefulWidget {
  @override
  _MedicalState createState() => _MedicalState();
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

class _MedicalState extends State<Medical> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text(
                      'Please input new notes😊',
                      style: TextStyle(fontSize: 15),
                    ),
                    content: TextField(
                      autofocus: true,
                      inputFormatters: [ItemNameInputField()],
                    ),
                    actions: [
                      FlatButton(
                        onPressed: addCardButtonPressed,
                        textColor: Colors.cyan[400],
                        child: const Text('Send'),
                      ),
                    ],
                  ));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.cyanAccent[400],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(40.40),
          child: Row(
            children: [
              Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://cdn0.iconfinder.com/data/icons/healthcare-medicine/512/first_help_bag-512.png'),
                      ))),
              Container(
                child: Text(
                  'History of hospital visits',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return _items[index];
          },
          itemCount: _items.length,
        ),
      ]),
    );
  }
}
