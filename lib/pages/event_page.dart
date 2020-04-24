import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/blocs/viaduct_drawer_bloc.dart';
import 'package:viaductharbour/models/event.dart';
import 'package:viaductharbour/widgets/persistent_header_delegate.dart';
import 'package:viaductharbour/widgets/viaduct_drawer.dart';

class EventPage extends StatelessWidget {

  EventPage(this.event, this.tag);

  final Event event;
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
            expandedHeight: size.width,
            floating: false,
            pinned: true,
            elevation: 0,
            actions: <Widget>[],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: size.width,
                width: size.width,
                child: GestureDetector(
                  child: Hero(
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
                  ),
                  onTap: () => Navigator.of(context).pop(),
                )
              ),
            )
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: PersistentHeaderDelegate(
              minHeight: 80,
              maxHeight: 80,
              child: Material(
                elevation: 2,
                color: theme.scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: ListTile(
                      title: Text(
                        event.name.toUpperCase(),
                        style: theme.primaryTextTheme.body1,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 50),
                child: Container(
                  child: Text(
                    event.description,
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
