import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String? previousRoute;
  String? currentRoute;

  Future<dynamic> navigateTo(String routeName) async {
    previousRoute = currentRoute;
    currentRoute = routeName;
    return Future.microtask(() =>
        navigatorKey.currentState!.pushReplacementNamed(routeName)
    );
  }
}