import 'package:flutter/material.dart';

import '../../domain/common/user.dart';

/// Service which handles navigation
abstract class NavigationService {
  /// Pushes the new route
  //Future<dynamic>? navigateTo(String routeName);

  ///TODO: replace navigateTo with this one.
  Future<dynamic>? navigateTo(String routeName, User user);

  /// Pop current route
  void goBack();

  /// Retrieves the global nav key
  GlobalKey<NavigatorState> get navigatorKey;
}
