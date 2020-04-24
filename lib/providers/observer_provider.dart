import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viaductharbour/observers/navigation_observer.dart';
import 'package:viaductharbour/providers/repository_provider.dart';

class ObserverProvider extends StatelessWidget {

  final routeObserver = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RouteObserver>(create: (_) => routeObserver),
        Provider<NavigationObserver>(create: (_) => NavigationObserver(routeObserver: routeObserver)),
      ],
      child: RepositoryProvider(),
    );
  }
}
