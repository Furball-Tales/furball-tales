import 'package:flutter/material.dart';
import 'package:furballTalesApp/homepage.dart';
import './res/event_firebase_service.dart';
import './ui/pages/add_event.dart';
import './ui/pages/view_event.dart';
import './model/event.dart';
//import './res/firestore_service.dart';

import 'package:table_calendar/table_calendar.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Calendar',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//       routes: {
//         "add_event": (_) => AddEventPage(),
//       },
//     );
//   }
// }

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> allEvents) {
    Map<DateTime, List<dynamic>> data = {};
    allEvents.forEach((event) {
      DateTime date = DateTime(
          event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calendar'),
      ),
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
                        // ..._selectedEvents.sort((a, b) {
                        //   var adate =
                        //       a['event_time']; //before -> var adate = a.expiry;
                        //   var bdate =
                        //       b['event_time']; //before -> var bdate = b.expiry;
                        //   return adate.compareTo(bdate);
                        // });
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
                        title: Text(event.title),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Appoinment time: " +
                                    returnTimeOnly(event.eventTime),
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(event.description),
                              // IconButton(
                              //   color: Colors.red,
                              //   icon: Icon(Icons.delete),
                              //   onPressed: () => _deleteNote(context, event.id),
                              // ),
                            ]),
                        trailing: FlatButton(
                            onPressed: () async {
                              await eventDBS.removeItem(event.id);
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Homepage()))
                                  .whenComplete(() => {Navigator.pop(context)});
                            },
                            child: Text('delete')),
                        // onTap: () {
                        //   print(event);
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (_) => EventDetailsPage(
                        //                 event: event,
                        //               )
                        //               )
                        //               );
                        // },
                      )),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //onPressed: () => Navigator.pushNamed(context, 'add_event'),
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddEventPage()))
        },
      ),
    );
  }

  refresh() {
    setState(() {});
  }

  void _deleteNote(BuildContext context, String id) async {
    if (await _showConfirmationDialog(context)) {
      try {
        await eventDBS.removeItem(id);
        Navigator.of(context).pop();
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("Are you sure you want to delete?"),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.red,
                  child: Text("Delete"),
                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  textColor: Colors.black,
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }
}
