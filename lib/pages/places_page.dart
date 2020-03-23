import 'package:bitmap/bitmap.dart';
import 'package:bitmap/transformations.dart' as bmp;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:viaductharbour/blocs/viaduct_bloc.dart';
import 'package:viaductharbour/blocs/viaduct_drawer_bloc.dart';
import 'package:viaductharbour/models/location.dart';
import 'package:viaductharbour/routes.dart';
import 'package:viaductharbour/strings.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:viaductharbour/widgets/accommodation_tile.dart';
import 'package:viaductharbour/widgets/cruise_tile.dart';
import 'package:viaductharbour/widgets/restaurant_tile.dart';
import 'package:viaductharbour/widgets/transport_tile.dart';
import 'package:viaductharbour/widgets/viaduct_drawer.dart';
import 'package:viaductharbour/widgets/viaduct_scroll_behaviour.dart';

class PlacesPage extends StatefulWidget {
  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {

  static const double _zoom = 15.7;
  static const appBarHeight = 95.0;
  static const bottomAppBarHeight = 80.0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isMapView;

  Map<LocationType, LatLng> _centers = {
    LocationType.accommodation: LatLng(-36.844029, 174.760516),
    LocationType.restaurants: LatLng(-36.843462, 174.762039),
    LocationType.cruises: LatLng(-36.843162, 174.761321),
    LocationType.transport: LatLng(-36.844045, 174.764700),
  };

  GoogleMapController _mapController;
  ScrollController _listScrollController;
  ScrollController _locationsSelectorScrollController;
  Location _selectedLocation;
  BitmapDescriptor _pin;
  BitmapDescriptor _selectedPin;
  LocationType _locationType;
  ViaductBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _locationType = LocationType.restaurants;
    _listScrollController = ScrollController();
    _locationsSelectorScrollController = ScrollController();
    _isMapView = true;
    _setLocationIcons();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _homeBloc = ViaductBlocProvider.of(context).bloc;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: Observable.combineLatest5(
        _homeBloc.restaurantsStream,
        _homeBloc.accommodationsStream,
        _homeBloc.eventsStream,
        _homeBloc.cruiseStream,
        _homeBloc.transportStream,
        (restaurants, accommodation, events, cruises, transport) {
          return {
            'restaurants': restaurants,
            'accommodation': accommodation,
            'events': events,
            'cruises': cruises,
            'transport': transport
          };
        }
      ),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return Container();
        }

        var locations = snapshot.data[describeEnum(_locationType)];

