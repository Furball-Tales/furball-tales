import 'package:flutter/material.dart';
import 'profile.dart';

class Donation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation'),
        backgroundColor: Colors.cyanAccent[400],
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return Profile();
              }), ModalRoute.withName('/profile'));
            },
            child: Icon(
              Icons.arrow_back,
            )),
      ),
      body: ListView(
        padding: const EdgeInsets.all(2),
        children: <Widget>[
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(height: 200.0),
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Image.asset(
                    "assets/don_img.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 30,
                  margin: EdgeInsets.all(5),
                  child: Text(
                    'DONATION',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.tealAccent[400]),
                  ),
                ),
                Container(
                  height: 25,
                  margin: EdgeInsets.all(5),
                  child: Text(
                    'We need more money for our project',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
