import 'package:flutter/material.dart';
import 'package:viaductharbour/models/event.dart';
import 'package:viaductharbour/pages/event_page.dart';

class EventTile extends StatelessWidget {

  const EventTile({Key key, this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var tag = '${event.ref.documentID} ${context.hashCode} tile';
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
      ),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(
                  event.name.toUpperCase(),
                  style: theme.primaryTextTheme.body1,
                ),
              ),
            ),
            Container(
              height: 100,
              width: 100,
              child: Hero(
                tag: tag,
                child: Image.network(
                  event.photoUrl,
                  key: ValueKey(event.photoUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventPage(event, tag))
          );
        },
      ),
    );
  }
}