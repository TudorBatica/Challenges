import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'navigation_bar_desktop.dart';
import 'navigation_bar_mobile.dart';

/// Renders the appropriate navbar, based on screen width.
class NavigationBar extends StatelessWidget {
  /// Drawer key used to open the nav drawer. Passed from the root scaffold.
  final GlobalKey<ScaffoldState> drawerKey;

  /// Constructor
  const NavigationBar({Key? key, required this.drawerKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(drawerKey: drawerKey),
      tablet: NavigationBarTabletDesktop(),
    );
  }
}