        var locationSelector = Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 8.5,
                  offset: Offset(0, 8)
                ),
              ]
            ),
            child: ListView(
              controller: _locationsSelectorScrollController,
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    setState(() {
                      _selectedLocation = null;
                      _locationType = LocationType.restaurants;
                    });
                    _locationsSelectorScrollController.animateTo(
                      0.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear
                    );
                    _centerMap();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      Strings.restaurants,
                      style: _locationType == LocationType.restaurants
                        ? theme.textTheme.body2.copyWith(
                            color: theme.accentColor
                          )
                        : theme.textTheme.body2
                    ),
                  )
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      _selectedLocation = null;
                      _locationType = LocationType.accommodation;
                    });
                    _locationsSelectorScrollController.animateTo(
                      size.width * 0.1,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear
                    );
                    _centerMap();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                    child: Text(
                      Strings.accommodation,
                      style: _locationType == LocationType.accommodation
                        ? theme.textTheme.body2.copyWith(
                            color: theme.accentColor
                          )
                        : theme.textTheme.body2
                    ),
                  )
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      _selectedLocation = null;
                      _locationType = LocationType.cruises;
                    });
                    _locationsSelectorScrollController.animateTo(
                      size.width * 0.4,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear
                    );
                    _centerMap();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                    child: Text(
                      Strings.cruises,
                      style: _locationType == LocationType.cruises
                        ? theme.textTheme.body2.copyWith(
                            color: theme.accentColor
                          )
                        : theme.textTheme.body2
                    ),
                  )
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      _selectedLocation = null;
                      _locationType = LocationType.transport;
                    });
                    _locationsSelectorScrollController.animateTo(
                      size.width,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear
                    );
                    _centerMap();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                    child: Text(
                      Strings.transport,
                      style: _locationType == LocationType.transport
                        ? theme.textTheme.body2.copyWith(
                            color: theme.accentColor
                          )
                        : theme.textTheme.body2
                    ),
                  )
                ),
              ],
            ),
          )
        );

        var mapView = Stack(
          children: <Widget>[
            Positioned.fill(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _centers[_locationType],
                  zoom: _zoom,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                markers: _getMarkers(locations),
                mapToolbarEnabled: false,
                onTap: (location) {
                  setState(() {
                    if (_selectedLocation != null) {
                      _selectedLocation = null;
                    }
                  });
                  _centerMap();
                },
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 250),
              top: _selectedLocation != null ? 0 : -210,
              left: 0,
              child: Container(
                width: size.width,
                height: 210,
                alignment: Alignment.bottomLeft,
                color: Colors.transparent,
                child: _selectedLocation != null ?
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            offset: Offset(1, 2)
                          ),
                        ]
                      ),
                      child: _getLocationTile(_locationType, _selectedLocation)
                    )
                  )
                : Container(),
              ),
            ),
            locationSelector,
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLocation = null;
                        _isMapView = !_isMapView;
                      });
                      _centerMap();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                      child: Text(
                        _isMapView ? Strings.listView : Strings.mapView,
                        style: theme.textTheme.body1,
                      ),
                    )
                  ),
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
                  ),
                ],
              ),
            )
          ]
        );

        var listView = Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: 60,
              right: 0,
              bottom: 70,
              child: Container(
                child: ScrollConfiguration(
                  behavior: ViaductScrollBehavior(),
                  child: ListView.separated(
                    controller: _listScrollController,
                    itemCount: locations.length,
                    itemBuilder: (context, i) {
                      return _getLocationTile(_locationType, locations[i]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        color: Colors.transparent,
                      );
                    },
                  ),
                )
              ),
            ),
            locationSelector,
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Material(
                elevation: 4,
                child: AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  actions: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLocation = null;
                          _isMapView = !_isMapView;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                        child: Text(
                          _isMapView ? Strings.listView : Strings.mapView,
                          style: theme.textTheme.body1,
                        ),
                      )
                    ),
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
                    ),
                  ],
                ),
              ),
            ),
            if (locations.isEmpty) Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(),
              )
            )
          ]
        );

        return Scaffold(
          key: _scaffoldKey,
          endDrawer: ViaductDrawerBlocProvider(
            child: ViaductDrawer(
              hiddenMenuItems: [MenuItem.places],
            ),
          ),
          body: Container(
            height: size.height,
            width: size.width,
            child: _isMapView ? mapView : listView,
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            currentIndex: 1,
            selectedItemColor: theme.accentColor,
            backgroundColor: theme.scaffoldBackgroundColor,
            onTap: (value) => Navigator.of(context).popUntil(ModalRoute.withName(Routes.home)),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                title: Text(Strings.home),
                icon: Container(),
              ),
              BottomNavigationBarItem(
                title: Text(Strings.places),
                icon: Container()
              )
            ],
          ),
        );
      }
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    await _mapController.setMapStyle(await rootBundle.loadString('assets/map_style.json'));
  }

  Set<Marker> _getMarkers(List<Location> locations) {
    return Set<Marker>.from(locations.map((location) {
      return Marker(
        markerId: MarkerId(location.ref.documentID),
        position: LatLng(location.location.latitude, location.location.longitude),
        onTap: () {
          setState(() => _selectedLocation = location);
        },
        icon: location.ref.documentID == _selectedLocation?.ref?.documentID ? _selectedPin : _pin
      );
    }));
  }

  void _setLocationIcons() async {
    var pin = await _getLocationIconFromAsset('assets/images/pin.png');
    var selectedPin = await _getLocationIconFromAsset('assets/images/selected_pin.png');
    setState(() {
      _pin = pin;
      _selectedPin = selectedPin;
    });
  }

  Future<BitmapDescriptor> _getLocationIconFromAsset(String assetPath) async {
    var installationBitmap = await Bitmap.fromProvider(AssetImage(assetPath));
    var resizedInstallationBitmap = await bmp.resize(installationBitmap, 60, 100);
    return await BitmapDescriptor.fromBytes(resizedInstallationBitmap.buildHeaded());
  }

  Widget _getLocationTile(LocationType locationType, Location location) {
    switch(describeEnum(locationType)) {
      case 'restaurants':
        return RestaurantTile(restaurant: location,);
      case 'accommodation':
        return AccommodationTile(accommodation: location,);
      case 'cruises':
        return CruiseTile(cruise: location,);
      case 'transport':
        return TransportTile(transport: location,);
      default:
        return Container();
    }
  }

  void _centerMap() {
    if (_isMapView) {
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: _centers[_locationType],
        zoom: _zoom
      )));
    }
  }
}

enum LocationType {
  restaurants,
  accommodation,
  cruises,
  transport
}
