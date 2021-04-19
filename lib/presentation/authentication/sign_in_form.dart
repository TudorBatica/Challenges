import 'package:challengesapp/application/authentication/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text('Login failed. Please, try again.')));
        }
      },
      child: Align(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              _EmailInput(),
              const SizedBox(height: 8.0),
              _PasswordInput()
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return TextField(
          key: const Key('signInForm_emailInput_textField'),
          onChanged: (email) => context.read<SignInCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: 'email',
              errorText: state.email.invalid ? 'invalid email address' : null),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(builder: (context, state) {
      return TextField(
        key: const Key('signInForm_passwordInput_textField'),
        onChanged: (password) =>
            context.read<SignInCubit>().passwordChanged(password),
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null),
      );
    });
  }
}

//class
