import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/common/app_cubit.dart';

/// User profile page widget
class ProfilePage extends StatelessWidget {
  /// Constructor
  const ProfilePage({Key? key}) : super(key: key);

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
