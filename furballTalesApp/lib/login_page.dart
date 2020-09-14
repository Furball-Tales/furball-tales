import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'homepage.dart';
import 'initial_registration.dart';
import 'get_allPetsData.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/login_background.png"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset('assets/logo.png'),
                SizedBox(height: 50),
                _signInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          readAllPetsData().whenComplete(() => {
                print("existData: $existData"),
                if (allPetsData.length > 0)
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Homepage();
                        },
                      ),
                    )
                  }
                else
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return InitialRegistration();
                        },
                      ),
                    )
                  }
              });
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
