import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:viaductharbour/models/cruise.dart';
import 'package:viaductharbour/services/permissions_service.dart';

class CruiseRepository {

  CruiseRepository() {
    _cruiseSnapshotsSubscription = Firestore.instance
      .collection('fl_content')
      .where('_fl_meta_.schema', isEqualTo: 'cruises')
      .snapshots()
      .asBroadcastStream()
      .listen((qs) {
        var cruises = qs.documents.map((ds) => Cruise.fromSnapshot(ds)).toList();
        _cruisesWithDataSubscription = _getCruiseWithData(cruises).listen((cruisesWithData) {
          _cruiseStream.sink.add(cruisesWithData);
        });
    });
  }

  final geolocator = Geolocator();
  final permissionsService = PermissionsService();

  var _cruiseStream = BehaviorSubject<Map<String, Cruise>>.seeded({});
  Observable<Map<String, Cruise>> get cruiseStream => _cruiseStream.asBroadcastStream();

  StreamSubscription _cruiseSnapshotsSubscription;
  StreamSubscription _cruisesWithDataSubscription;

  BehaviorSubject<Map<String, Cruise>> _getCruiseWithData(List<Cruise> cruises) {
    var cruisesWithDataStream = BehaviorSubject<Map<String, Cruise>>.seeded({});
    var cruisesWithData = Map<String, Cruise>();
    cruises.forEach((cruise) async {
      await _setCruisePhoto(cruise);
      await _setCruiseDistance(cruise);
      cruisesWithData[cruise.ref.documentID] = cruise;
      cruisesWithDataStream.sink.add(cruisesWithData);
    });
    return cruisesWithDataStream;
  }

  Future<void> _setCruisePhoto(Cruise cruise) async {
    var photoDoc = await Firestore.instance.document(cruise.photoPath).get();
    cruise.photoUrl = await FirebaseStorage.instance.ref()
      .child('/flamelink/media/sized/1440_9999_100/${photoDoc.data['file']}')
      .getDownloadURL();
  }

  Future<void> _setCruiseDistance(Cruise cruise) async {
    if (await permissionsService.hasLocationPermission()) {
      var position = await geolocator.getCurrentPosition();
      cruise.distanceInM = (await geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        cruise.location.latitude,
        cruise.location.longitude
      )).toInt();
    }
  }

  void dispose() {
    _cruiseSnapshotsSubscription.cancel();
    _cruisesWithDataSubscription.cancel();
  }
}
