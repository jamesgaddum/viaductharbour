import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viaductharbour/providers/bloc_provider.dart';
import 'package:viaductharbour/services/distance_service.dart';
import 'package:viaductharbour/services/permissions_service.dart';

class ServiceProvider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PermissionsService>(create: (_) => PermissionsService()),
        Provider<DistanceService>(create: (_) => DistanceService())
      ],
      child: BlocProvider(),
    );
  }
}
