import 'package:cloud_firestore/cloud_firestore.dart';

class Event {

  Event.fromSnapshot(DocumentSnapshot snapshot) {
    this.ref = snapshot.reference;
    this.photoPath = snapshot.data.containsKey('photo') ? snapshot.data['photo'][0].path : '';
    this.name = snapshot.data['name'].toString().trim();
    this.description = snapshot.data['description'].toString().trim();
  }

  Event.empty();

  DocumentReference ref;
  String name;
  String description;
  String photoPath;
  String photoUrl;
}
