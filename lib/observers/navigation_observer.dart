import 'package:flutter/material.dart';

class NavigationObserver extends StatefulWidget {

  const NavigationObserver({
    Key key,
    @required this.routeObserver
  }) : super(key: key);

  final RouteObserver<PageRoute> routeObserver;

  @override
  _NavigationObserverState createState() => _NavigationObserverState();
}

class _NavigationObserverState extends State<NavigationObserver> with RouteAware {


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    widget.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    print(ModalRoute.of(context).settings.name);
  }

  @override
  void didPopNext() {
    print(ModalRoute.of(context).settings.name);
  }

  @override
  Widget build(BuildContext context) => Container();
}
