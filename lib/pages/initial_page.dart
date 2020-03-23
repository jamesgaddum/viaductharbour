import 'package:flutter/material.dart';
import 'package:viaductharbour/blocs/initial_bloc.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  InitialBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = InitialBlocProvider.of(context).bloc;
    _bloc.obtainCurrentUser(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}