import 'package:flutter/material.dart';
import '../sign_in.dart';
import '../login_page.dart';
import 'about.dart';
import 'donation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
  var accentBlue = 0xff00E5FF;
  var accentPink = 0xffFF1996;
  var accentYellow = 0xffD4BF15;

  Widget _buildButton({String text, int color, VoidCallback onClick}) {
    return NeumorphicButton(
      margin: EdgeInsets.only(bottom: 10),
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
          depth: 1.5,
          intensity: 0.7,
          surfaceIntensity: 0.1,
          color: Colors.grey[200]),
      child: Center(
        child: NeumorphicText(
          text,
          style: NeumorphicStyle(
            depth: 2, //customize depth here
            color: Color(color), //customize color here
          ),
          textStyle: NeumorphicTextStyle(
              fontSize: 24, fontWeight: FontWeight.bold //customize size here
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
        backgroundColor: Colors.grey[200],
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/profile_background.png"),
                fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSxDoD5caxFUy_dn0w6wl01m882CeJHNVOCRg&usqp=CAU'),
                  ),
                  Text(
                    '<$name>',
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    '<$email>',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SourceSansPro',
                      color: Colors.red[400],
                      letterSpacing: 2.5,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: 200,
                    child: Divider(
                      color: Colors.teal[200],
                    ),
                  ),
                  //   this is about page-----------------------------------------
                  _buildButton(
                    text: "Our Team",
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
                    color: accentYellow,
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
          ),
        ),
      ),
    );
  }
}
