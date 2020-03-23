import 'dart:async';
// import 'package:geolocator/geolocator.dart';
import 'package:rxdart/subjects.dart';
import 'package:viaductharbour/models/accommodation.dart';
import 'package:viaductharbour/models/cruise.dart';
import 'package:viaductharbour/models/event.dart';
// import 'package:viaductharbour/models/location.dart';
import 'package:viaductharbour/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/models/transport.dart';
import 'package:viaductharbour/repositories/accommodation_repository.dart';
import 'package:viaductharbour/repositories/cruise_repository.dart';
import 'package:viaductharbour/repositories/event_repository.dart';
import 'package:viaductharbour/repositories/restaurant_repository.dart';
import 'package:viaductharbour/repositories/transport_repository.dart';
// import 'package:viaductharbour/services/permissions_service.dart';

class ViaductBloc {

  ViaductBloc() {
    _registerForLocationUpdates();
    // _registerForPositionUpdates(restaurantsStream);
    // _registerForPositionUpdates(accommodationsStream);
    // _registerForPositionUpdates(cruiseStream);
    // _registerForPositionUpdates(transportStream);
  }

  final _restaurantRepository = RestaurantRepository();
  final _eventRepository = EventRepository();
  final _accommodationRepository = AccommodationRepository();
  final _cruiseRepository = CruiseRepository();
  final _transportRepository = TransportRepository();
  // final _geolocator = Geolocator();
  // final _permissionsService = PermissionsService();

  final restaurantsStream = BehaviorSubject<List<Restaurant>>.seeded([]);
  final eventsStream = BehaviorSubject<List<Event>>.seeded([]);
  final accommodationsStream = BehaviorSubject<List<Accommodation>>.seeded([]);
  final cruiseStream = BehaviorSubject<List<Cruise>>.seeded([]);
  final transportStream = BehaviorSubject<List<Transport>>.seeded([]);

  final _subscriptions = List<StreamSubscription>();

  void _registerForLocationUpdates() {
    _restaurantRepository.restaurantStream.listen((Map<String, Restaurant> snapshot) {
      restaurantsStream.sink.add(snapshot.values.toList());
    });
    _eventRepository.eventStream.listen((Map<String, Event> snapshot) {
      eventsStream.sink.add(snapshot.values.toList());
    });
    _accommodationRepository.accommodationStream.listen((Map<String, Accommodation> snapshot) {
      accommodationsStream.sink.add(snapshot.values.toList());
    });
    _cruiseRepository.cruiseStream.listen((Map<String, Cruise> snapshot) {
      cruiseStream.sink.add(snapshot.values.toList());
    });
    _transportRepository.transportStream.listen((Map<String, Transport> snapshot) {
      transportStream.sink.add(snapshot.values.toList());
    });
  }

  // void _registerForPositionUpdates(BehaviorSubject<List<Location>> locationsStream) async {
  //   if (await _permissionsService.hasLocationPermission()) {
  //     _subscriptions.add(_geolocator.getPositionStream(LocationOptions(
  //       timeInterval: 60000,
  //     )).listen((position) {
  //       _updateLocationsWithDistance(position, locationsStream);
  //     }));
  //   }
  // }

  // void _updateLocationsWithDistance(Position position, BehaviorSubject<List<Location>> locations) {
  //   locations.value.forEach((location) {
  //       _geolocator.distanceBetween(
  //         position.latitude,
  //         position.longitude,
  //         location.location.latitude,
  //         location.location.longitude
  //       ).then((distance) {
  //         location.distanceInM = distance.toInt();
  //         locations.sink.add(locations.value);
  //       });
  //     });
  // }

  void dispose() {
    restaurantsStream.close();
    eventsStream.close();
    accommodationsStream.close();
    cruiseStream.close();
    transportStream.close();
    _subscriptions.forEach((sub) => sub.cancel());
  }
}

class ViaductBlocProvider extends InheritedWidget {

  ViaductBlocProvider({Widget child}) : super(child: child);

  final bloc = ViaductBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ViaductBlocProvider of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType();
}
