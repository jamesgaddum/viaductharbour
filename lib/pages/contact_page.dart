import 'package:flutter/material.dart';
import 'package:viaductharbour/blocs/viaduct_drawer_bloc.dart';
import 'package:viaductharbour/strings.dart';
import 'package:viaductharbour/widgets/viaduct_drawer.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: ViaductDrawerBlocProvider(
        child: ViaductDrawer(
          hiddenMenuItems: [MenuItem.contact],
        )
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, size.height * 0.1, 20, size.height * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 40),
              child: Text(
                Strings.contactUs,
                style: theme.primaryTextTheme.display1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      Strings.emergencyPhone,
                    )
                  ),
                  Text(
                    Strings.emergencyPhoneValue,
                    style: theme.primaryTextTheme.body2,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      Strings.email,
                    )
                  ),
                  Text(
                    Strings.emailValue,
                    style: theme.primaryTextTheme.body2,
                  )
                ],
              ),
            )
          ]
        )
      )
    );
  }
}
