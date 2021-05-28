import 'package:challengesapp/presentation/challenge_details/challenge_page.dart';
import 'package:flutter/cupertino.dart';

import '../../presentation/authentication/sign_in_page.dart';
import '../../presentation/authentication/sign_up_page.dart';
import '../../presentation/challenges_list/challenges_list_page.dart';
import '../../presentation/home/home_page.dart';
import '../../presentation/new_challenge/new_challenge_page.dart';
import '../../presentation/profile/profile_page.dart';
import 'route_names.dart';
import 'string_routing_extension.dart';

/// Retrieves the correct route using its path
Route<dynamic> generateRoute(RouteSettings settings) {
  if (settings.name == null) {
    /// default page for anonymous route
    return _getPageRoute(ProfilePage(), settings.name.toString());
  }

  final routingData = settings.name!.toRoutingData;
  switch (routingData.route) {
    case homeRoute:
      return _getPageRoute(HomePage(), routingData.route);
    case profileRoute:
      return _getPageRoute(ProfilePage(), routingData.route);
    case signInRoute:
      return _getPageRoute(SignInPage(), routingData.route);
    case signUpRoute:
      return _getPageRoute(SignUpPage(), routingData.route);
    case hostChallengeRoute:
      return _getPageRoute(NewChallengePage(), routingData.route);
    case challengesListRoute:
      if (routingData.queryParams.isEmpty ||
          routingData.queryParams['id'] == null ||
          routingData.queryParams['id']!.isEmpty) {
        return _getPageRoute(ChallengesListPage(), routingData.route);
      }
      return _getPageRoute(
          ChallengePage(routingData.queryParams['id'].toString()),
          Uri(path: routingData.route, queryParameters: routingData.queryParams)
              .toString());
    default:
      //TODO: replace with 404
      return _getPageRoute(ProfilePage(), settings.name.toString());
  }
}

PageRoute _getPageRoute(Widget child, String routeName) {
  return _FadeRoute(child: child, routeName: routeName);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({required this.child, required this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
