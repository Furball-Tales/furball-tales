import 'package:flutter/material.dart';
import 'dart:async';
import '../../frontend_settings.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../sign_in.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../get_allPetsData.dart';

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
  });
}


class Dependencies {

  final List<ValueChanged<ElapsedTime>> timerListeners = <ValueChanged<ElapsedTime>>[];
  final TextStyle textStyle = const TextStyle(fontSize: 90.0, fontFamily: "Bebas Neue");
  final Stopwatch stopwatch = new Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}



class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);
  

  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  final Dependencies dependencies = new Dependencies();


final databaseReference = FirebaseDatabase.instance.reference().child('$id').child('walk');


List history = List();
int walkDuration;
DateTime date= DateTime.now();
int poopRating = 0;
Object poopQuality = ["dry like a desert", "rainbow colored", "sweet like candy", "like a waterfall", "Same as Mine! Poop Buddies!"];
int walkRating = 0;
Object walk = [Icons.sentiment_very_dissatisfied, Icons.sentiment_dissatisfied, Icons.sentiment_neutral, Icons.sentiment_satisfied, Icons.sentiment_very_satisfied];
String comments;
int poopTimes = 0;
String key;
Object petName = allPetsData;

  


  void leftButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        print("${dependencies.stopwatch.elapsedMilliseconds}");
      } else {
        dependencies.stopwatch.reset();
      }
    });
  }

  addWalk() {
  Map<String, String> walk = {
    "key": '$key',
    "petName": '$petName',
    "Date": '$date',
    "Dog Enjoyment": '$walkRating',
    "Walk": '$walkDuration',
    "Number of Poops": '$poopTimes',
    "Poop Quality": '$poopRating',
    "Comments": '$comments'
  };
  databaseReference.push().set(walk).whenComplete(() {
    print('walk history created');
  });
}


List<ListItem> petNames = List();
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;
  makePetsList() {
    for (var i = 0; i < allPetsData.length; i++) {
      ListItem newListItem = ListItem(i + 1, allPetsData[i]['data']['petName']);
      petNames.add(newListItem);
    }
    print(petNames);
  }

  void initState() {
    super.initState();
    makePetsList();
    _dropdownMenuItems = buildDropDownMenuItems(petNames);
    _selectedItem = _dropdownMenuItems[0].value;
  }
  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }


  void rightButtonPressed() {
    setState(() {
      walkDuration = dependencies.stopwatch.elapsedMilliseconds~/60000;
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
        showDialog(
          context: context,
          builder: (BuildContext context){
            int _poopRating = 0;
            int _poopTimes = 0;
            return StatefulBuilder(builder:(context, setState){
              return AlertDialog(
                actions: <Widget>[
                  NeumorphicTheme(
                    child: NeumorphicButton(
                      child: const Text('Add Walk'),
                      onPressed: (){
                        addWalk();
                        Navigator.of(context).pop();
                        poopRating = 0;
                        poopTimes = 0;
                      },
                      style: NeumorphicStyle(
                        color: Colors.white,
                      )
                    ),
                  )
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
                  title: Text("How was your walk?"),
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Form(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min, 
                            children: <Widget>[
                            Text("Yay! You walked for $walkDuration min today!", 
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              )),
                              SizedBox(
                                height: 10.0,
                              ),
                            heading("Who did you walk?"),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: DropdownButton<ListItem>(
                                  value: _selectedItem,
                                  items: _dropdownMenuItems,
                                  onChanged:(value){
                                    setState((){
                                      _selectedItem = value;
                                    });
                                  }
                                ),
                              ),
                              heading("How did your Furball enjoy the walk?"),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: RatingBar(
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    switch(index) {
                                      case 0: 
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                      case 1:
                                        return Icon(
                                            Icons.sentiment_dissatisfied,
                                            color: Colors.redAccent,
                                        );
                                      case 2:
                                        return Icon(
                                            Icons.sentiment_neutral,
                                            color: Colors.amber,
                                        );
                                      case 3:
                                        return Icon(
                                            Icons.sentiment_satisfied,
                                            color: Colors.lightGreen,
                                        );
                                      case 4:
                                          return Icon(
                                            Icons.sentiment_very_satisfied,
                                            color: Colors.green,
                                          );
                                    }
                                  },
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      walk = rating;
                                    });
                                  }
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    heading("How many times did your Dog poop?"),
                                    DropdownButton(
                                      value: _poopTimes,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("0", style: TextStyle(fontSize:15.0)),
                                          value: 0,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("1", style: TextStyle(fontSize:15.0)),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("2", style: TextStyle(fontSize:15.0)),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("3", style: TextStyle(fontSize:15.0)),
                                          value: 3,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("4", style: TextStyle(fontSize:15.0)),
                                          value: 4,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("5", style: TextStyle(fontSize:15.0)),
                                          value: 5,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("5+", style: TextStyle(fontSize:15.0)),
                                          value: 6,
                                        ),
                                      ],
                                      onChanged:(value) {
                                        setState((){
                                          _poopTimes = value;
                                          print(_poopTimes);
                                          poopTimes = _poopTimes;
                                        });
                                      }
                                    ),
                                  ],
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    heading("How was the poop consistency?"),
                                    DropdownButton(
                                      value: _poopRating,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("dry like a desert", style: TextStyle(fontSize:15.0)),
                                          value: 0,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("rainbow colored", style: TextStyle(fontSize:15.0)),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("sweet like candy", style: TextStyle(fontSize:15.0)),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("like a waterfall", style: TextStyle(fontSize:15.0)),
                                          value: 3,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Same as mine! Poop buddies!", style: TextStyle(fontSize:15.0)),
                                          value: 4,
                                        ),
                                      ],
                                      onChanged:(value) {
                                        setState((){
                                          _poopRating = value;
                                          print(_poopRating);
                                          poopRating = _poopRating;
                                        });
                                      }
                                    ),
                                  ],
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: TextFormField(
                                  onChanged: (String commentValue){
                                    comments = commentValue;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Comments'
                                  )
                                )
                              )
                            ]
                          )
                        )
                      )
                    ]
                )
              );
            },
            );
          }
        );
      } else {
        dependencies.stopwatch.start();
      }
    });
  }

