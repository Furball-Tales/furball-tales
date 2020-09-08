import 'package:flutter/material.dart';
import '../sign_in.dart';
import '../login_page.dart';
import 'about.dart';
import 'donation.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About()));
                },
                child: Card(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.help,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        'About',
                        style:
                            TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Donation()));
                },
                child: Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.monetization_on,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      'Donation',
                      style: TextStyle(fontSize: 20.0, fontFamily: 'Neucha'),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }), ModalRoute.withName('/'));
                },
                child: Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      'LOGOUT',
                      style: TextStyle(fontSize: 20.0, fontFamily: 'Neucha'),
                    ),
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
