import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furballTalesApp/app_bar.dart';
import 'package:furballTalesApp/calendar/res/firestore_service.dart';
import 'package:furballTalesApp/frontend_settings.dart';
import 'package:furballTalesApp/homepage.dart';
import './res/event_firebase_service.dart';
import './ui/pages/add_event.dart';
import './ui/pages/view_event.dart';
import './model/event.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//import './res/firestore_service.dart';

import 'package:table_calendar/table_calendar.dart';

var baseColor = NeumorphicCardSettings.baseColor;

Firestore _db = Firestore.instance;
final databaseReference = Firestore.instance.collection('events');

class Calendar extends StatefulWidget {
  final EventModel note;

  const Calendar({Key key, this.note}) : super(key: key);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  //CollectionReference collref = _db.collection(collection);
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  String titleText = "";
  String descriptionText = "";
  DateTime updateDate;
  DateTime updateTimeData;
  String updateTitle = "";
  String updateDesription = "";
  DateTime _eventDate;
  TimeOfDay _eventTime;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
    _eventDate = DateTime.now();
    _eventTime = TimeOfDay.now();
  }

  addEvent() async {
    await eventDBS.createItem(EventModel(
        title: titleText,
        description: descriptionText,
        eventDate: _eventDate,
        eventTime: formatTimeOfDaytoDateTime(_eventDate, _eventTime)));
  }

  updateEvent() async {
    if (_formKey.currentState.validate()) {
      // setState(() {
      //   processing = true;
      // });
      if (widget.note != null) {
        await eventDBS.updateData(widget.note.id, {
          "title": updateTitle,
          "description": updateDesription,
          "event_date": _eventDate,
          "event_time": formatTimeOfDaytoDateTime(_eventDate, _eventTime)
        });
      }
      Navigator.pop(context);
    }
  }

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> allEvents) {
    Map<DateTime, List<dynamic>> data = {};
    allEvents.forEach((event) {
      DateTime date = DateTime(
          event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(baseColor),
      appBar: GradientAppBar(
        "Furball Tales Calendar",
        'null',
      ),
      key: _key,
      body: StreamBuilder<List<EventModel>>(
          stream: eventDBS.streamList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> allEvents = snapshot.data;
              if (allEvents.isNotEmpty) {
                _events = _groupEvents(allEvents);
              }
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar(
                    events: _events,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                        canEventMarkersOverflow: true,
                        todayColor: Colors.orange,
                        selectedColor: Theme.of(context).primaryColor,
                        todayStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white)),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (date, events) {
                      setState(() {
                        _selectedEvents = events;
                      });
                    },
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      todayDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    calendarController: _controller,
                  ),
                  ..._selectedEvents.map((event) => ListTile(
                        title: Text(
                          event.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Event time: " +
                                    returnTimeOnly(event.eventTime),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            eventDBS.removeItem(event.id);
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Icon(Icons.update),
                                        onPressed: () {
                                          updateDate = event.eventDate;
                                          updateTimeData = event.eventTime;
                                          updateTitle = event.title;
                                          updateDesription = event.description;
                                          Navigator.of(context).pop();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                // DateTime updatedate =
                                                //     DateTime.now();
                                                TimeOfDay updatetime =
                                                    TimeOfDay.now();
                                                return StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return AlertDialog(
                                                      actions: <Widget>[
                                                        FlatButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              await eventDBS
                                                                  .updateData(
                                                                      event.id,
                                                                      {
                                                                    "title":
                                                                        updateTitle,
                                                                    "description":
                                                                        updateDesription,
                                                                    "event_date":
                                                                        updateDate,
                                                                    "event_time":
                                                                        updateTimeData,
                                                                    // formatTimeOfDaytoDateTime(
                                                                    //     updateDate,
                                                                    //     updatetime)
                                                                  });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              //update logic
                                                            },
                                                            child: Text(
                                                                'Update Event'))

                                                        // update here
                                                      ],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                      title:
                                                          Text("Update Event"),
                                                      content: Stack(
                                                        overflow:
                                                            Overflow.visible,
                                                        children: <Widget>[
                                                          Form(
                                                              key: _formKey,
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          RaisedButton(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0)),
                                                                        elevation:
                                                                            4.0,
                                                                        onPressed:
                                                                            () async {
                                                                          DateTime picked = await showDatePicker(
                                                                              context: context,
                                                                              initialDate: updateDate,
                                                                              firstDate: DateTime(updateDate.year - 5),
                                                                              lastDate: DateTime(updateDate.year + 5));
                                                                          if (picked !=
                                                                              null) {
                                                                            setState(() {
                                                                              updateDate = picked;
                                                                              //_eventDate = picked;

                                                                              // dateValue =
                                                                              //     '${currentdate.year}-${currentdate.month}-${currentdate.day}';
                                                                            });
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          height:
                                                                              50.0,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                    child: Row(
                                                                                      children: <Widget>[
                                                                                        Icon(
                                                                                          Icons.date_range,
                                                                                          size: 15.0,
                                                                                          color: Colors.blue,
                                                                                        ),
                                                                                        new Text(
                                                                                          "${updateDate.year} - ${updateDate.month} - ${updateDate.day}",
                                                                                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15.0),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              Text(
                                                                                "Change",
                                                                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15.0),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          RaisedButton(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0)),
                                                                        elevation:
                                                                            4.0,
                                                                        onPressed:
                                                                            () async {
                                                                          TimeOfDay
                                                                              t =
                                                                              await showTimePicker(context: context, initialTime: updatetime);
                                                                          if (t !=
                                                                              null) {
                                                                            setState(() {
                                                                              updateTimeData = formatTimeOfDaytoDateTime(updateDate, t);
                                                                              //updatetime = t;
                                                                              _eventTime = t;
                                                                              // _eventTime = t;
                                                                            });
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          height:
                                                                              50.0,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                    child: Row(
                                                                                      children: <Widget>[
                                                                                        Icon(
                                                                                          Icons.date_range,
                                                                                          size: 15.0,
                                                                                          color: Colors.blue,
                                                                                        ),
                                                                                        new Text(
                                                                                          "${updateTimeData.hour} : ${updateTimeData.minute}",
                                                                                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15.0),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              Text(
                                                                                "Change",
                                                                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15.0),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5.0),
                                                                      child: TextFormField(
                                                                          initialValue: updateTitle,
                                                                          onChanged: (String title) {
                                                                            updateTitle =
                                                                                title;
                                                                          },
                                                                          decoration: InputDecoration(labelText: 'Title')),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5.0),
                                                                      child: TextFormField(
                                                                          initialValue: updateDesription,
                                                                          onChanged: (String description) {
                                                                            updateDesription =
                                                                                description;
                                                                          },
                                                                          decoration: InputDecoration(labelText: 'Description')),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ))
                                                        ],
                                                      ));
                                                });
                                              });
                                        },
                                      ),
                                      // don't touch below -------------------------------
                                    ],
                                    title: Text(event.title),
                                    titleTextStyle: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                    titlePadding:
                                        EdgeInsets.fromLTRB(20, 20, 0, 0),
                                    content: IntrinsicHeight(
                                      child: Column(children: <Widget>[
                                        Row(children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Text("Event time: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                  fontSize: 16.0,
                                                )),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: Text(
                                                  returnTimeOnly(
                                                      event.eventTime),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 16.0,
                                                  )),
                                            ),
                                          ),
                                        ]),
                                        Row(children: [
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Text("Details: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontSize: 14.0,
                                                )),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Text(event.description,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 14.0,
                                                  )),
                                            ),
                                          ),
                                        ]),
                                      ]),
                                    ));
                              });
                        },
                      )),
                ],
              ),
            );
          }),

      //---------------------------------------------------
      floatingActionButton: NeumorphicTheme(
        child: NeumorphicFloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  DateTime currentdate = DateTime.now();
                  TimeOfDay currenttime = TimeOfDay.now();
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                        actions: <Widget>[
                          NeumorphicTheme(
                            child: NeumorphicButton(
                              child: const Text('Add'),
                              onPressed: () {
                                addEvent();
                                Navigator.of(context).pop();
                                // dateValue = "Not Set";
                              },
                              style: NeumorphicStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        title: Text("Add Event"),
                        content: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          elevation: 4.0,
                                          onPressed: () async {
                                            DateTime picked =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: currentdate,
                                                    firstDate: DateTime(
                                                        currentdate.year - 5),
                                                    lastDate: DateTime(
                                                        currentdate.year + 5));
                                            if (picked != null) {
                                              setState(() {
                                                currentdate = picked;
                                                _eventDate = picked;

                                                // dateValue =
                                                //     '${currentdate.year}-${currentdate.month}-${currentdate.day}';
                                              });
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 50.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.date_range,
                                                            size: 15.0,
                                                            color: Colors.blue,
                                                          ),
                                                          new Text(
                                                            "${currentdate.year} - ${currentdate.month} - ${currentdate.day}",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.0),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  "Change",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          elevation: 4.0,
                                          onPressed: () async {
                                            TimeOfDay t = await showTimePicker(
                                                context: context,
                                                initialTime: currenttime);
                                            if (t != null) {
                                              setState(() {
                                                currenttime = t;
                                                _eventTime = t;
                                                // _eventTime = t;
                                              });
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 50.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.date_range,
                                                            size: 15.0,
                                                            color: Colors.blue,
                                                          ),
                                                          new Text(
                                                            "${currenttime.hour} : ${currenttime.minute}",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.0),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  "Change",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: TextFormField(
                                            onChanged: (String title) {
                                              titleText = title;
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Title')),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: TextFormField(
                                            onChanged: (String description) {
                                              descriptionText = description;
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Description')),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ));
                  });
                });
          },
          child: Container(
            color: Color(baseColor),
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
          tooltip: 'New Event',
        ),
      ),
    );
  }
}
