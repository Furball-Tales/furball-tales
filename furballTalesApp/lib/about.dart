import 'package:flutter/material.dart';
import 'package:furballTalesApp/project_details.dart';
import 'profile.dart';
import 'team.dart';
import 'project_details.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About FurBallTales',
          style: TextStyle(
              fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent[400],
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
            )),
      ),
      body: ListView(
        //padding: const EdgeInsets.all(1),
        children: <Widget>[
          Container(
            height: 80,
            width: 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/mission.png'),
                fit: BoxFit.fill,
              ),
              // shape: BoxShape.circle,
            ),
          ),
          Center(
              heightFactor: 1.2,
              child: Text(
                'Strengthening the bond of owners and pets, more than ever...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent[700],
                  wordSpacing: 8,
                ),
              )),
          Divider(
            color: Colors.cyanAccent[700],
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Center(
              child: Container(
                  width: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    child: Text('About Project'.toUpperCase(),
                        style: TextStyle(fontSize: 20.0)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectDet()));
                    },
                    color: Colors.cyan,
                    textColor: Colors.white,
                    splashColor: Colors.grey,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  ))),
          Divider(
            height: 20,
            color: Colors.cyanAccent[700],
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Center(
              child: Column(children: <Widget>[
            Text(
              'Our Team'.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                wordSpacing: 8,
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                width: 200.0,
                height: 50.0,
                child: RaisedButton(
                  child: Text('Ayumi Funaki', style: TextStyle(fontSize: 20.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Ayumi()));
                  },
                  color: Colors.cyan,
                  textColor: Colors.white,
                  splashColor: Colors.grey,
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                )),
            Container(
                margin: EdgeInsets.all(10),
                width: 200.0,
                height: 50.0,
                child: RaisedButton(
                  child: Text('Yuta Nomoto', style: TextStyle(fontSize: 20.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Yuta()));
                  },
                  color: Colors.cyan,
                  textColor: Colors.white,
                  splashColor: Colors.grey,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                )),
            Container(
                margin: EdgeInsets.all(10),
                width: 200.0,
                height: 50.0,
                child: RaisedButton(
                  child:
                      Text('Ryohei Mizuho', style: TextStyle(fontSize: 20.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Ryohei()));
                  },
                  color: Colors.cyan,
                  textColor: Colors.white,
                  splashColor: Colors.grey,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                )),
            Container(
                margin: EdgeInsets.all(10),
                width: 200.0,
                height: 50.0,
                child: RaisedButton(
                  child: Text('Jimmy Wilson', style: TextStyle(fontSize: 20.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Jimmy()));
                  },
                  color: Colors.cyan,
                  textColor: Colors.white,
                  splashColor: Colors.grey,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                )),
            Container(
                margin: EdgeInsets.all(10),
                width: 200.0,
                height: 50.0,
                child: RaisedButton(
                  child: Text('Mukhtar Otarbayev',
                      style: TextStyle(fontSize: 20.0)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Mukhtar()));
                  },
                  color: Colors.cyan,
                  textColor: Colors.white,
                  splashColor: Colors.grey,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                )),
          ]))
        ],
      ),
    );
  }
}
