import 'package:flutter/material.dart';

import '../../application/navigation/route_names.dart';
import 'navigation_item.dart';

/// Side drawer which displays the navbar items.
/// Should be used for mobile(narrow) screens.
class NavigationDrawer extends StatelessWidget {
  /// Constructor
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 16),
        ],
      ),
      child: Column(
        children: <Widget>[
          NavigationItem(
            name: 'Profile',
            navigationPath: profileRoute,
            textColor: Colors.black,
            borderColor: Colors.white,
          ),
          NavigationItem(
            name: 'Sign In',
            navigationPath: signInRoute,
            textColor: Colors.black,
            borderColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
