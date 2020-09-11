// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../model/event.dart';

// class FirestoreService {
//   static final FirestoreService _firestoreService =
//       FirestoreService._internal();
//   Firestore _db = Firestore.instance;

//   FirestoreService._internal();

//   factory FirestoreService() {
//     return _firestoreService;
//   }

//   // Stream<List<EventModel>> getNotes() {
//   //   return _db.collection('events').snapshots().map(
//   //         (snapshot) => snapshot.documents.map(
//   //           (event) => EventModel.fromMap(event.data),
//   //         ).toList(),
//   //       );
//   // }

//   // Future<void> addNote(Note note) {
//   //   return _db.collection('notes').add(note.toMap());
//   // }

//   Future<void> deleteNote(String id) {
//     return _db.collection('events').document(id).delete();
//   }

//   // Future<void> updateNote(EventModel event) {
//   //   return _db.collection('notes').document(note.id).updateData(note.toMap());
//   // }
// }
