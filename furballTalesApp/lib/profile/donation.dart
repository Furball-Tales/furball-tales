import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../frontend_settings.dart';

var baseColor = NeumorphicCardSettings.baseColor;
var textBaseColor = NeumorphicCardSettings.textBaseColor;

class Donation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(baseColor),
      appBar: GradientAppBar(
        "Donation",
        'back',
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage('assets/don_img.jpg'),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 24),
              child: Text(
                "Let's improve the life quality of our pets. Support us to make this application better.  You can reach us by contacting any team member of the project.   ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(textBaseColor),
                ),
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
