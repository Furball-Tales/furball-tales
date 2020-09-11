import 'frontend_settings.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Time",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Walk(),
    );
  }
}

class Walk extends StatefulWidget {
  @override
  _WalkState createState() => _WalkState();
}

class _WalkState extends State<Walk> with TickerProviderStateMixin{

  TabController tb; 
  int hour = 0; 
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;
  String timeToDisplay = "";
  bool checkTimer = true;

@override
  void initState(){
    tb = TabController(
      length: 2, 
      vsync: this,
    );
    super.initState();
  }

  void start(){
    setState((){
      started = false;
      stopped = false;
    });
    timeForTimer = ((hour * 60 * 60) + (min * 60) + sec);
    Timer.periodic(Duration(
      seconds: 1,
    ), (Timer t){
      setState((){
        if(timeForTimer < 1 || checkTimer == false){
          t.cancel();
          if(timeForTimer == 0){
            debugPrint('stopped by default');
          }
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Walk(),));
        } 
        else if(timeForTimer < 60) {
          timeToDisplay = timeForTimer.toString();
          timeForTimer = timeForTimer -1;
        } else if (timeForTimer < 3600) {
          int m = timeForTimer ~/60;
          int s = timeForTimer - (60* m);
          timeToDisplay = m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer -1;
        } else {
          int h = timeForTimer ~/3600;
          int t = timeForTimer -(60 * h);
          int m = t ~/60;
          int s = t - (60 + m);
          timeToDisplay = h.toString() + ":" + m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer -1;
        }
      });
    });
  }

  void stop(){
    setState((){
      started = true; 
      stopped = false;
      checkTimer = false;
    });
  }

bool startIsPressed = true;
bool stopIsPressed = true;
bool resetIsPressed = true;
String stopTimetoDisplay = "00:00:00";
var swatch = Stopwatch();
final dur = const Duration(seconds: 1);

void startTimer(){
  Timer(dur, keepRunning);
}

void keepRunning(){
  if(swatch.isRunning){
    startTimer();
  }
  setState((){
    stopTimetoDisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") + ":" + 
    (swatch.elapsed.inMinutes%60).toString().padLeft(2, "0") + ":" + 
    (swatch.elapsed.inSeconds%60).toString().padLeft(2, "0");
  });
}

void startStopWatch(){
  setState((){
    stopIsPressed = false;
    startIsPressed = false;
  });
  swatch.start();
  startTimer();
}

void stopStopWatch(){
  setState((){
    stopIsPressed = true;
    resetIsPressed = false;
  });
  swatch.stop();
}

void resetStopWatch(){
  setState((){
    startIsPressed = true;
    resetIsPressed = true;
  });
  swatch.reset();
  stopTimetoDisplay = "00:00:00";
}

  Widget stopwatch(){
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                stopTimetoDisplay,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                )
              )
            )
          ),
          Expanded(
            flex: 4, 
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children : <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed:stopIsPressed ? null : stopStopWatch,
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 15.0,
                        ),
                        child: Text(
                          "Stop",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          )
                        ),
                      ),
                        RaisedButton(
                          onPressed: resetIsPressed ? null : resetStopWatch,
                          color: Colors.teal,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0,
                          ),
                          child: Text(
                            "Reset",
                            style: TextStyle(
                              fontSize:20.0,
                              color: Colors.white,
                            )
                          ),
                        ),
                    ],
                  ),
                        RaisedButton(
                          onPressed:startIsPressed ? startStopWatch : null,
                          color: Colors.green,
                          padding: EdgeInsets.symmetric(
                            horizontal: 80.0,
                            vertical: 20.0,
                          ),
                          child: Text(
                            "Start",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                            )
                          )
                        )
                  ]
              ),
            ),
            )
        ],
      ),
    );
  }

  Widget timer(){
    return Container(
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Expanded(
          flex: 6,
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
            Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                  bottom: 10.0,
                  ),
                  child: Text(
                    "HH",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      ),
                    ),
                ),
                NumberPicker.integer(
                  initialValue: hour,
                  minValue: 0,
                  maxValue:23,
                  listViewWidth: 60.0,
                  onChanged:(val){
                    setState((){
                      hour = val;
                    });
                  },
                ),
              ],
              ),
              Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                    bottom: 10.0,
                    ),
                    child: Text(
                      "MM",
                      style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      ),
                      ),
                  ),
                NumberPicker.integer(
                  initialValue: min,
                  minValue: 0,
                  maxValue:23,
                  listViewWidth: 60.0,
                  onChanged:(val){
                    setState((){
                      min = val;
                    });
                  },
                ),
              ],
            ),

            Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                  bottom: 10.0,
                  ),
                  child: Text(
                    "SS",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      ),
                    ),
                ),
                NumberPicker.integer(
                  initialValue: sec,
                  listViewWidth: 60.0,
                  minValue: 0,
                  maxValue:23,
                  onChanged:(val){
                    setState((){
                      sec = val;
                    });
                  },
                ),
              ],
            ),
        ],
      ),
    ),
    Expanded(
      flex:1, 
      child: Text(
        timeToDisplay,
        style:TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.w600,
        )
      )
    ),
    Expanded(
      flex: 3, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: started ? start : null, 
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              color: Colors.green,
              child: Text(
                "Start",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            RaisedButton(
              onPressed: stopped ? null : stop,
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 10.0,
              ),
              color: Colors.red,
              child: Text(
                "Stop",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                ),
            ),
          ],
        ),
    ),
        ]
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Walk History"
        ),
        bottom: TabBar(
          tabs: <Widget>[
            Text(
              "Timer"
            ),
            Text(
              "Stopwatch"
            ),
          ],
          labelPadding: EdgeInsets.only(
            bottom: 10.0,
            ),
          labelStyle: TextStyle(
            fontSize: 18.0
          ),
          unselectedLabelColor: Colors.white54,
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          stopwatch(),
        ],
        controller: tb,
      )
    );
  }
}
