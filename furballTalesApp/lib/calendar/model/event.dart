import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventModel extends DatabaseItem {
  final String id;
  final String title;
  final String description;
  final DateTime eventDate;
  final DateTime eventTime;

  EventModel(
      {this.id, this.title, this.description, this.eventDate, this.eventTime})
      : super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
        title: data['title'],
        description: data['description'],
        eventDate: data['event_date'],
        eventTime: data['event_time']);
  }

  factory EventModel.fromDS(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      eventDate: data['event_date'].toDate(),
      eventTime: data['event_time'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "event_date": eventDate,
      "event_time": eventTime,
      "id": id,
    };
  }
}

String formatTimeOfDay(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}

DateTime formatTimeOfDaytoDateTime(DateTime d, TimeOfDay t) {
  final dt = DateTime(d.year, d.month, d.day, t.hour, t.minute);
  // final format = DateFormat.jm();  //"6:00 AM"
  return dt;
}

String returnTimeOnly(DateTime d) {
  final dt = DateTime(d.year, d.month, d.day, d.hour, d.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}
