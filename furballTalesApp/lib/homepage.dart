import 'package:flutter/material.dart';
import './ItemCard.dart';
import 'package:flutter/services.dart';
import 'placeholder_widget.dart';
import 'dashboard.dart';

void main() => runApp(MaterialApp(home: Homepage()));

class Homepage extends StatefulWidget {
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

class _MyAppState extends State<Homepage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Dashboard(),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green),
    PlaceholderWidget(Colors.blue)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Furball Tales'),
          backgroundColor: Colors.cyanAccent[400],
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,
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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
