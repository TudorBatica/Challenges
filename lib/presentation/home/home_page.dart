import 'package:flutter/material.dart';

/// The home(notifications) page widget.
class HomePage extends StatelessWidget {
  /// Constructor
  const HomePage({Key? key}) : super(key: key);

  /// Returns a `MaterialPageRoute` with a `HomePage` builder
  static Route materialPageRoute() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
