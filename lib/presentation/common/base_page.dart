import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../navigation/navigation_bar.dart';
import '../navigation/navigation_drawer.dart';

/// Page layout template
class BasePage extends StatelessWidget {
  /// Content displayed below the navbar(the actual page)
  final Widget? child;

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  /// Constructor
  BasePage({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body = (child != null)
        ? Expanded(
            child: Container(
              child: child,
            ),
          )
        : Container();

    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        key: _drawerKey,
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? NavigationDrawer()
            : null,
        backgroundColor: Colors.white,
        body: Column(
          children: [NavigationBar(drawerKey: _drawerKey), body],
        ),
      ),
    );
  }
}
