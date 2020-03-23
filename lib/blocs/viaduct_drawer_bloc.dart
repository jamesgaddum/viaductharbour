import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:viaductharbour/repositories/user_repository.dart';
import 'package:viaductharbour/routes.dart';

class ViaductDrawerBloc {

  ViaductDrawerBloc() {
    _userRepository.getLoggedInUser().then((loggedInUser) => user.sink.add(loggedInUser));
  }

  static final UserRepository _userRepository = UserRepository();
  final BehaviorSubject<FirebaseUser> user = BehaviorSubject<FirebaseUser>();

  Future signOut(BuildContext context) async {
    await _userRepository.signOut();
    await Navigator.of(context).pushReplacementNamed(Routes.initial);
  }

  void dispose() {
    user.close();
  }
}

class ViaductDrawerBlocProvider extends InheritedWidget {

  ViaductDrawerBlocProvider({Widget child}) : super(child: child);

  final bloc = ViaductDrawerBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ViaductDrawerBlocProvider of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType();
}