var buttonIntensity = NeumorphicButtonSettings.buttonIntensity;
var buttonDepth = NeumorphicButtonSettings.buttonDepth;
var buttonSurfaceIntensity = NeumorphicButtonSettings.buttonSurfaceIntensity;

  Widget heading(String text) => Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 15.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      );

  Widget buildReset(String text, VoidCallback callback) {
    TextStyle roundTextStyle = const TextStyle(fontSize: 16.0, color: Colors.white);
    return new RaisedButton(
      child: new Text(text, style: roundTextStyle),
      color: Colors.red,
      onPressed: callback);
  }

    Widget buildStart(String text, VoidCallback callback) {
    TextStyle roundTextStyle = const TextStyle(fontSize: 16.0, color: Colors.white);
    return new RaisedButton(
      child: new Text(text, style: roundTextStyle),
      color: Colors.blue,
      onPressed: callback);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: new TimerText(dependencies: dependencies),
        ),
        Container(
          child: new Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildStart(dependencies.stopwatch.isRunning ? "stop" : "start", rightButtonPressed),
                buildReset("reset", leftButtonPressed),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimerText extends StatefulWidget {
  TimerText({this.dependencies});
  final Dependencies dependencies;

  TimerTextState createState() => new TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({this.dependencies});
  final Dependencies dependencies;
  Timer timer;
  int milliseconds;

  @override
  void initState() {
    timer = new Timer.periodic(new Duration(milliseconds: dependencies.timerMillisecondsRefreshRate), callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
      milliseconds = dependencies.stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();
      final ElapsedTime elapsedTime = new ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
      );
      for (final listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          new RepaintBoundary(
            child: new SizedBox(
              height: 100.0,
              child: new MinutesAndSeconds(dependencies: dependencies),
            ),
          ),
          new RepaintBoundary(
            child: new SizedBox(
              height: 100.0,
              child: new Hundreds(dependencies: dependencies),
            ),
          ),
      ],
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  MinutesAndSeconds({this.dependencies});
  final Dependencies dependencies;

  MinutesAndSecondsState createState() => new MinutesAndSecondsState(dependencies: dependencies);
}

class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  MinutesAndSecondsState({this.dependencies});
  final Dependencies dependencies;

  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.seconds != seconds) {
      setState(() {
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return new Text('$minutesStr:$secondsStr.', style: dependencies.textStyle);
  }
}

class Hundreds extends StatefulWidget {
  Hundreds({this.dependencies});
  final Dependencies dependencies;

  HundredsState createState() => new HundredsState(dependencies: dependencies);
}

class HundredsState extends State<Hundreds> {
  HundredsState({this.dependencies});
  final Dependencies dependencies;

  int hundreds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hundreds != hundreds) {
      setState(() {
        hundreds = elapsed.hundreds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    return new Text(hundredsStr, style: dependencies.textStyle);
  }
}