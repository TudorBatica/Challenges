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
          name: 'HOME',
          navigationPath: homeRoute,
        ),
        SizedBox(
          width: 35,
        ),
        NavigationItem(
          name: 'CHALLENGES',
          navigationPath: homeRoute,
        ),
        SizedBox(
          width: 35,
        ),
        NavigationItem(
          name: 'CHAT',
          navigationPath: homeRoute,
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
          name: 'SIGN UP',
          navigationPath: signUpRoute,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(
          width: 20,
        ),
        NavigationItem(
          name: 'HOST',
          navigationPath: hostChallengeRoute,
          color: Theme.of(context).primaryColor,
        ),
        Switch(value: true, onChanged: print)
      ],
    );
  }
}
