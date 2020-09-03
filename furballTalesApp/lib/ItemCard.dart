import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'login_page.dart';

class ItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              // subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('MODIFY'),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: const Text('DELETE'),
                  onPressed: () {/* ... */},
                ),
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: const Text('LOGOUT'),
                  onPressed: () {
                    signOutGoogle();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }), ModalRoute.withName('/'));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
