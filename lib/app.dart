import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viaductharbour/pages/book_a_berth_page.dart';
import 'package:viaductharbour/pages/contact_page.dart';
import 'package:viaductharbour/pages/contractors_and_services_page.dart';
import 'package:viaductharbour/pages/home_page.dart';
import 'package:viaductharbour/pages/initial_page.dart';
import 'package:viaductharbour/pages/login_page.dart';
import 'package:viaductharbour/pages/permissions_page.dart';
import 'package:viaductharbour/pages/places_page.dart';
import 'package:viaductharbour/pages/settings_page.dart';
import 'package:viaductharbour/routes.dart';
import 'package:viaductharbour/themes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viaduct Harbour',
      initialRoute: Routes.initial,
      navigatorObservers: [Provider.of<RouteObserver>(context)],
      routes: {
        Routes.initial: (context) => InitialPage(),
        Routes.login: (context) => LoginPage(),
        Routes.permissions: (context) => PermissionsPage(),
        Routes.home: (context) => HomePage(),
        Routes.places: (context) => PlacesPage(),
        Routes.settings: (context) => SettingsPage(),
        Routes.contact: (context) => ContactPage(),
        Routes.bookABerth: (context) => BookABerthPage(),
        Routes.contractors: (context) => ContractorsAndServicesPage()
      },
      theme: Themes.light(context),
    );
  }
}
