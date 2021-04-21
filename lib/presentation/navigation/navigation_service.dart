import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(String routeName) {
    return _navigatorKey.currentState?.pushNamed(routeName);
  }

  void goBack() {
    return _navigatorKey.currentState?.pop();
  }

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
