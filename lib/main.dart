import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viaductharbour/blocs/initial_bloc.dart';
import 'package:viaductharbour/blocs/login_bloc.dart';
import 'package:viaductharbour/blocs/permissions_bloc.dart';
import 'package:viaductharbour/blocs/viaduct_bloc.dart';
import 'package:viaductharbour/pages/book_a_berth_page.dart';
import 'package:viaductharbour/pages/contact_page.dart';
import 'package:viaductharbour/pages/home_page.dart';
import 'package:viaductharbour/pages/initial_page.dart';
import 'package:viaductharbour/pages/login_page.dart';
import 'package:viaductharbour/pages/permissions_page.dart';
import 'package:viaductharbour/pages/places_page.dart';
import 'package:viaductharbour/pages/settings_page.dart';
import 'package:viaductharbour/routes.dart';
import 'package:viaductharbour/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viaduct',
      theme: Themes.light(context),
      initialRoute: Routes.initial,
      routes: {
        Routes.initial: (context) => InitialBlocProvider(child: InitialPage()),
        Routes.login: (context) => LoginBlocProvider(child: LoginPage()),
        Routes.permissions: (context) => PermissionsBlocProvider(child: PermissionsPage()),
        Routes.home: (context) => ViaductBlocProvider(child: HomePage()),
        Routes.places: (context) => ViaductBlocProvider(child: PlacesPage()),
        Routes.settings: (context) => SettingsPage(),
        Routes.contact: (context) => ContactPage(),
        Routes.bookABerth: (context) => BookABerthPage()
      },
    );
  }
}
