import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/routes.dart';
import 'package:viaductharbour/services/permissions_service.dart';

class PermissionsBloc {

  final permissionService = PermissionsService();

  Future<void> requestPermissions(BuildContext context) async {
    await requestLocationPermissions();
    await requestNotificationPermissions();
    await Navigator.of(context).pushReplacementNamed(Routes.home);
  }

  Future<void> requestLocationPermissions() async {
    await permissionService.hasLocationPermission(
      onPermissionNotAllowed: () async => await permissionService.requestLocationPermission()
    );
  }

  Future<void> requestNotificationPermissions() async {
    await permissionService.hasNotificationPermission(
      onPermissionNotAllowed: () async => await permissionService.requestNotificationPermission()
    );
    final _firebaseMessaging = FirebaseMessaging();
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );
    await _firebaseMessaging.subscribeToTopic('all');
    await _firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) async {
        print(message);
        return;
      },
      onMessage: (Map<String, dynamic> message) async {
        print(message);
        return;
      },
      onResume: (Map<String, dynamic> message) async {
        print(message);
        return;
      },
    );
  }
  void dispose() {}
}

class PermissionsBlocProvider extends InheritedWidget {

  PermissionsBlocProvider({Widget child}) : super(child: child);

  final bloc = PermissionsBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static PermissionsBlocProvider of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType();
}
