import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/models/restaurant.dart';
import 'package:viaductharbour/pages/restaurant_page.dart';

class RestaurantCarouselItem extends StatelessWidget {

  const RestaurantCarouselItem({Key key, this.restaurant}) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var tag = '${restaurant.ref?.documentID} ${context.hashCode} carousel item';
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
              height: size.height * 0.2,
              width: size.width * 0.8,
              child: restaurant.photoUrl != null
                ? Hero(
                    tag: tag,
                    child: CachedNetworkImage(
                      imageUrl: restaurant.photoUrl,
                      key: ValueKey(restaurant.photoUrl),
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
                  restaurant.name?.toUpperCase() ?? '',
                  style: theme.primaryTextTheme.body1,
                ),
              ),
            )
          ]
        ),
      ),
      onTap: () => restaurant.ref != null ? Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RestaurantPage(restaurant, tag))
      ) : null
    );
  }
}
