import 'package:flutter/material.dart';

class Donation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          'Donation',
          style: TextStyle(
              fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent[400],
        elevation: 0.0,
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
