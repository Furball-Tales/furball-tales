import 'package:firebase_database/firebase_database.dart';
import './sign_in.dart';

var allPetsData = [];
var allPetsDataPetinfo = [];
final databaseReferenceAllPetsData =
    FirebaseDatabase.instance.reference().child('$id').child('pets');
final databaseReferenceAllPetsDataPetinfo =
    FirebaseDatabase.instance.reference().child('$id').child('petinfo');

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

Future readAllPetsDataPetinfo() async {
  allPetsDataPetinfo = [];
  await databaseReferenceAllPetsDataPetinfo
      .orderByKey()
      .once()
      .then((DataSnapshot snapshot) {
    snapshot.value.forEach((key, data) => {
          allPetsDataPetinfo.add({"key": key, "data": data})
        });
    allPetsDataPetinfo.sort((a, b) => b['key'].compareTo(a['key']));
  });
  print("Out allPetsData: $allPetsData");
  print("Out allPetsDataPetinfo: $allPetsDataPetinfo");
}
