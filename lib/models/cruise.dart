import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:viaductharbour/models/location.dart';

class Cruise extends Location {

  Cruise.fromSnapshot(DocumentSnapshot snapshot) : super.fromSnapshot(snapshot) {
    this.name = snapshot.data['name'].toString().trim();
    this.description = snapshot.data['description'].toString().trim();
    this.phone = snapshot.data.containsKey('phone') ? snapshot.data['phone'].toString().trim() : '';
  }

  Cruise.empty();

  String name;
  String description;
  String phone;
  String address;
}
