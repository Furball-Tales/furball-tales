import 'package:flutter/material.dart';
import 'dashboard/dashboard.dart';
import 'profile/profile.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'medical/medical.dart';
import 'albums/albums.dart';
import './frontend_settings.dart';
import './calendar/calendar_main.dart';
import 'frontend_settings.dart';

var baseColor = NeumorphicCardSettings.baseColor;

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
        depth: 5,
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
    Calendar(),
    MedicalDetail(),
    //Medical(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(baseColor),
      body: _children[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Color(baseColor),
        ),
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        // primaryColor: Colors.red,
        // textTheme: Theme.of(context).textTheme.copyWith(
        //     caption: new TextStyle(
        //         color: Colors
        //             .yellow))), // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: NeumorphicIcon(
                Icons.home,
                size: 30,
                style: NeumorphicStyle(
                  intensity: 1.0,
                  depth: 2,
                  color: Color(baseColor),
                ),
              ),
              title: Container(height: 12.0),
            ),
            BottomNavigationBarItem(
              icon: NeumorphicIcon(
                Icons.perm_media,
                size: 30,
                style: NeumorphicStyle(
                  intensity: 1.0,
                  depth: 2,
                  color: Color(baseColor),
                ),
              ),
              title: Container(height: 12.0),
            ),
            BottomNavigationBarItem(
              icon: NeumorphicIcon(
                Icons.date_range,
                size: 30,
                style: NeumorphicStyle(
                  intensity: 1.0,
                  depth: 2,
                  color: Color(baseColor),
                ),
              ),
              title: Container(height: 12.0),
            ),
            BottomNavigationBarItem(
              icon: NeumorphicIcon(
                Icons.local_hospital,
                size: 30,
                style: NeumorphicStyle(
                  intensity: 1.0,
                  depth: 2,
                  color: Color(baseColor),
                ),
              ),
              title: Container(height: 12.0),
            ),
            BottomNavigationBarItem(
              icon: NeumorphicIcon(
                Icons.perm_identity,
                size: 30,
                style: NeumorphicStyle(
                  intensity: 1.0,
                  depth: 2,
                  color: Color(baseColor),
                ),
              ),
              title: Container(height: 12.0),
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
