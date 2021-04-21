import 'package:challengesapp/presentation/navigation/navigation_bar.dart';
import 'package:challengesapp/presentation/navigation/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BasePage extends StatelessWidget {
  final Widget? child;

  const BasePage({Key? key, this.child}) : super(key: key);

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
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? NavigationDrawer()
            : null,
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[NavigationBar(), body],
        ),
      ),
    );
  }
}
