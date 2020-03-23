import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/models/restaurant.dart';
import 'package:viaductharbour/widgets/restaurant_carousel_item.dart';

class RestaurantCarousel extends StatelessWidget {

  const RestaurantCarousel({Key key, this.restaurants}) : super(key: key);

  final List<Restaurant> restaurants;

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
              items: restaurants.isNotEmpty
                ? restaurants.map<Widget>((restaurant) {
                  return RestaurantCarouselItem(restaurant: restaurant,);
                }).toList()
                : [
                  RestaurantCarouselItem(restaurant: Restaurant.empty(),)
                ]
              ),
          ),
        ]
      ),
    );
  }
}
