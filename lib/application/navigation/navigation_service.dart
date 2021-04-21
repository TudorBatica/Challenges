import 'package:flutter/material.dart';

/// Service which handles navigation
abstract class NavigationService {
  /// Pushes the new route
  Future<dynamic>? navigateTo(String routeName);

  /// Pop current route
  void goBack();

  /// Retrieves the global nav key
  GlobalKey<NavigatorState> get navigatorKey;
}
