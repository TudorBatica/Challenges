import 'package:challengesapp/application/core/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static Route materialPageRoute() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'User Profile',
      )),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          String text = state.user.email ?? "not signed in";
          return Text(text);
        },
      ),
    );
  }
}
