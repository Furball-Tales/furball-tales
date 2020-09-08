import 'package:flutter/material.dart';
import '../sign_in.dart';
import '../login_page.dart';
import 'about.dart';
import 'donation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: 'Flutter Neumorphic',
      home: Profile(),
    );
  }
}

class Profile extends StatelessWidget {
  Widget _buildButton({String text, VoidCallback onClick}) {
    return NeumorphicButton(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(12),
          ),
          border: NeumorphicBorder(
            isEnabled: false,
            width: 0.1,
          ),
          shape: NeumorphicShape.flat,
          color: Colors.grey[300]),
      child: Center(
        child: NeumorphicText(
          text,
          style: NeumorphicStyle(
            depth: 4, //customize depth here
            color: Colors.white, //customize color here
          ),
          textStyle: NeumorphicTextStyle(
              fontSize: 27, fontWeight: FontWeight.bold //customize size here
              // AND others usual text style properties (fontFamily, fontWeight, ...)
              ),
        ),
      ),
      onPressed: onClick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(depth: 8),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
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
                _buildButton(
                  text: "Our Team",
                  onClick: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return About();
                    }));
                  },
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
      ),
    );
  }
}
