import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:viaductharbour/models/restaurant.dart';
import 'package:viaductharbour/services/permissions_service.dart';

class RestaurantRepository {

  RestaurantRepository() {
    _restaurantSnapshotsSubscription = Firestore.instance
      .collection('fl_content')
      .where('_fl_meta_.schema', isEqualTo: 'restaurants')
      .snapshots()
      .asBroadcastStream()
      .listen((qs) {
        var restaurants = qs.documents.map((ds) => Restaurant.fromSnapshot(ds)).toList();
        _restaurantsWithDataSubscription = _getLocationsWithData(restaurants).listen((restaurantsWithData) {
          _restaurantStream.sink.add(restaurantsWithData);
        });
    });
  }

  final geolocator = Geolocator();
  final permissionsService = PermissionsService();

  var _restaurantStream = BehaviorSubject<Map<String, Restaurant>>.seeded({});
  Observable<Map<String, Restaurant>> get restaurantStream => _restaurantStream.asBroadcastStream();

  StreamSubscription _restaurantSnapshotsSubscription;
  StreamSubscription _restaurantsWithDataSubscription;

  BehaviorSubject<Map<String, Restaurant>> _getLocationsWithData(List<Restaurant> locations) {
    var locationsWithDataStream = BehaviorSubject<Map<String, Restaurant>>.seeded({});
    var locationsWithData = Map<String, Restaurant>();
    locations.forEach((location) async {
      await _setLocationPhoto(location);
      await _setLocationDistance(location);
      locationsWithData[location.ref.documentID] = location;
      locationsWithDataStream.sink.add(locationsWithData);
    });
    return locationsWithDataStream;
  }

  Future<void> _setLocationPhoto(Restaurant location) async {
    var photoDoc = await Firestore.instance.document(location.photoPath).get();
    location.photoUrl = await FirebaseStorage.instance.ref()
      .child('/flamelink/media/sized/1440_9999_100/${photoDoc.data['file']}')
      .getDownloadURL();
  }

  Future<void> _setLocationDistance(Restaurant location) async {
    if (await permissionsService.hasLocationPermission()) {
      var position = await geolocator.getCurrentPosition();
      location.distanceInM = (await geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        location.location.latitude,
        location.location.longitude
      )).toInt();
    }
  }

  void dispose() {
    _restaurantSnapshotsSubscription.cancel();
    _restaurantsWithDataSubscription.cancel();
  }
}
