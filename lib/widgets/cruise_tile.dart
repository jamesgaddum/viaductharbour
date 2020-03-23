import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/models/cruise.dart';
import 'package:viaductharbour/pages/cruise_page.dart';

class CruiseTile extends StatelessWidget {

  const CruiseTile({Key key, this.cruise}) : super(key: key);

  final Cruise cruise;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var tag = '${cruise.ref.documentID} ${context.hashCode} tile';
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
      ),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              child: Hero(
                tag: tag,
                child: CachedNetworkImage(
                  imageUrl: cruise.photoUrl,
                  key: ValueKey(cruise.photoUrl),
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
                  cruise.name.toUpperCase(),
                  style: theme.primaryTextTheme.body1,
                ),
                subtitle: Text(
                  cruise.distanceInMString,
                  style: theme.primaryTextTheme.body2
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CruisePage(cruise, tag))
          );
        },
      ),
    );
  }
}
