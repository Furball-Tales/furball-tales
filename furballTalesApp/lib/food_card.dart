import 'package:flutter/material.dart';
import 'food_detail_page.dart';

class FoodCard extends StatefulWidget {
  IconData icon;
  String heading;
  int color;

  FoodCard(IconData icon, String heading, int color) {
    this.icon = icon;
    this.heading = heading;
    this.color = color;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomCardState(icon, heading, color);
  }
}

class CustomCardState extends State<FoodCard> {
  IconData icon;
  String heading;
  int color;
  var _hasPadding = false;

  CustomCardState(IconData icon, String heading, int color) {
    this.icon = icon;
    this.heading = heading;
    this.color = color;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Hero(
      tag: heading,
      child: Material(
        type: MaterialType.transparency,
        child: content(),
      ),
    );
  }

  Widget content() {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 80),
      padding: EdgeInsets.all(_hasPadding ? 10 : 0),
      child: GestureDetector(
        onTapDown: (TapDownDetails downDetails) {
          setState(() {
            _hasPadding = true;
          });
        },
        onTap: () {
          print('Card tapped.');
          setState(() {
            _hasPadding = false;
          });
          Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) =>
                    FoodDetailPage(icon, heading, color),
              ));
        },
        onTapCancel: () {
          setState(() {
            _hasPadding = false;
          });
        },
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          shadowColor: Colors.grey[200],
          borderRadius: BorderRadius.circular(60),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //text
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          heading,
                          style: TextStyle(
                            color: Color(color),
                            fontSize: 20,
                          ),
                        ),
                      ),

                      //icon
                      Material(
                        color: Color(color),
                        borderRadius: BorderRadius.circular(24),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//  Material MyItems(IconData icon, String heading, int color) {
//     return Material(
//       color: Colors.white,
//       elevation: 14.0,
//       shadowColor: Colors.grey[200],
//       borderRadius: BorderRadius.circular(60),

//     );
//   }
