import 'package:firebase_helpers/firebase_helpers.dart';
import '../../sign_in.dart';

import '../model/event.dart';

DatabaseService<EventModel> eventDBS = DatabaseService<EventModel>("events$id",
    fromDS: (id, data) => EventModel.fromDS(id, data),
    toMap: (event) => event.toMap());
