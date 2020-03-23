import 'package:viaductharbour/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class LoginBloc {

  static final UserRepository _userRepository = UserRepository();

  Future signInWithGoogle() async {
    await _userRepository.signInWithGoogle();
  }

  Future signInWithFacebook() async {
    await _userRepository.signInWithFacebook();
  }

  void dispose() {}
}

class LoginBlocProvider extends InheritedWidget {

  LoginBlocProvider({Widget child}) : super(child: child);

  final bloc = LoginBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBlocProvider of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType();
}
