import 'package:flutter/material.dart';
import 'package:viaductharbour/pages/places_page.dart';
import 'package:viaductharbour/strings.dart';
import 'package:viaductharbour/widgets/ensure_visible_when_focussed.dart';

class LocationTypeSelector extends StatelessWidget {

  const LocationTypeSelector({
    Key key,
    @required this.onSelect,
    @required this.locationType
  }) : super(key: key);

  final Function(LocationType) onSelect;
  final LocationType locationType;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        child: Row(
          children: <Widget>[
            EnsureVisibleWhenFocussed(
              isFocussed: locationType == LocationType.restaurants,
              child: FlatButton(
                onPressed: () => onSelect(LocationType.restaurants),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Text(
                    Strings.restaurants,
                    style: locationType == LocationType.restaurants
                      ? theme.textTheme.body2.copyWith(
                          color: theme.accentColor
                        )
                      : theme.textTheme.body2
                  ),
                )
              ),
            ),
            EnsureVisibleWhenFocussed(
              isFocussed: locationType == LocationType.transport,
              child: FlatButton(
                onPressed: () => onSelect(LocationType.transport),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                  child: Text(
                    Strings.transport,
                    style: locationType == LocationType.transport
                      ? theme.textTheme.body2.copyWith(
                          color: theme.accentColor
                        )
                      : theme.textTheme.body2
                  ),
                ),
              ),
            ),
            EnsureVisibleWhenFocussed(
              isFocussed: locationType == LocationType.cruises,
              child: FlatButton(
                onPressed: () => onSelect(LocationType.cruises),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                  child: Text(
                    Strings.cruises,
                    style: locationType == LocationType.cruises
                      ? theme.textTheme.body2.copyWith(
                          color: theme.accentColor
                        )
                      : theme.textTheme.body2
                  ),
                )
              ),
            ),
            EnsureVisibleWhenFocussed(
              isFocussed: locationType == LocationType.accommodation,
              child: FlatButton(
                onPressed: () => onSelect(LocationType.accommodation),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                  child: Text(
                    Strings.accommodation,
                    style: locationType == LocationType.accommodation
                      ? theme.textTheme.body2.copyWith(
                          color: theme.accentColor
                        )
                      : theme.textTheme.body2
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
