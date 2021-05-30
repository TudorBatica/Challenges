import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../domain/common/user.dart';
import 'logged_in_users_only_routes.dart';
import 'navigation_service.dart';
import 'route_names.dart';

/// Navigation Service implementation which uses the built in NavigatorState
@LazySingleton(as: NavigationService)
class NavigationServiceImpl implements NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<dynamic>? navigateTo(String routeName, User user) {
    if (user.identity.isAnonymous &&
        loggedInUsersOnlyRoutes.contains(routeName)) {
      return _navigatorKey.currentState?.pushNamed(signUpRoute);
    }
    return _navigatorKey.currentState?.pushNamed(routeName);
  }

  void goBack() {
    return _navigatorKey.currentState?.pop();
  }

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
