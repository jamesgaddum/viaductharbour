import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/models/accommodation.dart';
import 'package:viaductharbour/widgets/accommodation_carousel_item.dart';

class AccommodationCarousel extends StatelessWidget {

  const AccommodationCarousel({Key key, this.accommodations}) : super(key: key);

  final List<Accommodation> accommodations;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      width: size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: -40,
            right: 0,
            bottom: 0,
            child: CarouselSlider(
              autoPlay: false,
              // autoPlayInterval: Duration(seconds: 7),
              height: size.height * 0.27,
              viewportFraction: 0.8,
              items: accommodations.isNotEmpty
                ? accommodations.map<Widget>((accommodation) {
                  return AccommodationCarouselItem(accommodation: accommodation,);
                }).toList()
                : [ AccommodationCarouselItem(accommodation: Accommodation.empty()) ]
              ),
          ),
        ]
      ),
    );
  }
}
