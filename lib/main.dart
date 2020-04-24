import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viaductharbour/providers/observer_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(ObserverProvider());
}
