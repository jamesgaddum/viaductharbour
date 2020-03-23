import 'package:flutter/material.dart';
import 'package:viaductharbour/blocs/viaduct_drawer_bloc.dart';
import 'package:viaductharbour/routes.dart';
import 'package:viaductharbour/strings.dart';

class ViaductDrawer extends StatefulWidget {

  const ViaductDrawer({
    Key key,
    @required this.hiddenMenuItems
  }) : super(key: key);

  final List<MenuItem> hiddenMenuItems;

  @override
  _ViaductDrawerState createState() => _ViaductDrawerState();
}

class _ViaductDrawerState extends State<ViaductDrawer> {

  ViaductDrawerBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = ViaductDrawerBlocProvider.of(context).bloc;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return StreamBuilder<Object>(
      stream: _bloc.user,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return Container(
          width: size.width * 0.7,
          child: Drawer(
            child: Container(
              color: theme.accentColor,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!widget.hiddenMenuItems.contains(MenuItem.home)) ...[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    FlatButton(
                      child: Text(
                        Strings.home,
                        style: theme.accentTextTheme.body1,
                      ),
                      onPressed: () => _navigateTo(Routes.home)
                    ),
                  ],
                  if (!widget.hiddenMenuItems.contains(MenuItem.places)) ...[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    FlatButton(
                      child: Text(
                        Strings.places,
                        style: theme.accentTextTheme.body1,
                      ),
                      onPressed: () => _navigateTo(Routes.places)
                    ),
                  ],
                  if (!widget.hiddenMenuItems.contains(MenuItem.contact)) ...[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    FlatButton(
                      child: Text(
                        Strings.contactUs,
                        style: theme.accentTextTheme.body1,
                      ),
                      onPressed: () => _navigateTo(Routes.contact)
                    ),
                  ],
                  if (!widget.hiddenMenuItems.contains(MenuItem.bookABerth)) ...[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    FlatButton(
                      child: Text(
                        Strings.bookABerth,
                        style: theme.accentTextTheme.body1,
                      ),
                      onPressed: () => _navigateTo(Routes.bookABerth)
                    ),
                  ],
                  if (!widget.hiddenMenuItems.contains(MenuItem.settings)) ...[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    FlatButton(
                      child: Text(
                        Strings.settings,
                        style: theme.accentTextTheme.body1,
                      ),
                      onPressed: () => _navigateTo(Routes.settings)
                    ),
                  ],
                  Padding(padding: EdgeInsets.only(top: 10)),
                  FlatButton(
                    child: Text(
                      Strings.signOut,
                      style: theme.accentTextTheme.body1,
                    ),
                    onPressed: () async => await _bloc.signOut(context),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  void _navigateTo(String route) async {
    if (route == Routes.home) {
      await Navigator.of(context).popUntil(ModalRoute.withName(route));
      return;
    }
    if (ModalRoute.of(context).settings.name == Routes.home) {
      await Navigator.of(context).pushNamed(route);
    } else {
      await Navigator.of(context).popAndPushNamed(route);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}

enum MenuItem {
  home,
  places,
  settings,
  contact,
  bookABerth
}
