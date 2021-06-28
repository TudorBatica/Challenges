import 'package:flutter/material.dart';

/// Navbar for narrow screens. Displays the icon for the side drawer.
class NavigationBarMobile extends StatelessWidget {
  /// Drawer key used to open the nav drawer. Passed from the root scaffold.
  final GlobalKey<ScaffoldState> drawerKey;

  /// Constructor
  const NavigationBarMobile({Key? key, required this.drawerKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = 47.5; // about 1.25 cm

    return Container(
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 50.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => drawerKey.currentState?.openDrawer(),
            ),
            Text('Challenges'),
          ],
        ),
      ),
    );
  }
}
