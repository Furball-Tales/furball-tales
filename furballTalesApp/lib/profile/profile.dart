import 'package:flutter/material.dart';
import '../sign_in.dart';
import '../login_page.dart';
import 'about.dart';
import 'donation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../frontend_settings.dart';
import '../tutorial_slider.dart';

var accentBlue = NeumorphicCardSettings.accentBlue;
var accentPink = NeumorphicCardSettings.accentPink;
var accentYellow = NeumorphicCardSettings.accentYellow;
var accentGold = NeumorphicCardSettings.accentGold;

var intensity = NeumorphicCardSettings.intensity;
var depth = NeumorphicCardSettings.depth;
var surfaceIntensity = NeumorphicCardSettings.surfaceIntensity;
var baseColor = NeumorphicCardSettings.baseColor;
var textBaseColor = NeumorphicCardSettings.textBaseColor;
var logoutRed = NeumorphicCardSettings.logoutRed;

var buttonIntensity = NeumorphicButtonSettings.buttonIntensity;
var buttonDepth = NeumorphicButtonSettings.buttonDepth;
var buttonSurfaceIntensity = NeumorphicButtonSettings.buttonSurfaceIntensity;

_buildButton({String text, int color, VoidCallback onClick}) =>
    BuildButton().buildButton;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: Profile(),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Color(baseColor),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/profile_background.png"),
              fit: BoxFit.cover),
        ),
        child: NeumorphicTheme(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 47,
                            backgroundImage: NetworkImage('$image'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 30.0, bottom: 8),
                            child: Text(
                              '$name',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyanAccent[700],
                              ),
                            ),
                          ),
                          Text(
                            '$email',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500],
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        right: 100,
                        left: 100,
                      ),
                      child: Column(
                        children: [
                          _buildButton()(
                            text: "About",
                            color: textBaseColor,
                            onClick: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return About();
                                  },
                                ),
                              );
                            },
                            fontWeight: FontWeight.bold,
                          ),
                          _buildButton()(
                            text: "App Tutorial",
                            color: textBaseColor,
                            onClick: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return TutorialSlider("Tutorial");
                                  },
                                ),
                              );
                            },
                            fontWeight: FontWeight.bold,
                          ),
                          _buildButton()(
                            text: "Donation",
                            color: textBaseColor,
                            onClick: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Donation();
                                  },
                                ),
                              );
                            },
                            fontWeight: FontWeight.bold,
                          ),
                          _buildButton()(
                            text: "Logout",
                            color: logoutRed,
                            onClick: () {
                              signOutGoogle();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                builder: (context) {
                                  return LoginPage();
                                },
                              ), ModalRoute.withName('/'));
                            },
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              '©2020',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(textBaseColor),
                              ),
                            ),
                          ),
                          Text(
                            'Furball Tales',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(textBaseColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Center(
                    //   child: CircleAvatar(
                    //     radius: 20,
                    //     backgroundImage: AssetImage('assets/logo.png'),
                    //     backgroundColor: Color(baseColor),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
