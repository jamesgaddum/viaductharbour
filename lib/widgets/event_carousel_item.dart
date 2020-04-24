import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/models/event.dart';
import 'package:viaductharbour/pages/event_page.dart';

class EventCarouselItem extends StatelessWidget {

  const EventCarouselItem({Key key, this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var tag = '${event.ref?.documentID} ${context.hashCode} carousel item';
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 5.0,
              offset: Offset(1, 2)
            ),
          ]
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.35,
              width: size.width * 0.8,
              child: event.photoUrl != null
                ? Hero(
                    tag: tag,
                    child: CachedNetworkImage(
                      imageUrl: event.photoUrl,
                      key: ValueKey(event.photoUrl),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: theme.indicatorColor,
                        child: Center(child: CircularProgressIndicator())
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: theme.indicatorColor,
                        child: Center(child: CircularProgressIndicator())
                      ),
                    )
                  )
                : Container(
                    color: theme.indicatorColor,
                    child: Center(child: CircularProgressIndicator())
                  ),
            ),
            Container(
              height: size.height * 0.07,
              width: size.width * 0.8,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  event.name?.toUpperCase() ?? '',
                  style: theme.primaryTextTheme.body1,
                ),
              ),
            )
          ]
        ),
      ),
      onTap: () => event.ref != null ? Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EventPage(event, tag))
      ) : null
    );
  }
}
