import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../application/authentication/sign_in_cubit.dart';
import '../common/base_form.dart';
import '../common/button_with_border.dart';

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
        child: BaseForm(
          elements: [
            Text(
              'Sign In',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 45.0),
            _EmailInput(),
            const SizedBox(height: 25.0),
            _PasswordInput(),
            const SizedBox(height: 45.0),
            _SignInButton(),
            const SizedBox(height: 25.0),
            _GoToSignUpButton()
          ],
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
            errorText: state.email.invalid ? 'invalid email address' : null,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
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
              errorText: state.password.invalid ? 'invalid password' : null,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
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
              : ButtonWithBorder(
                  onPressed: state.status.isValidated
                      ? () => context
                          .read<SignInCubit>()
                          .signInWithEmailAndPassword()
                      : null,
                  text: "Sign In",
                  borderColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                );
        });
  }
}

class _GoToSignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonWithBorder(
      onPressed: () => context.read<SignInCubit>().navigateToSignUpPage(),
      text: "Don't have an account? Sign up here.",
      borderColor: Theme.of(context).primaryColor,
      textColor: Theme.of(context).primaryColor,
    );
  }
}
