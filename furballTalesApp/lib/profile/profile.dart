import 'package:flutter/material.dart';
import '../sign_in.dart';
import '../login_page.dart';
import 'about.dart';
import 'donation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../frontend_settings.dart';

var accentBlue = NeumorphicCardSettings.accentBlue;
var accentPink = NeumorphicCardSettings.accentPink;
var accentYellow = NeumorphicCardSettings.accentYellow;
var accentGold = NeumorphicCardSettings.accentGold;

var intensity = NeumorphicCardSettings.intensity;
var depth = NeumorphicCardSettings.depth;
var surfaceIntensity = NeumorphicCardSettings.surfaceIntensity;
var baseColor = NeumorphicCardSettings.baseColor;

var buttonIntensity = NeumorphicButtonSettings.buttonIntensity;
var buttonDepth = NeumorphicButtonSettings.buttonDepth;
var buttonSurfaceIntensity = NeumorphicButtonSettings.buttonSurfaceIntensity;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: 'Flutter Neumorphic',
      home: Profile(),
    );
  }
}

class Profile extends StatelessWidget {
  // var accentBlue = 0xff00E5FF;
  // var accentPink = 0xffFF1996;
  // var accentGold = 0xffD4BF15;

  Widget _buildButton({String text, int color, VoidCallback onClick}) {
    return NeumorphicButton(
      margin: EdgeInsets.only(bottom: 27),
      padding: EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(12),
          ),
          border: NeumorphicBorder(
            isEnabled: false,
            width: 0.1,
          ),
          shape: NeumorphicShape.convex,
          depth: buttonDepth,
          intensity: buttonIntensity,
          surfaceIntensity: buttonSurfaceIntensity,
          color: Color(baseColor)),
      child: Center(
        child: NeumorphicText(
          text,
          style: NeumorphicStyle(
            depth: 2, //customize depth here
            color: Color(color), //customize color here
          ),
          textStyle: NeumorphicTextStyle(fontSize: 20 //customize size here
              // AND others usual text style properties (fontFamily, fontWeight, ...)
              ),
        ),
      ),
      onPressed: onClick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      child: Scaffold(
        backgroundColor: Color(baseColor),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/profile_background.png"),
                fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 47,
                          backgroundImage: NetworkImage('$image'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 8),
                          child: Text(
                            '$name',
                            style: TextStyle(
                              // fontFamily: 'SourceSansPro',
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
                            // fontFamily: 'SourceSansPro',
                            color: Colors.grey[500],
                            // letterSpacing: 2.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 50.0,
                  //   width: 200,
                  //   child: Divider(
                  //     color: Colors.teal[200],
                  //   ),
                  // ),
                  //   this is about page-----------------------------------------
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 200,
                      right: 100,
                      left: 100,
                    ),
                    child: Column(
                      children: [
                        _buildButton(
                          text: "About Us",
                          color: accentBlue,
                          onClick: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return About();
                            }));
                          },
                        ),
                        _buildButton(
                          text: "Donation",
                          color: accentGold,
                          onClick: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Donation();
                            }));
                          },
                        ),
                        _buildButton(
                          text: "Logout",
                          color: accentPink,
                          onClick: () {
                            signOutGoogle();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }), ModalRoute.withName('/'));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
