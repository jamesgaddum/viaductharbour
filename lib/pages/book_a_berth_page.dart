import 'package:flutter/material.dart';
import 'package:viaductharbour/blocs/viaduct_drawer_bloc.dart';
import 'package:viaductharbour/strings.dart';
import 'package:viaductharbour/widgets/viaduct_drawer.dart';

class BookABerthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      endDrawer: ViaductDrawerBlocProvider(
        child: ViaductDrawer(
          hiddenMenuItems: [MenuItem.bookABerth],
        )
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, size.height * 0.1, 20, size.height * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 30),
              child: Text(
                Strings.bookABerth,
                style: theme.primaryTextTheme.display1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
