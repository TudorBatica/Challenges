import 'package:flutter/material.dart';

import '../../application/navigation/route_names.dart';
import 'navigation_item.dart';

/// Navbar for wide screens. Displays the nav items on the bar itself.
class NavigationBarTabletDesktop extends StatelessWidget {
  /// Constructor
  const NavigationBarTabletDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = 66.5; // about 1.75 cm

    return Container(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Ciuciu'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NavigationItem(
                name: 'Profile',
                navigationPath: profileRoute,
              ),
              SizedBox(
                width: 60,
              ),
              NavigationItem(
                name: 'Sign In',
                navigationPath: signInRoute,
              ),
            ],
          )
        ],
      ),
    );
  }
}
