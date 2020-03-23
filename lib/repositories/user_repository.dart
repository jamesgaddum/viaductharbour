import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class UserRepository {

  final _googleSignIn = GoogleSignIn();
  final _facebookLogin = FacebookLogin();

  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getLoggedInUser() async {
    return await _auth.currentUser();
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    await _auth.signInWithCredential(credential);
  }

  Future signInWithFacebook() async {
    var result = await _facebookLogin.logIn(['email']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      var credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
      await _auth.signInWithCredential(credential);
    } else {
      throw AuthException(result.status.toString(), 'Facebook login unsuccessful');
    }
  }

  Future signOut() async {
    if (await _auth.currentUser() != null) {
      await _auth.signOut();
    }
    if (_googleSignIn.currentUser != null || await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
    if (await _facebookLogin.isLoggedIn) {
      await _facebookLogin.logOut();
    }

  }
}
