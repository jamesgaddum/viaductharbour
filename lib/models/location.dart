import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

abstract class Location {

  Location();

  Location.fromSnapshot(DocumentSnapshot snapshot) {
    this.ref = snapshot.reference;
    this.location = LatLng(snapshot.data['latitude'], snapshot.data['longitude']);
    this.photoPath = snapshot.data.containsKey('photo') ? snapshot.data['photo'][0].path : '';
  }

  DocumentReference ref;
  LatLng location;
  int distanceInM;
  String photoPath;
  String photoUrl;

  NumberFormat format = NumberFormat();

  String get distanceInMString {
    if (distanceInM == null) {
      return '';
    }
    return distanceInM > 1000 ? '${format.format(distanceInM ~/ 1000)}km away' : '${format.format(distanceInM)}m away';
  }
}
