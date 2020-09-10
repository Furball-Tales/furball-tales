import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../frontend_settings.dart';

var baseColor = NeumorphicCardSettings.baseColor;

class Donation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(baseColor),
      appBar: GradientAppBar(
        "Donation",
        true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 120.0,
                backgroundImage: AssetImage('assets/don_img.jpg'),
              ),
            ),
            Divider(
              height: 40,
              color: Colors.orange[900],
              thickness: 2,
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "Let's improve the life quality of our pets. Support us to make this application better.  You can reach us by contacting any team member of the project.   ",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
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
