import 'dart:math';
import 'package:flutter/material.dart';

class DarkTransition extends StatefulWidget {
  /// Deinfe the widget that will be transitioned
  /// int index is either 1 or 2 to identify widgets, 2 is the top widget
  final Widget Function(BuildContext, int) childBuilder;

  /// the current state of the theme
  final bool isDark;

  /// optional animation controller to controll the animation
  final AnimationController? themeController;

  /// centeral point of the circular transition
  final Offset offset;

  /// optional radius of the circle defaults to [max(height,width)*1.5])
  final double? radius;

  /// duration of animation defaults to 400ms
  final Duration? duration;

  const DarkTransition({required this.childBuilder,
    Key? key,
    this.offset = Offset.zero,
    this.themeController,
    this.radius,
    this.duration = const Duration(milliseconds: 400),
    this.isDark = true}) : super(key: key);

  @override
  State<DarkTransition> createState() => _DarkTransitionState();
}

class _DarkTransitionState extends State<DarkTransition> with SingleTickerProviderStateMixin {


  final _darkNotifier = ValueNotifier<bool>(false);
 bool isDark = true;
  bool isDarkVisible = true;
  @override
  void initState() {
    super.initState();
    isDark = widget.isDark;
    isDarkVisible = widget.isDark;
    if (widget.themeController == null) {
      _animationController = AnimationController(vsync: this, duration: widget.duration);
    } else {
      _animationController = widget.themeController!;
    }
  }

  double _radius(Size size) {
    final maxVal = max(size.width, size.height);
    return maxVal * 1.5;
  }

  late AnimationController _animationController;
  double x = 0;
  double y = 0;
  // bool isDark = true;
  // bool isBottomThemeDark = true;

  late double radius;
  Offset position = Offset.zero;

  ThemeData getTheme(bool dark) {
    if (dark) {
      return ThemeData.dark();
    } else {
      return ThemeData.light();
    }
  }

  @override
  void dispose() {
    _darkNotifier.dispose();
    super.dispose();
  }


  @override
  void didUpdateWidget(DarkTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    _darkNotifier.value = widget.isDark;
    if (widget.isDark != oldWidget.isDark) {
      if (isDark) {
        _animationController.reverse();
        _darkNotifier.value = false;
      } else {
        _animationController.reset();
        _animationController.forward();
        _darkNotifier.value = true;
      }
      position = widget.offset;
    }
    if (widget.radius != oldWidget.radius) {
      _updateRadius();
    }
    if (widget.duration != oldWidget.duration) {
      _animationController.duration = widget.duration;
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _updateRadius();
  }

  void _updateRadius() {
    final size = MediaQuery.of(context).size;
    if (widget.radius == null) {
      radius = _radius(size);
    } else {
      radius = widget.radius!;
    }
  }
  @override
  Widget build(BuildContext context) {
    isDark = _darkNotifier.value;
    Widget body(int index) {
      return ValueListenableBuilder<bool>(
          valueListenable: _darkNotifier,
          builder: (BuildContext context, bool isDark, Widget? child) {
            return Theme(
                data: index == 2 ? getTheme(!isDarkVisible) : getTheme(isDarkVisible),
                child: widget.childBuilder(context, index));
          });
    }

    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              body(1),
              ClipPath(
                  clipper: CircularClipper(_animationController.value * radius, position),
                  child: body(2)),
            ],
          );
        });
  }
}


class CircularClipper extends CustomClipper<Path> {
  const CircularClipper(this.radius, this.center);
  final double radius;
  final Offset center;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.addOval(Rect.fromCircle(radius: radius, center: center));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}