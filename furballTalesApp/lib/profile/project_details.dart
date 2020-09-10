import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../frontend_settings.dart';

var baseColor = NeumorphicCardSettings.baseColor;

class ProjectDet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: GradientAppBar(
        "Our Project",
        true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 75.0,
                backgroundImage: AssetImage('assets/logo.png'),
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
                'Our app FurBallTales manages all of the medical information for your pet. That includes medication reminders, food tracking, grooming, ear and teeth cleaning, various measurements like weight and height, and, of course, vaccinations. You can also get reminders for upcoming vet appointments. It keeps track of this stuff so you don’t have to. The app is also completely free with no in-app purchases or ads.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
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
