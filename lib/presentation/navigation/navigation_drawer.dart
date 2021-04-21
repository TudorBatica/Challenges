import 'package:challengesapp/presentation/navigation/route_names.dart';
import 'package:flutter/material.dart';

import 'navigation_item.dart';

class NavigationDrawer extends StatelessWidget {
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
          ),
          NavigationItem(
            name: 'Sign In',
            navigationPath: signInRoute,
          ),
        ],
      ),
    );
  }
}
