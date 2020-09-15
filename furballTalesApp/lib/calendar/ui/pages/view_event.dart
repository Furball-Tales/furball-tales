import 'package:flutter/material.dart';
import 'package:furballTalesApp/calendar/res/event_firebase_service.dart';
import 'package:furballTalesApp/calendar/ui/pages/add_event.dart';
import '../../model/event.dart';
import '../../calendar_main.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Appoinment time: " + returnTimeOnly(event.eventTime),
              style: TextStyle(color: Colors.red),
            ),
            Text(
              event.title,
              style: Theme.of(context).textTheme.display1,
            ),
            SizedBox(height: 20.0),
            Text(event.description),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEventPage(note: event),
                )),
          ),
          IconButton(
            color: Colors.red,
            icon: Icon(Icons.delete),
            onPressed: (() {}),
          )
        ],
      ),
    );
  }
}
