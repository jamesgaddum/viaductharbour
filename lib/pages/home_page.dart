import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:viaductharbour/blocs/viaduct_bloc.dart';
import 'package:viaductharbour/blocs/viaduct_drawer_bloc.dart';
import 'package:viaductharbour/routes.dart';
import 'package:viaductharbour/strings.dart';
import 'package:viaductharbour/widgets/accommodation_carousel.dart';
import 'package:viaductharbour/widgets/event_carousel.dart';
import 'package:viaductharbour/widgets/restaurant_carousel.dart';
import 'package:viaductharbour/widgets/viaduct_drawer.dart';
import 'package:viaductharbour/widgets/viaduct_scroll_behaviour.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ViaductBloc _bloc;
  final int _currentIndex = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<ViaductBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return StreamBuilder(
      stream: Observable.combineLatest3(
        _bloc.restaurantsStream,
        _bloc.accommodationsStream,
        _bloc.eventsStream,
        (restaurants, accommodations, events) {
          return {
            'restaurants': restaurants,
            'accommodations': accommodations,
            'events': events
          };
        }
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        var restaurants = snapshot.data['restaurants'];
        var accommodations = snapshot.data['accommodations'];
        var events = snapshot.data['events'];
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            brightness: Brightness.light,
            title: Image.asset(
              'assets/images/VH_2020_Horizontal_Lockup_BLACK.png',
              width: size.width * 0.65,
            ),
            centerTitle: true,
          ),
          endDrawer: ViaductDrawerBlocProvider(
            child: ViaductDrawer(
              hiddenMenuItems: [MenuItem.home],
            )
          ),
          body: Container(
            height: size.height,
            width: size.width,
            child: ScrollConfiguration(
              behavior: ViaductScrollBehavior(),
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 40, 0, 10),
                        child: Text(Strings.events),
                      ),
                      EventCarousel(events: events),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 40, 0, 10),
                        child: Text(Strings.restaurants),
                      ),
                      RestaurantCarousel(restaurants: restaurants),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 40, 0, 10),
                        child: Text(Strings.accommodation),
                      ),
                      AccommodationCarousel(accommodations: accommodations),
                       Padding(
                        padding: const EdgeInsets.only(bottom: 30)
                      ),
                    ]
                  ),
                ]
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: theme.accentColor,
            backgroundColor: theme.scaffoldBackgroundColor,
            onTap: (index) => index == _currentIndex
              ? null
              : Navigator.of(context).popUntil(ModalRoute.withName(Routes.places)),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                title: Text(Strings.places),
                icon: Container()
              ),
              BottomNavigationBarItem(
                title: Text(Strings.home),
                icon: Container()
              )
            ],
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
