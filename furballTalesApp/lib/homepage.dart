import 'package:flutter/material.dart';
import './ItemCard.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
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

class _MyAppState extends State<MyApp> {
  List<Widget> list = <Widget>[
    Container(child: ItemCard()),
  ];

  List<Widget> _items = <Widget>[];

  @override
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Furball Tales'),
          backgroundColor: Colors.cyanAccent[400],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Please input your AWESOME new item 🤣'),
                      content: TextField(
                        autofocus: true,
                        inputFormatters: [ItemNameInputField()],
                      ),
                      actions: [
                        RaisedButton(
                          onPressed: addCardButtonPressed,
                          child: const Text('Send'),
                        ),
                      ],
                    ));
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
          backgroundColor: Colors.cyanAccent[400],
        ),
        body: Column(
          children: [
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(40.40),
                  child: Container(
                      width: 115.0,
                      height: 115.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSxDoD5caxFUy_dn0w6wl01m882CeJHNVOCRg&usqp=CAU'),
                          ))),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.10),
                        child: Text(
                          'Good Morning, Sir.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Card(
                          child: Container(
                            height: 100,
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 4,
                                ),
                                Text('Name: Benjamin'),
                                Text('Sex: ♂'),
                                Text('Age: 3 months'),
                                Text('Weight: 15 kg'),
                              ],
                            ),
                          ),
                          elevation: 5),
                    ],
                  ),
                ),
              ],
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return _items[index];
              },
              itemCount: _items.length,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_media),
              title: Text('Photos'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              title: Text('Medical'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
              title: Text('Profile'),
            ),
          ],
          // currentIndex: _selectedIndex,
          selectedItemColor: Colors.cyanAccent[400],
          unselectedItemColor: Colors.grey[600],
          // onTap: _onItemTapped,
        ),
      ),
    );
  }
}
