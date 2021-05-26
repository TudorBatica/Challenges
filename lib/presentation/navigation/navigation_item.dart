import 'package:challengesapp/presentation/common/button_with_border.dart';
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

  // ignore: public_member_api_docs
  final Color borderColor;

  // ignore: public_member_api_docs
  final Color textColor;

  /// Constructor
  const NavigationItem(
      {Key? key,
      required this.name,
      required this.navigationPath,
      this.color,
      required this.borderColor,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWithBorder(
      onPressed: () => getIt<NavigationService>().navigateTo(navigationPath),
      text: name,
      borderColor: borderColor,
      textColor: textColor,
      backgroundColor: color,
    );
  }
}
