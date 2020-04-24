import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/models/accommodation.dart';
import 'package:viaductharbour/pages/accommodation_page.dart';

class AccommodationCarouselItem extends StatelessWidget {

  const AccommodationCarouselItem({Key key, this.accommodation}) : super(key: key);

  final Accommodation accommodation;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var tag = '${accommodation.ref?.documentID} ${context.hashCode} carousel item';
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
              child: accommodation.photoUrl != null
                ? Hero(
                    tag: tag,
                    child: CachedNetworkImage(
                      imageUrl: accommodation.photoUrl,
                      key: ValueKey(accommodation.photoUrl),
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
                  accommodation.name?.toUpperCase() ?? '',
                  style: theme.primaryTextTheme.body1,
                ),
              ),
            )
          ]
        ),
      ),
      onTap: () => accommodation.ref != null ? Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AccommodationPage(accommodation, tag))
      ) : null,
    );
  }
}
