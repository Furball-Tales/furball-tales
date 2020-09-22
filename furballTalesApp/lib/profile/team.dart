import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../frontend_settings.dart';
import 'package:url_launcher/url_launcher.dart';

var baseColor = NeumorphicCardSettings.baseColor;
var textBaseColor = NeumorphicCardSettings.textBaseColor;

class Ayumi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(baseColor),
      appBar: GradientAppBar(
        "Bio",
        'back',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50,
            bottom: 40,
          ),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 70.0,
                backgroundImage: AssetImage('assets/ayumi.jpg'),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  bottom: 30,
                ),
                child: Text(
                  'Ayumi Funaki',
                  style: TextStyle(
                    color: Color(textBaseColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'HOMETOWN',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'California, USA',
                style: TextStyle(
                  color: Color(textBaseColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'position'.toUpperCase(),
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Full-Stack Engineer',
                style: TextStyle(
                  color: Color(textBaseColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 30.0),
              InkWell(
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/github.png'),
                        width: 30.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '@Ayumi426',
                        style: TextStyle(
                          color: Color(textBaseColor),
                          fontSize: 22.0,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  onTap: () => launch('https://github.com/Ayumi426')),
            ],
          ),
        ),
      ),
    );
  }
}

class Yuta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(baseColor),
      appBar: GradientAppBar(
        "Bio",
        'back',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50,
            bottom: 40,
          ),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 70.0,
                backgroundImage: AssetImage('assets/yuta.jpg'),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  bottom: 30,
                ),
                child: Text(
                  'Yuta Nomoto',
                  style: TextStyle(
                    color: Color(textBaseColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'HOMETOWN',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Chiba, Japan',
                style: TextStyle(
                  color: Color(textBaseColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'position'.toUpperCase(),
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Full-Stack Engineer',
                style: TextStyle(
                  color: Color(textBaseColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 30.0),
              InkWell(
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/github.png'),
                        width: 30.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '@namitry',
                        style: TextStyle(
                          color: Color(textBaseColor),
                          fontSize: 22.0,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  onTap: () => launch('https://github.com/namitry')),
            ],
          ),
        ),
      ),
    );
  }
}

class Ryohei extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(baseColor),
      appBar: GradientAppBar(
        "Bio",
        'back',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50,
            bottom: 40,
          ),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 70.0,
                backgroundImage: AssetImage('assets/ryohei.jpg'),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  bottom: 30,
                ),
                child: Text(
                  'Ryohei Mizuho',
                  style: TextStyle(
                    color: Color(textBaseColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'HOMETOWN',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Kobe, Japan',
                style: TextStyle(
                  color: Color(textBaseColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'position'.toUpperCase(),
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Full-Stack Engineer',
                style: TextStyle(
                  color: Color(textBaseColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 30.0),
              InkWell(
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/github.png'),
                        width: 30.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '@Ryohei03',
                        style: TextStyle(
                          color: Color(textBaseColor),
                          fontSize: 22.0,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  onTap: () => launch('https://github.com/Ryohei03')),
            ],
          ),
        ),
      ),
    );
  }
}

class Jimmy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(baseColor),
      appBar: GradientAppBar(
        "Bio",
        'back',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50,
            bottom: 40,
          ),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 70.0,
                backgroundImage: AssetImage('assets/jimmy.jpg'),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  bottom: 30,
                ),
                child: Text(
                  'Jimmy Wilson',
                  style: TextStyle(
                    color: Color(textBaseColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'HOMETOWN',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Tauranga, New Zealand',
                style: TextStyle(
                  color: Color(textBaseColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'position'.toUpperCase(),
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Full-Stack Engineer',
                style: TextStyle(
                  color: Color(textBaseColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 30.0),
              InkWell(
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/github.png'),
                        width: 30.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '@jimmytwilson',
                        style: TextStyle(
                          color: Color(textBaseColor),
                          fontSize: 22.0,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  onTap: () => launch('https://github.com/jimmytwilson')),
            ],
          ),
        ),
      ),
    );
  }
}

class Mukhtar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(baseColor),
      appBar: GradientAppBar(
        "Bio",
        'back',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50,
            bottom: 40,
          ),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 70.0,
                backgroundImage: AssetImage('assets/mukhtar.jpg'),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  bottom: 30,
                ),
                child: Text(
                  'Mukhtar Otarbayev',
                  style: TextStyle(
                    color: Color(textBaseColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'HOMETOWN',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Almaty, Kazakhstan',
                style: TextStyle(
                  color: Color(textBaseColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'position'.toUpperCase(),
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Full-Stack Engineer',
                style: TextStyle(
                  color: Color(textBaseColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 30.0),
              InkWell(
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/github.png'),
                        width: 30.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '@MukhtarKaz',
                        style: TextStyle(
                          color: Color(textBaseColor),
                          fontSize: 22.0,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  onTap: () => launch('https://github.com/MukhtarKaz')),
            ],
          ),
        ),
      ),
    );
  }
}
