import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final RouteSettings settings;
  final AxisDirection direction;

  CustomPageRoute(
      {required this.child,
      required this.settings,
      this.direction = AxisDirection.right})
      : super(
          transitionDuration: const Duration(milliseconds: 300),
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: getOffset(),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

  Offset getOffset() {
    switch (direction) {
      case AxisDirection.left:
        return const Offset(1, 0);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      default:
        return const Offset(1, 0);
    }
  }
}
