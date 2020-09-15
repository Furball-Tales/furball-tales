import 'package:flutter/material.dart';
import '../../main.dart';
import '../../frontend_settings.dart';
import '../each_jump_card.dart';
import '../../app_bar.dart';

var baseColor = NeumorphicCardSettings.baseColor;

var mildBlueGreen = NeumorphicCardSettings.mildBlueGreen;
var mildBlue = NeumorphicCardSettings.mildBlue;
var mildDarkBlue = NeumorphicCardSettings.mildDarkBlue;

class WeightDetail extends StatelessWidget {
  IconData icon;
  String heading;
  int color;
  List<Map<String, Object>> allChartData;

  WeightDetail(
    IconData icon,
    String heading,
    int color,
    List<Map<String, Object>> allChartData,
  ) {
    this.icon = icon;
    this.heading = heading;
    this.color = color;
    this.allChartData = allChartData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          "Weight History",
          'back',
        ),
        backgroundColor:
            Color(baseColor), //Make background of overall Widget transparent
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                  tag: heading,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                      color: Color(baseColor),
                      child: Text(''),
                    ),
                  )),
              for (var i = 0; i < allChartData.length; i++)
                Container(
                  // giving some mergin
                  margin: EdgeInsets.only(
                    top: 15,
                    right: 20,
                    left: 20,
                    bottom: 10,
                  ),
                  child: EachJumpCard(
                    Icons.line_weight,
                    heading,
                    allChartData[i]['petName'],
                    mildBlueGreen,
                    mildBlueGreen,
                    intensity,
                    depth,
                    surfaceIntensity,
                    baseColor,
                    allChartData,
                  ),
                ),
              // EachJumpCard(
              //   Icons.directions_run,
              //   "Pet Name1",
              //   mildBlueGreen,
              //   mildBlueGreen,
              //   intensity,
              //   depth,
              //   surfaceIntensity,
              //   baseColor,
              //   allChartData,
              // )
            ],
          ),
        ));
  }

  // Image Widget
  Widget imageContents(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
        height: 277,
        color: Colors.white,
        child: Container(
            child: Stack(
          children: <Widget>[
            Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            Column(
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: statusBarHeight),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(),
                        Container(
                          child: RaisedButton(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            color: Color(0xff00b8d4),
                            shape: CircleBorder(),
                            onPressed: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return MyApp();
                                }),
                              );
                            },
                          ),
                        )
                      ]),
                )
              ],
            )
          ],
        )));
  }
}
