import 'package:challengesapp/application/navigation/navigation_service.dart';
import 'package:challengesapp/application/navigation/navigation_service_impl.dart';
import 'package:flutter/material.dart';

import '../../dependencies_configuration.dart';

class NavigationItem extends StatelessWidget {
  final String name;
  final String navigationPath;

  const NavigationItem(
      {Key? key, required this.name, required this.navigationPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => getIt<NavigationService>().navigateTo(navigationPath),
      child: Container(
        child: Text(
          name,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
