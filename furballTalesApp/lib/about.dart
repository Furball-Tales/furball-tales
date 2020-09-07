import 'package:flutter/material.dart';
import 'profile.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About FurBallTales'),
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
                  height: 30,
                  margin: EdgeInsets.all(5),
                  child: Text(
                    'OUR MISSION',
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
                    'Strengthening the bond of owners and pets, more than ever',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Entry C')),
          ),
        ],
      ),
    );
  }
}
