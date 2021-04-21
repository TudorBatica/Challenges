import 'package:flutter/material.dart';

abstract class NavigationService {
  Future<dynamic>? navigateTo(String routeName);
  void goBack();
  GlobalKey<NavigatorState> get navigatorKey;
}
