import 'package:challengesapp/application/navigation/logged_in_users_only_routes.dart';
import 'package:challengesapp/application/navigation/route_names.dart';
import 'package:challengesapp/domain/common/user.dart';
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

  @override
  Future<dynamic>? navigateToo(String routeName, User user) {
    if (user.identity.isAnonymous &&
        loggedInUsersOnlyRoutes.contains(routeName)) {
      return _navigatorKey.currentState?.pushNamed(signUpRoute);
    }
    return _navigatorKey.currentState?.pushNamed(routeName);
  }
}
