import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../application/authentication/sign_in_cubit.dart';

/// Sign in form widget
class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text('Sign in failed. Please, try again.')));
        }
        if (state.status.isSubmissionSuccess) {
          context.read<SignInCubit>().navigateToProfilePage();
        }
      },
      child: Align(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              _EmailInput(),
              const SizedBox(height: 8.0),
              _PasswordInput(),
              const SizedBox(height: 8.0),
              _SignInButton(),
              const SizedBox(height: 8.0),
              _GoToSignUpButton()
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
      buildWhen: (previous, current) => previous.email != current.email,
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
    return BlocBuilder<SignInCubit, SignInState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
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

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: state.status.isValidated
                      ? () => context
                          .read<SignInCubit>()
                          .signInWithEmailAndPassword()
                      : null,
                  child: Text("Sign In"));
        });
  }
}

class _GoToSignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => context.read<SignInCubit>().navigateToSignUpPage(),
        child: Text("Don't have an account? Sign up here."));
  }
}
