import 'package:flutter/material.dart';

/// Navbar for narrow screens. Displays the icon for the side drawer.
class NavigationBarMobile extends StatelessWidget {
  /// Constructor
  const NavigationBarMobile({Key? key}) : super(key: key);

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
            onPressed: () {},
          ),
          Text('Ciuciu')
        ],
      ),
    );
  }
}
