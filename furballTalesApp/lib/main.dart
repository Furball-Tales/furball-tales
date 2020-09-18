//import 'package:firebase_auth/firebase_auth.dart'; // firebase auth plagin system
import 'package:flutter/material.dart';

//import 'package:google_sign_in/google_sign_in.dart'; // plagin from google for sign in
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
