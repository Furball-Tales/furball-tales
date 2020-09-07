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
import 'fourth_nav.dart';

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

  double get w => MediaQuery.of(context).size.width;
  double get h => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Furball Tales'),
          backgroundColor: Colors.cyanAccent[400],
        ),
        backgroundColor: Colors.grey[300],
        body: _children[_currentIndex],
        bottomNavigationBar: Container(
          child: Container(
            width: w,
            height: h / 4,
            color: Colors.grey[300],
            child: FourthNav(w: w),
          ),
          // BottomNavigationBar(
          //   onTap: onTabTapped,
          //   currentIndex: _currentIndex,
          //   items: <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   icon: NeumorphicIcon(
          //     Icons.home,
          //     size: 30,
          //   ),
          //   title: Container(height: 12.0),
          // ),
          //     BottomNavigationBarItem(
          //       icon: NeumorphicIcon(
          //         Icons.perm_media,
          //         size: 30,
          //       ),
          //       title: Container(height: 12.0),
          //     ),
          //     BottomNavigationBarItem(
          //       icon: NeumorphicIcon(
          //         Icons.local_hospital,
          //         size: 30,
          //       ),
          //       title: Container(height: 12.0),
          //     ),
          //     BottomNavigationBarItem(
          //       icon: NeumorphicIcon(
          //         Icons.perm_identity,
          //         size: 30,
          //       ),
          //       title: Container(height: 12.0),
          //     ),
          //   ],
          //   selectedItemColor: Color(0xff00b8d4),
          //   unselectedItemColor: Colors.grey[600],
          // ),
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
