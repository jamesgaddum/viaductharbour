import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viaductharbour/blocs/viaduct_drawer_bloc.dart';
import 'package:viaductharbour/models/accommodation.dart';
import 'package:viaductharbour/widgets/persistent_header_delegate.dart';
import 'package:viaductharbour/widgets/viaduct_drawer.dart';

class AccommodationPage extends StatelessWidget {

  AccommodationPage(this.accommodation, this.tag);

  final Accommodation accommodation;
  final String tag;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      endDrawer: ViaductDrawerBlocProvider(
        child: ViaductDrawer(
          hiddenMenuItems: [],
        )
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            expandedHeight: size.width,
            floating: false,
            pinned: true,
            actions: <Widget>[],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: size.width,
                width: size.width,
                child: GestureDetector(
                  child: Hero(
                    tag: tag,
                    child: CachedNetworkImage(
                      imageUrl: accommodation.photoUrl,
                      key: ValueKey(accommodation.photoUrl),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: Center(child: CircularProgressIndicator())
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  ),
                  onTap: () => Navigator.of(context).pop(),
                  onVerticalDragStart: (_) => Navigator.of(context).pop(),
                  onHorizontalDragStart: (_) => Navigator.of(context).pop(),
                )
              ),
            )
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: PersistentHeaderDelegate(
              minHeight: 100,
              maxHeight: 100,
              child: Material(
                elevation: 2,
                color: theme.scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (accommodation.phone.isNotEmpty) IconButton(
                            padding: EdgeInsets.only(top: 2),
                            icon: Icon(
                              Icons.phone,
                              size: 28
                            ),
                            onPressed: () async {
                              var url = 'tel:${accommodation.phone}';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            }
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                child: Container(
                  child: Text(
                    accommodation.description,
                    style: theme.primaryTextTheme.body2,
                  )
                ),
              ),
            ]),
          )
        ],
      )
    );
  }
}
