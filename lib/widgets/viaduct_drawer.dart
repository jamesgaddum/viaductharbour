import 'package:flutter/material.dart';
import 'package:viaductharbour/blocs/viaduct_drawer_bloc.dart';
import 'package:viaductharbour/pages/places_page.dart';
import 'package:viaductharbour/routes.dart';
import 'package:viaductharbour/strings.dart';
import 'package:viaductharbour/widgets/marina_submenu.dart';

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
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  if (!widget.hiddenMenuItems.contains(MenuItem.eatAndDrink)) ...[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    FlatButton(
                      child: Text(
                        Strings.restaurants,
                        style: theme.accentTextTheme.body1,
                      ),
                      onPressed: () => _navigateToWithArgs(
                        Routes.places,
                        {
                          'locationType': LocationType.restaurants,
                          'isMapView': true
                        }
                      )
                    ),
                  ],
                  if (!widget.hiddenMenuItems.contains(MenuItem.accomodation)) ...[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    FlatButton(
                      child: Text(
                        Strings.accommodation,
                        style: theme.accentTextTheme.body1,
                      ),
                      onPressed: () => _navigateToWithArgs(
                        Routes.places,
                        {
                          'locationType': LocationType.accommodation,
                          'isMapView': true
                        }
                      )
                    ),
                  ],
                  if (!widget.hiddenMenuItems.contains(MenuItem.cruises)) ...[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    FlatButton(
                      child: Text(
                        Strings.cruises,
                        style: theme.accentTextTheme.body1,
                      ),
                      onPressed: () => _navigateToWithArgs(
                        Routes.places,
                        {
                          'locationType': LocationType.cruises,
                          'isMapView': true
                        }
                      )
                    ),
                  ],
                  if (!widget.hiddenMenuItems.contains(MenuItem.transport)) ...[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    FlatButton(
                      child: Text(
                        Strings.transport,
                        style: theme.accentTextTheme.body1,
                      ),
                      onPressed: () => _navigateToWithArgs(
                        Routes.places,
                        {
                          'locationType': LocationType.transport,
                          'isMapView': true
                        }
                      )
                    ),
                  ],
                  MarinaSubMenu(hiddenMenuItems: widget.hiddenMenuItems,),
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
    if (route == Routes.places) {
      await Navigator.of(context).popUntil(ModalRoute.withName(route));
      return;
    }
    if (ModalRoute.of(context).settings.name == Routes.places) {
      await Navigator.of(context).pushNamed(route);
    } else {
      await Navigator.of(context).popAndPushNamed(route);
    }
  }

  void _navigateToWithArgs(String route, dynamic arguments) async {
    if (route == Routes.places) {
      await Navigator.of(context).popUntil(ModalRoute.withName(route));
      return;
    }
    if (ModalRoute.of(context).settings.name == Routes.places) {
      await Navigator.of(context).pushNamed(route, arguments: arguments);
    } else {
      await Navigator.of(context).popAndPushNamed(route, arguments: arguments);
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
  eatAndDrink,
  accomodation,
  cruises,
  transport,
  marina,
  settings,
  contact,
  bookABerth,
  contractors,
  marinaMap
}
