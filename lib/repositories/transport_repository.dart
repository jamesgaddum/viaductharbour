import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:viaductharbour/models/transport.dart';
import 'package:viaductharbour/services/permissions_service.dart';

class TransportRepository {

  TransportRepository() {
    _transportSnapshotsSubscription = Firestore.instance
      .collection('fl_content')
      .where('_fl_meta_.schema', isEqualTo: 'parking')
      .snapshots()
      .asBroadcastStream()
      .listen((qs) {
        var transports = qs.documents.map((ds) => Transport.fromSnapshot(ds)).toList();
        _transportsWithDataSubscription = _getTransportWithData(transports).listen((transportsWithData) {
          _transportStream.sink.add(transportsWithData);
        });
    });
  }

  final geolocator = Geolocator();
  final permissionsService = PermissionsService();

  var _transportStream = BehaviorSubject<Map<String, Transport>>.seeded({});
  Observable<Map<String, Transport>> get transportStream => _transportStream.asBroadcastStream();

  StreamSubscription _transportSnapshotsSubscription;
  StreamSubscription _transportsWithDataSubscription;

  BehaviorSubject<Map<String, Transport>> _getTransportWithData(List<Transport> transports) {
    var transportsWithDataStream = BehaviorSubject<Map<String, Transport>>.seeded({});
    var transportsWithData = Map<String, Transport>();
    transports.forEach((transport) async {
      await _setTransportPhoto(transport);
      await _setTransportDistance(transport);
      transportsWithData[transport.ref.documentID] = transport;
      transportsWithDataStream.sink.add(transportsWithData);
    });
    return transportsWithDataStream;
  }

  Future<void> _setTransportPhoto(Transport transport) async {
    var photoDoc = await Firestore.instance.document(transport.photoPath).get();
    transport.photoUrl = await FirebaseStorage.instance.ref()
      .child('/flamelink/media/sized/1440_9999_100/${photoDoc.data['file']}')
      .getDownloadURL();
  }

  Future<void> _setTransportDistance(Transport transport) async {
    if (await permissionsService.hasLocationPermission()) {
      var position = await geolocator.getCurrentPosition();
      transport.distanceInM = (await geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        transport.location.latitude,
        transport.location.longitude
      )).toInt();
    }
  }

  void dispose() {
    _transportSnapshotsSubscription.cancel();
    _transportsWithDataSubscription.cancel();
  }
}
