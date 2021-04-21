import 'package:challengesapp/presentation/authentication/sign_in_page.dart';
import 'package:challengesapp/presentation/authentication/sign_up_page.dart';
import 'package:challengesapp/presentation/home/home_page.dart';
import 'package:challengesapp/presentation/navigation/route_names.dart';
import 'package:challengesapp/presentation/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return _getPageRoute(HomePage(), settings.name.toString());
    case profileRoute:
      return _getPageRoute(ProfilePage(), settings.name.toString());
    case signInRoute:
      return _getPageRoute(SignInPage(), settings.name.toString());
    case signUpRoute:
      return _getPageRoute(SignUpPage(), settings.name.toString());
    default:
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
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
