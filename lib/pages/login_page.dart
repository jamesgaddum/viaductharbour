import 'package:flutter/material.dart';
import 'package:viaductharbour/blocs/login_bloc.dart';
import 'package:viaductharbour/routes.dart';
import 'package:viaductharbour/strings.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _loginScaffoldKey = GlobalKey<ScaffoldState>();

  LoginBloc _bloc;

  var _isSigningIn = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LoginBlocProvider.of(context).bloc;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    if (_isSigningIn) {
      return Scaffold(
        backgroundColor: theme.accentColor,
        body: Center(child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),)
      );
    }
    return Scaffold(
      key: _loginScaffoldKey,
      backgroundColor: theme.accentColor,
      body: Center(
        child: Container(
          height: size.height,
          width: size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(flex: 6,),
              Image.asset('assets/images/VH_2020_Horizontal_Lockup_LAGOON_BLUE.png',),
              Spacer(flex: 6,),
              Text(
                Strings.connectWith,
                style: theme.textTheme.display1,
              ),
              Spacer(),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(flex: 5),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Image.asset(
                          'assets/images/google.png',
                          height: 20,
                        ),
                      ),
                      onTap: () => _signInWithGoogle(),
                    ),
                    Spacer(flex: 3,),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Image.asset(
                          'assets/images/facebook.png',
                          height: 20,
                        ),
                      ),
                      onTap: () => _signInWithFacebook(),
                    ),
                    Spacer(flex: 5),
                  ],
                ),
              ),
              Spacer(flex: 6,),
            ],
          )
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    var theme = Theme.of(context);
    try {
      setState(() {
        _isSigningIn = true;
      });
      await _bloc.signInWithGoogle();
      await Navigator.of(context).pushNamed(Routes.permissions);
    } catch(e) {
      setState(() {
        _isSigningIn = false;
      });
      _loginScaffoldKey.currentState?.showSnackBar(SnackBar(
        backgroundColor: theme.primaryColor,
        content: Text(
          'Sign in with Google was unsuccessful',
          style: theme.textTheme.body1,
        ),
      ));
    }
  }

  Future<void> _signInWithFacebook() async {
    var theme = Theme.of(context);
    try {
      setState(() {
        _isSigningIn = true;
      });
      await _bloc.signInWithFacebook();
      await Navigator.of(context).pushNamed(Routes.permissions);
    } catch(e) {
      setState(() {
        _isSigningIn = false;
      });
      _loginScaffoldKey.currentState?.showSnackBar(SnackBar(
        backgroundColor: theme.primaryColor,
        content: Text(
          'Sign in with Facebook was unsuccessful',
          style: theme.textTheme.body1,
        ),
      ));
    }
  }
}
