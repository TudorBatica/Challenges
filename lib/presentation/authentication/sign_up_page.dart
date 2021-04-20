import 'package:challengesapp/application/authentication/sign_up_cubit.dart';
import 'package:challengesapp/dependencies_configuration.dart';
import 'package:challengesapp/presentation/authentication/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route materialPageRoute() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

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
