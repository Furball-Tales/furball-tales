import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../frontend_settings.dart';

import '../frontend_settings.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

var baseColor = NeumorphicCardSettings.baseColor;
var accentBlue = NeumorphicCardSettings.accentBlue;
var accentPink = NeumorphicCardSettings.accentPink;
var accentYellow = NeumorphicCardSettings.accentYellow;
var accentGold = NeumorphicCardSettings.accentGold;

class ProjectDet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
        backgroundColor: Color(baseColor),
        appBar: GradientAppBar(
          "Furball Tales Way",
          true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 25, right: 25, bottom: 24),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/mission_ship.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: NeumorphicText(
                          "Our Vision",
                          style: NeumorphicStyle(
                            depth: 4, //customize depth here
                            color: Colors.white, //customize color here
                          ),
                          textStyle: NeumorphicTextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold //customize size here
                              // AND others usual text style properties (fontFamily, fontWeight, ...)
                              ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                                left: 24.0, right: 16.0, bottom: 16.0),
                            width: c_width,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Becoming a leading and lasting company in the pet app industry.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: NeumorphicText(
                          "Our Mission",
                          style: NeumorphicStyle(
                            depth: 4, //customize depth here
                            color: Colors.white, //customize color here
                          ),
                          textStyle: NeumorphicTextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold //customize size here
                              // AND others usual text style properties (fontFamily, fontWeight, ...)
                              ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                                left: 24.0, right: 16.0, bottom: 16.0),
                            width: c_width,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Strengthening the bond of owners and pets, more than ever.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: NeumorphicText(
                          "Our Value",
                          style: NeumorphicStyle(
                            depth: 4, //customize depth here
                            color: Colors.white, //customize color here
                          ),
                          textStyle: NeumorphicTextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold //customize size here
                              // AND others usual text style properties (fontFamily, fontWeight, ...)
                              ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                                left: 24.0, right: 16.0, bottom: 16.0),
                            width: c_width,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    "- Becoming a leading and lasting company in the pet app industry.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    "- Tackle and accomplish anything, even if it seems challenging.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                ),
                                Text(
                                  "- Make full use of the latest updates in design and innovation.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 24, bottom: 8.0),
                            child: NeumorphicText(
                              "Our Product",
                              style: NeumorphicStyle(
                                depth: 4, //customize depth here
                                color: Colors.white, //customize color here
                              ),
                              textStyle: NeumorphicTextStyle(
                                  fontSize: 27,
                                  fontWeight:
                                      FontWeight.bold //customize size here
                                  // AND others usual text style properties (fontFamily, fontWeight, ...)
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 25, right: 25, bottom: 24),
                            child: Container(
                              height: 180,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/logo.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 24.0, right: 16.0, bottom: 16.0),
                            width: c_width,
                            child: Text(
                              "Our app FurBallTales manages all of the medical information for your pet.That includes medication reminders, food tracking, grooming, ear and teeth cleaning, various measurements like weight and height, and, of course, vaccinations. You can also get reminders for upcoming vet appointments. It keeps track of this stuff so you don’t have to. The app is also completely free with no in-app purchases or ads.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
