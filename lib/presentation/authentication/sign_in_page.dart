import 'package:challengesapp/presentation/common/scaffold_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/authentication/sign_in_cubit.dart';
import '../../dependencies_configuration.dart';
import 'sign_in_form.dart';

/// Sign in page widget
class SignInPage extends StatelessWidget {
  /// Constructor
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      child: BlocProvider(
        create: (_) => getIt<SignInCubit>(),
        child: SignInForm(),
      ),
    );
  }
}
