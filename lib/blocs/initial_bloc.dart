import 'package:viaductharbour/routes.dart';
import 'package:viaductharbour/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class InitialBloc {

  static final _userRepository = UserRepository();

  Future obtainCurrentUser(BuildContext context) async {
    try {
      var loggedInUser = await _userRepository.getLoggedInUser();
      if (loggedInUser != null) {
        await Navigator.of(context).pushReplacementNamed(Routes.places);
      } else {
        await Navigator.of(context).pushReplacementNamed(Routes.login);
      }
    } catch(e) {
      await Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }

  void dispose() {}
}
