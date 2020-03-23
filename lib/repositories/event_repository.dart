import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:viaductharbour/models/event.dart';
import 'package:viaductharbour/services/permissions_service.dart';

class EventRepository {

  EventRepository() {
    _eventSnapshotsSubscription = Firestore.instance
      .collection('fl_content')
      .where('_fl_meta_.schema', isEqualTo: 'events')
      .snapshots()
      .asBroadcastStream()
      .listen((qs) {
        var events = qs.documents.map((ds) => Event.fromSnapshot(ds)).toList();
        _eventsWithDataSubscription = _getEventsWithData(events).listen((eventsWithData) {
          _eventStream.sink.add(eventsWithData);
        });
    });
  }

  final geolocator = Geolocator();
  final permissionsService = PermissionsService();

  var _eventStream = BehaviorSubject<Map<String, Event>>.seeded({});
  Observable<Map<String, Event>> get eventStream => _eventStream.asBroadcastStream();

  StreamSubscription _eventSnapshotsSubscription;
  StreamSubscription _eventsWithDataSubscription;

  BehaviorSubject<Map<String, Event>> _getEventsWithData(List<Event> events) {
    var eventsWithDataStream = BehaviorSubject<Map<String, Event>>.seeded({});
    var eventsWithData = Map<String, Event>();
    events.forEach((event) async {
      await _setEventPhoto(event);
      eventsWithData[event.ref.documentID] = event;
      eventsWithDataStream.sink.add(eventsWithData);
    });
    return eventsWithDataStream;
  }

  Future<void> _setEventPhoto(Event event) async {
    var photoDoc = await Firestore.instance.document(event.photoPath).get();
    event.photoUrl = await FirebaseStorage.instance.ref()
      .child('/flamelink/media/sized/1440_9999_100/${photoDoc.data['file']}')
      .getDownloadURL();
  }

  void dispose() {
    _eventSnapshotsSubscription.cancel();
    _eventsWithDataSubscription.cancel();
  }
}
