import 'package:flutter/material.dart';

/// Scaffold with the standard background image.
class ScaffoldWithBackground extends StatelessWidget {
  // ignore: public_member_api_docs
  final Widget child;

  // ignore: public_member_api_docs
  const ScaffoldWithBackground({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("../../../web/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
