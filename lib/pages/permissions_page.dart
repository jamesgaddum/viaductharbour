import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viaductharbour/blocs/permissions_bloc.dart';

class PermissionsPage extends StatefulWidget {
  @override
  _PermissionsPageState createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {

  PermissionsBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<PermissionsBloc>(context);
    _bloc.requestPermissions(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
