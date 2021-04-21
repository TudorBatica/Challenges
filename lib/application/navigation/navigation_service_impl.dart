import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'navigation_service.dart';

/// Navigation Service implementation which uses the built in NavigatorState
@LazySingleton(as: NavigationService)
class NavigationServiceImpl implements NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(String routeName) {
    return _navigatorKey.currentState?.pushNamed(routeName);
  }

  void goBack() {
    return _navigatorKey.currentState?.pop();
  }

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
