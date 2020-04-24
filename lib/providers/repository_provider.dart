import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viaductharbour/providers/service_provider.dart';
import 'package:viaductharbour/repositories/accommodation_repository.dart';
import 'package:viaductharbour/repositories/cruise_repository.dart';
import 'package:viaductharbour/repositories/event_repository.dart';
import 'package:viaductharbour/repositories/media_repository.dart';
import 'package:viaductharbour/repositories/restaurant_repository.dart';
import 'package:viaductharbour/repositories/transport_repository.dart';
import 'package:viaductharbour/repositories/user_repository.dart';

class RepositoryProvider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AccommodationRepository>(create: (_) => AccommodationRepository()),
        Provider<RestaurantRepository>(create: (_) => RestaurantRepository()),
        Provider<CruiseRepository>(create: (_) => CruiseRepository()),
        Provider<EventRepository>(create: (_) => EventRepository()),
        Provider<MediaRepository>(create: (_) => MediaRepository()),
        Provider<TransportRepository>(create: (_) => TransportRepository()),
        Provider<UserRepository>(create: (_) => UserRepository()),
      ],
      child: ServiceProvider(),
    );
  }
}
