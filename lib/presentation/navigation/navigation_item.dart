import 'package:flutter/material.dart';

import '../../application/navigation/navigation_service.dart';
import '../../dependencies_configuration.dart';

/// The actual navigation item.
class NavigationItem extends StatelessWidget {
  /// Text to display
  final String name;

  /// Navigation path
  final String navigationPath;

  /// Constructor
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
