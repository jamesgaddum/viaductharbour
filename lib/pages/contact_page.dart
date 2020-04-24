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
      body: SingleChildScrollView(
        child: Padding(
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
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: Container(
                  child: Text(
                    'Where Auckland City meets the ocean',
                    style: theme.textTheme.body1.copyWith(
                      letterSpacing: 0.6
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: Container(
                  child: Text(
                    Strings.aboutViaduct,
                    style: theme.primaryTextTheme.body2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 40),
                child: Container(
                  child: Text(
                    'Pretty much if it’s happening – you’ll find it in the Viaduct.',
                    style: theme.textTheme.body1.copyWith(
                      letterSpacing: 0.6
                    ),
                  ),
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
              ),

            ]
          )
        ),
      )
    );
  }
}
