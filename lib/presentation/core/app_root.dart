import 'package:challengesapp/presentation/authentication/sign_in_page.dart';
import 'package:flutter/material.dart';

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignInPage());
  }
}
