import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:viaductharbour/models/location.dart';

class Transport extends Location {

  Transport.fromSnapshot(DocumentSnapshot snapshot) : super.fromSnapshot(snapshot) {
    this.name = snapshot.data['name'].toString().trim();
    this.phone = snapshot.data.containsKey('phone') ? snapshot.data['phone'].toString().trim() : '';
    this.address = snapshot.data.containsKey('address') ? snapshot.data['address'].toString().trim() : '';
  }

  Transport.empty();

  String name;
  String phone;
  String address;
}
