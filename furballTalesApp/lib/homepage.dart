import 'package:flutter/material.dart';
import 'placeholder_widget.dart';
import 'dashboard.dart';
import 'profile.dart';

void main() => runApp(MaterialApp(home: Homepage()));

class Homepage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Homepage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Dashboard(),
    PlaceholderWidget(Colors.blue),
    PlaceholderWidget(Colors.green),
    Profile()
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
          onTap: onTabTapped,
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
          selectedItemColor: Colors.cyanAccent[400],
          unselectedItemColor: Colors.grey[600],
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
