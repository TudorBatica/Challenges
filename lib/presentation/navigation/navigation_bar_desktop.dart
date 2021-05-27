import 'package:flutter/material.dart';

import '../../application/navigation/route_names.dart';
import 'navigation_item.dart';

/// Navbar for wide screens. Displays the nav items on the bar itself.
class NavigationBarDesktop extends StatelessWidget {
  /// Constructor
  const NavigationBarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = 66.5; // about 1.75 cm

    return Container(
      height: height,
      child: Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_MainNavElements(), _TrailingNavElements()],
        ),
      ),
    );
  }
}

class _MainNavElements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Logo',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(
          width: 60,
        ),
        NavigationItem(
          name: 'CHALLENGES',
          navigationPath: challengesListRoute,
          textColor: Colors.black,
          borderColor: Colors.white,
        ),
        SizedBox(
          width: 35,
        ),
        NavigationItem(
          name: 'TEAMS',
          navigationPath: profileRoute,
          textColor: Colors.black,
          borderColor: Colors.white,
        )
      ],
    );
  }
}

class _TrailingNavElements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationItem(
          name: 'ENTER ACCOUNT',
          navigationPath: signUpRoute,
          textColor: Colors.white,
          borderColor: Theme.of(context).primaryColor,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(
          width: 20,
        ),
        NavigationItem(
          name: 'HOST',
          navigationPath: hostChallengeRoute,
          textColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
