import 'package:flutter/material.dart';
import 'package:furballTalesApp/profile/project_details.dart';
import 'team.dart';
import '../app_bar.dart';
import '../frontend_settings.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

var baseColor = NeumorphicCardSettings.baseColor;
var accentBlue = NeumorphicCardSettings.accentBlue;
var accentPink = NeumorphicCardSettings.accentPink;
var accentYellow = NeumorphicCardSettings.accentYellow;
var accentGold = NeumorphicCardSettings.accentGold;
var textBaseColor = NeumorphicCardSettings.textBaseColor;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: About(),
    );
  }
}

_buildButton({String text, int color, VoidCallback onClick}) =>
    BuildButton().buildButton;

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        "About Us",
        'back',
      ),
      backgroundColor: Color(baseColor),
      body: NeumorphicTheme(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 24),
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/about_us.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 100,
                    left: 100,
                  ),
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 8.0),
                      //   child: NeumorphicText(
                      //     "Our Project",
                      //     style: NeumorphicStyle(
                      //       depth: 4, //customize depth here
                      //       color: Color(accentGold), //customize color here
                      //     ),
                      //     textStyle: NeumorphicTextStyle(
                      //         fontSize: 27,
                      //         fontWeight: FontWeight.bold //customize size here
                      //         // AND others usual text style properties (fontFamily, fontWeight, ...)
                      //         ),
                      //   ),
                      // ),
                      _buildButton()(
                        text: "Our Project",
                        color: accentGold,
                        onClick: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProjectDet();
                              },
                            ),
                          );
                        },
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 100,
                    left: 100,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: NeumorphicText(
                          "Our Team",
                          style: NeumorphicStyle(
                            depth: 4, //customize depth here
                            color: Color(accentGold), //customize color here
                          ),
                          textStyle: NeumorphicTextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold //customize size here
                              // AND others usual text style properties (fontFamily, fontWeight, ...)
                              ),
                        ),
                      ),
                      _buildButton()(
                        text: "☺Ayumi Funaki",
                        color: textBaseColor,
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Ayumi();
                          }));
                        },
                        bottom: 20.0,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      _buildButton()(
                        text: "☺Jimmy Wilson",
                        color: textBaseColor,
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Jimmy();
                          }));
                        },
                        bottom: 20.0,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      _buildButton()(
                        text: "☺Mukhtar Otarbayev",
                        color: textBaseColor,
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Mukhtar();
                          }));
                        },
                        bottom: 20.0,
                        fontSize: 14.6,
                        fontWeight: FontWeight.bold,
                      ),
                      _buildButton()(
                        text: "☺Ryohei Mizuho",
                        color: textBaseColor,
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Ryohei();
                          }));
                        },
                        bottom: 20.0,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      _buildButton()(
                        text: "☺Yuta Nomoto",
                        color: textBaseColor,
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Yuta();
                          }));
                        },
                        bottom: 20.0,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
