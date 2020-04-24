import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viaductharbour/app.dart';
import 'package:viaductharbour/blocs/initial_bloc.dart';
import 'package:viaductharbour/blocs/login_bloc.dart';
import 'package:viaductharbour/blocs/permissions_bloc.dart';
import 'package:viaductharbour/blocs/viaduct_bloc.dart';
import 'package:viaductharbour/blocs/viaduct_drawer_bloc.dart';
import 'package:viaductharbour/services/permissions_service.dart';

class BlocProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<InitialBloc>(create: (_) => InitialBloc()),
        Provider<LoginBloc>(create: (_) => LoginBloc()),
        Provider<PermissionsBloc>(create: (_) => PermissionsBloc()),
        Provider<ViaductBloc>(create: (_) => ViaductBloc(
          permissionsService: Provider.of<PermissionsService>(context))
        ),
        Provider<ViaductDrawerBloc>(create: (_) => ViaductDrawerBloc()),
      ],
      child: App(),
    );
  }
}
