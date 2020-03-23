import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:viaductharbour/models/accommodation.dart';
import 'package:viaductharbour/services/permissions_service.dart';

class AccommodationRepository {

  AccommodationRepository() {
    _accommodationSnapshotsSubscription = Firestore.instance
      .collection('fl_content')
      .where('_fl_meta_.schema', isEqualTo: 'accomodation')
      .snapshots()
      .asBroadcastStream()
      .listen((qs) {
        var accommodations = qs.documents.map((ds) => Accommodation.fromSnapshot(ds)).toList();
        _accommodationsWithDataSubscription = _getAccommodationWithData(accommodations).listen((accommodationsWithData) {
          _accommodationStream.sink.add(accommodationsWithData);
        });
    });
  }

  final geolocator = Geolocator();
  final permissionsService = PermissionsService();

  var _accommodationStream = BehaviorSubject<Map<String, Accommodation>>.seeded({});
  Observable<Map<String, Accommodation>> get accommodationStream => _accommodationStream.asBroadcastStream();

  StreamSubscription _accommodationSnapshotsSubscription;
  StreamSubscription _accommodationsWithDataSubscription;

  BehaviorSubject<Map<String, Accommodation>> _getAccommodationWithData(List<Accommodation> accommodations) {
    var accommodationsWithDataStream = BehaviorSubject<Map<String, Accommodation>>.seeded({});
    var accommodationsWithData = Map<String, Accommodation>();
    accommodations.forEach((accommodation) async {
      await _setAccommodationPhoto(accommodation);
      await _setAccommodationDistance(accommodation);
      accommodationsWithData[accommodation.ref.documentID] = accommodation;
      accommodationsWithDataStream.sink.add(accommodationsWithData);
    });
    return accommodationsWithDataStream;
  }

  Future<void> _setAccommodationPhoto(Accommodation accommodation) async {
    var photoDoc = await Firestore.instance.document(accommodation.photoPath).get();
    accommodation.photoUrl = await FirebaseStorage.instance.ref()
      .child('/flamelink/media/sized/1440_9999_100/${photoDoc.data['file']}')
      .getDownloadURL();
  }

  Future<void> _setAccommodationDistance(Accommodation accommodation) async {
    if (await permissionsService.hasLocationPermission()) {
      var position = await geolocator.getCurrentPosition();
      accommodation.distanceInM = (await geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        accommodation.location.latitude,
        accommodation.location.longitude
      )).toInt();
    }
  }

  void dispose() {
    _accommodationSnapshotsSubscription.cancel();
    _accommodationsWithDataSubscription.cancel();
  }
}
