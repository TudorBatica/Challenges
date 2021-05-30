import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../application/authentication/sign_up_cubit.dart';
import '../../application/common/app_cubit.dart';
import '../../application/navigation/route_names.dart';
import '../common/base_form.dart';
import '../common/button_with_border.dart';

/// Sign up form widget
class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text('Sign up failed. Please, try again.')));
        }
        if (state.status.isSubmissionSuccess) {
          BlocProvider.of<AppCubit>(context).navigateTo(profileRoute);
        }
      },
      child: Align(
        child: BaseForm(
          elements: [
            Text(
              'Sign Up',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 45.0),
            _EmailInput(),
            const SizedBox(height: 25.0),
            _NameInput(),
            const SizedBox(height: 25.0),
            _PasswordInput(),
            const SizedBox(height: 25.0),
            _ConfirmPasswordInput(),
            const SizedBox(height: 45.0),
            _SignUpButton(),
            const SizedBox(height: 25.0),
            _GoToSignInButton()
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) => TextField(
        key: const Key('signUpForm_emailInput_textField'),
        onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'email',
          errorText: state.email.invalid ? 'Email address is not valid' : null,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) => TextField(
        key: const Key('signUpForm_nameInput_textField'),
        onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
        decoration: InputDecoration(
          labelText: 'name',
          errorText: state.name.invalid
              ? 'Please enter a name with at least two characters'
              : null,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) => TextField(
        key: const Key('signUpForm_passwordInput_textField'),
        onChanged: (password) =>
            context.read<SignUpCubit>().passwordChanged(password),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'password',
          errorText: state.password.invalid
              ? '''Passwords should have at least 8 characters and at 
                      least one letter, one number and one special character'''
                  .replaceAll('\n', '')
                  .replaceAll('  ', '')
              : null,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) => TextField(
        key: const Key('signUpForm_confirmPasswordInput_textField'),
        onChanged: (password) =>
            context.read<SignUpCubit>().confirmedPasswordChanged(password),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'confirm password',
          errorText:
              state.confirmedPassword.invalid ? 'passwords do not match' : null,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) => state.status.isSubmissionInProgress
          ? const CircularProgressIndicator()
          : ButtonWithBorder(
              onPressed: state.status.isValidated
                  ? () =>
                      context.read<SignUpCubit>().signUpWithEmailAndPassword()
                  : null,
              text: "SIGN UP",
              borderColor: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
    );
  }
}

class _GoToSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonWithBorder(
      onPressed: () =>
          BlocProvider.of<AppCubit>(context).navigateTo(signInRoute),
      text: "Already have an account? Sign in here.",
      borderColor: Theme.of(context).primaryColor,
      textColor: Theme.of(context).primaryColor,
    );
  }
}
