import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EnsureVisibleWhenFocussed extends StatefulWidget {

  const EnsureVisibleWhenFocussed({
    Key key,
    @required this.child,
    @required this.isFocussed,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 100),
  }) : super(key: key);

  final Widget child;
  final bool isFocussed;
  final Curve curve;
  final Duration duration;

  @override
  EnsureVisibleWhenFocussedState createState() => EnsureVisibleWhenFocussedState();
}

class EnsureVisibleWhenFocussedState extends State<EnsureVisibleWhenFocussed> {

  @override
  void didUpdateWidget(EnsureVisibleWhenFocussed oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFocussed) {
      _ensureVisible();
    }
  }

  Future<Null> _ensureVisible() async {
    if (!widget.isFocussed) {
      return;
    }
    final object = context.findRenderObject();
    final viewport = RenderAbstractViewport.of(object);
    assert(viewport != null);

    var scrollableState = Scrollable.of(context);
    assert(scrollableState != null);

    var position = scrollableState.position;
    double alignment;
    if (position.pixels > viewport.getOffsetToReveal(object, 0.0).offset) {
      alignment = 0.3;
    } else {
      if (position.pixels < viewport.getOffsetToReveal(object, 1.0).offset) {
        alignment = 0.7;
      } else {
        return;
      }
    }
    await position.ensureVisible(
      object,
      alignment: alignment,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
