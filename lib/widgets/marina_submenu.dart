import 'package:flutter/material.dart';
import 'package:viaductharbour/routes.dart';
import 'package:viaductharbour/strings.dart';
import 'package:viaductharbour/widgets/viaduct_drawer.dart';

class MarinaSubMenu extends StatefulWidget {

  const MarinaSubMenu({
    Key key,
    @required this.hiddenMenuItems
  }) : super(key: key);

  final List<MenuItem> hiddenMenuItems;

  @override
  _MarinaSubMenuState createState() => _MarinaSubMenuState();
}

class _MarinaSubMenuState extends State<MarinaSubMenu> {

  bool _isOpen = false;
  bool _isShowing = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var height = (3 - widget.hiddenMenuItems.where((menuItem) => [
      MenuItem.contractors,
      MenuItem.marinaMap,
      MenuItem.bookABerth
    ].contains(menuItem)).length) * 48.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 10)),
        FlatButton(
          child: Text(
            Strings.marina,
            style: theme.accentTextTheme.body1,
          ),
          onPressed: () => setState(() {
            if (_isOpen) {
              _isShowing = false;
            }
            _isOpen = !_isOpen;
          })
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 150),
          height: _isOpen ? height : 0,
          onEnd: () => setState(() {
            _isShowing = _isOpen;
          }),
          child: _isShowing
            ? Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (!widget.hiddenMenuItems.contains(MenuItem.contractors)) FlatButton(
                      child: Text(
                        Strings.contractors,
                        style: theme.accentTextTheme.body1,
                      ),
                      onPressed: () => _navigateTo(Routes.contractors)
                    ),
                    if (!widget.hiddenMenuItems.contains(MenuItem.marinaMap)) FlatButton(
                      child: Text(
                        Strings.marinaMap,
                        style: theme.accentTextTheme.body1,
                      ),
                      onPressed: () => {}
                    ),
                    if (!widget.hiddenMenuItems.contains(MenuItem.bookABerth)) FlatButton(
                      child: Text(
                        Strings.bookABerth,
                        style: theme.accentTextTheme.body1,
                      ),
                      onPressed: () => _navigateTo(Routes.bookABerth)
                    ),
                  ],
                ),
              )
            : Container()
        )
      ],
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
}
