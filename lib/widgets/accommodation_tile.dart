import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/models/accommodation.dart';
import 'package:viaductharbour/pages/accommodation_page.dart';

class AccommodationTile extends StatelessWidget {

  const AccommodationTile({Key key, this.accommodation}) : super(key: key);

  final Accommodation accommodation;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var tag = '${accommodation.ref.documentID} ${context.hashCode} tile';
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
                  imageUrl: accommodation.photoUrl,
                  key: ValueKey(accommodation.photoUrl),
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
                  accommodation.name.toUpperCase(),
                  style: theme.primaryTextTheme.body1,
                ),
                subtitle: Text(
                  accommodation.distanceInMString,
                  style: theme.primaryTextTheme.body2
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AccommodationPage(accommodation, tag))
          );
        },
      ),
    );
  }
}
