import 'package:flutter/material.dart';
import './Dashboard/dashboard.dart';
import 'medical.dart';
import './profile/profile.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'albums/albums.dart';
import './app_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Colors.grey[50],
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Homepage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Dashboard(),
    Albums(),
    Medical(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: NeumorphicIcon(
              Icons.home,
              size: 30,
            ),
            title: Container(height: 12.0),
          ),
          BottomNavigationBarItem(
            icon: NeumorphicIcon(
              Icons.perm_media,
              size: 30,
            ),
            title: Container(height: 12.0),
          ),
          BottomNavigationBarItem(
            icon: NeumorphicIcon(
              Icons.local_hospital,
              size: 30,
            ),
            title: Container(height: 12.0),
          ),
          BottomNavigationBarItem(
            icon: NeumorphicIcon(
              Icons.perm_identity,
              size: 30,
            ),
            title: Container(height: 12.0),
          ),
        ],
        selectedItemColor: Color(0xff00b8d4),
        unselectedItemColor: Colors.grey[600],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
