import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/authentication/sign_up_cubit.dart';
import '../../dependencies_configuration.dart';
import 'sign_up_form.dart';

/// Sign up page widget
class SignUpPage extends StatelessWidget {
  /// Constructor
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<SignUpCubit>(),
        child: SignUpForm(),
      ),
    );
  }
}
