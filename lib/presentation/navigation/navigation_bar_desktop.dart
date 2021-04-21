import 'package:flutter/material.dart';

import 'navigation_item.dart';
import 'route_names.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
