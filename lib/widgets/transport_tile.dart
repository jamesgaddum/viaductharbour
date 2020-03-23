import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/models/transport.dart';
import 'package:viaductharbour/pages/transport_page.dart';

class TransportTile extends StatelessWidget {

  const TransportTile({Key key, this.transport}) : super(key: key);

  final Transport transport;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var tag = '${transport.ref.documentID} ${context.hashCode} tile';
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            child: Hero(
              tag: tag,
              child: CachedNetworkImage(
                imageUrl: transport.photoUrl,
                key: ValueKey(transport.photoUrl),
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: theme.indicatorColor,
                  child: Center(child: CircularProgressIndicator())
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                transport.name.toUpperCase(),
                style: theme.primaryTextTheme.body1,
              ),
              subtitle: Text(
                transport.distanceInMString,
                style: theme.primaryTextTheme.body2
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TransportPage(transport, tag))
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
