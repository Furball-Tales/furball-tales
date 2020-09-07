import 'package:flutter/material.dart';
import 'placeholder_widget.dart';
import 'dashboard.dart';
import 'medical.dart';
import 'profile.dart';
import 'about.dart';
import 'albums.dart';
import 'grid_dashboard.dart';
import 'package:flutter/services.Dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() => {runApp(MyApp()), SystemChrome.setEnabledSystemUIOverlays([])};

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
      home: MaterialApp(
        home: Homepage(),
      ),
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
    GridDashboard(),
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
        backgroundColor: Colors.grey[100],
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
          selectedItemColor: Color(0xff00b8d4),
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
