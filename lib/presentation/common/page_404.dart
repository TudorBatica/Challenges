import 'package:challengesapp/presentation/common/scaffold_with_background.dart';
import 'package:flutter/material.dart';

/// Path not found page
class Page404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      child: Center(
        child: Text(
          '404.\nPage not found.',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
