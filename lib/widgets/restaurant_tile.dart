import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/models/restaurant.dart';
import 'package:viaductharbour/pages/restaurant_page.dart';

class RestaurantTile extends StatelessWidget {

  const RestaurantTile({Key key, this.restaurant}) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var tag = '${restaurant.ref.documentID} ${context.hashCode} tile';
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
                  imageUrl: restaurant.photoUrl,
                  key: ValueKey(restaurant.photoUrl),
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
                  restaurant.name.toUpperCase(),
                  style: theme.primaryTextTheme.body1,
                ),
                subtitle: Text(
                  restaurant.distanceInMString,
                  style: theme.primaryTextTheme.body2
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RestaurantPage(restaurant, tag))
          );
        },
      ),
    );
  }
}
