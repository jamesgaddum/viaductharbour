import 'package:viaductharbour/repositories/user_repository.dart';

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
