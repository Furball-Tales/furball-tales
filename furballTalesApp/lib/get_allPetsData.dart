import 'package:firebase_database/firebase_database.dart';
import './sign_in.dart';

var allPetsData = [];
final databaseReferenceAllPetsData =
    FirebaseDatabase.instance.reference().child('$id').child('pets');

Future readAllPetsData() async {
  allPetsData = [];
  await databaseReferenceAllPetsData
      .orderByKey()
      .once()
      .then((DataSnapshot snapshot) {
    snapshot.value.forEach((key, data) => {
          allPetsData.add({"key": key, "data": data})
        });
    allPetsData.sort((a, b) => b['key'].compareTo(a['key']));
  });
  print("Out allPetsData: $allPetsData");
}
