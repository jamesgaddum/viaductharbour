import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:viaductharbour/models/event.dart';
import 'package:viaductharbour/widgets/event_carousel_item.dart';

class EventCarousel extends StatelessWidget {

  const EventCarousel({Key key, this.events}) : super(key: key);

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.45,
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
              height: size.height * 0.43,
              viewportFraction: 0.8,
              items: events.isNotEmpty
                ? events.map<Widget>((event) {
                  return EventCarouselItem(event: event,);
                }).toList()
                : [ EventCarouselItem(event: Event.empty()) ]
              ),
          ),
        ]
      ),
    );
  }
}
