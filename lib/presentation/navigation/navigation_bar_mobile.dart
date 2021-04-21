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
    return Container(
      height: 80,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => drawerKey.currentState?.openDrawer(),
          ),
          Text('Ciuciu')
        ],
      ),
    );
  }
}
