import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);

  final CollectionReference persons =
      FirebaseFirestore.instance.collection('persons');

  Future personnotExists(String personId) async {
    return await persons.where("person_Id").snapshots().isEmpty;
  }

  Future addPerson(String firstName, String lastName, String personId,
      String personOccupation, int totalImages) async {
    await persons
        .add({
          'adder_Id': uid,
          'first_Name': firstName,
          'last_Name': lastName,
          'person_Id': personId,
          'person_Occupation': personOccupation,
          'totalimages': totalImages
        })
        .then((value) => print("Person Added"))
        .catchError((e) => print(e.toString()));
  }

  Stream<QuerySnapshot> get personData {
    return persons.where("adder_Id", isEqualTo: uid).snapshots();
  }
}
