import 'package:flutter/material.dart';

import '../../application/navigation/navigation_service.dart';
import '../../dependencies_configuration.dart';

/// The actual navigation item.
class NavigationItem extends StatelessWidget {
  /// Text to display
  final String name;

  /// Navigation path
  final String navigationPath;

  /// Background color
  final Color? color;

  /// Constructor
  const NavigationItem(
      {Key? key, required this.name, required this.navigationPath, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => getIt<NavigationService>().navigateTo(navigationPath),
      child: Container(
        color: color,
        child: Text(
          name,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
