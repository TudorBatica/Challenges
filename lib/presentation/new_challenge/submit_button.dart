import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../application/common/app_cubit.dart';
import '../../application/new_challenge/new_challenge_cubit.dart';
import '../common/button_with_border.dart';

// ignore_for_file: public_member_api_docs

class SubmitButtonWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : _SubmitButton(
                  onPressed: state.status.isValidated
                      ? context.read<NewChallengeCubit>().submitForm
                      : null);
        });
  }
}

class _SubmitButton extends StatelessWidget {
  final Future<void> Function(String, String)? onPressed;

  const _SubmitButton({Key? key, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) => ButtonWithBorder(
        text: 'CREATE CHALLENGE',
        borderColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: (onPressed != null)
            ? () => onPressed!(state.user.identity.id, state.user.profile!.name)
            : null,
      ),
    );
  }
}
