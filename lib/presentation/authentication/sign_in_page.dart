import 'package:challengesapp/application/authentication/sign_in_cubit.dart';
import 'package:challengesapp/dependencies_configuration.dart';
import 'package:challengesapp/presentation/authentication/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: BlocProvider(
        create: (_) => getIt<SignInCubit>(),
        child: SignInForm(),
      ),
    );
  }
}
