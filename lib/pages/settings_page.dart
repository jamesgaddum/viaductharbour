import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/blocs/viaduct_drawer_bloc.dart';
import 'package:viaductharbour/strings.dart';
import 'package:viaductharbour/widgets/viaduct_drawer.dart';

class SettingsPage extends StatelessWidget {
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
          hiddenMenuItems: [MenuItem.settings],
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
                Strings.settings,
                style: theme.primaryTextTheme.display1,
              ),
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  Strings.locationSettings,
                  style: theme.textTheme.body1,
                ),
              ),
              trailing: Icon(
                Icons.open_in_new,
                color: theme.iconTheme.color,
              ),
              onTap: () => AppSettings.openLocationSettings(),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  Strings.notificationSettings,
                  style: theme.textTheme.body1,
                ),
              ),
              trailing: Icon(
                Icons.open_in_new,
                color: theme.iconTheme.color,
              ),
              onTap: () => AppSettings.openNotificationSettings(),
            )
          ],
        ),
      ),
    );
  }
}
