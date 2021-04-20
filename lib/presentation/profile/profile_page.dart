import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/core/app_cubit.dart';

/// User profile page widget
class ProfilePage extends StatelessWidget {
  /// Constructor
  const ProfilePage({Key? key}) : super(key: key);

  /// Returns a `MaterialPageRoute` with a `ProfilePage` builder
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
          return Text(state.user.email ?? "not signed in");
        },
      ),
    );
  }
}
